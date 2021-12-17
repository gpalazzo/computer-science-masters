import os
import glob
import gzip
import shutil
import pandas as pd

from datetime import date
from haversine import haversine


class Fire():
    """
        Author:  Aline Rodrigues
        Created: 25/11/2021
        Execute data transformation
    """
    
    def __init__(self) -> None:
        self.path_data = os.path.dirname(os.path.realpath(__file__)) + '/dataset'
        self.stations = {}
        
        self.cols = ['PRECIPITACAO TOTAL, HORARIO(mm)',                    'PRESSAO ATMOSFERICA AO NIVEL DA ESTACAO, HORARIA(mB)',
                     'PRESSAO ATMOSFERICA REDUZIDA NIVEL DO MAR, AUT(mB)', 'PRESSAO ATMOSFERICA MAX.NA HORA ANT. (AUT)(mB)',
                     'PRESSAO ATMOSFERICA MIN. NA HORA ANT. (AUT)(mB)',    'RADIACAO GLOBAL(Kj/m²)',
                     'TEMPERATURA DO AR - BULBO SECO, HORARIA(°C)',        'TEMPERATURA DO PONTO DE ORVALHO(°C)',
                     'TEMPERATURA MAXIMA NA HORA ANT. (AUT)(°C)',          'TEMPERATURA MINIMA NA HORA ANT. (AUT)(°C)',
                     'TEMPERATURA ORVALHO MAX. NA HORA ANT. (AUT)(°C)',    'TEMPERATURA ORVALHO MIN. NA HORA ANT. (AUT)(°C)',
                     'UMIDADE REL. MAX. NA HORA ANT. (AUT)(%)',            'UMIDADE REL. MIN. NA HORA ANT. (AUT)(%)',
                     'UMIDADE RELATIVA DO AR, HORARIA(%)',                 'VENTO, DIRECAO HORARIA (gr)(° (gr))',
                     'VENTO, RAJADA MAXIMA(m/s)',                          'VENTO, VELOCIDADE HORARIA(m/s)']
        
    
    def map_stations(self):
        stations = glob.glob(self.path_data + '/INMET_METEOROLOGIA_ESTACOES/dados_*_H_*.csv')
        
        # convert csv to parquet to otimize queries
        self.convert_csv_to_parquet(stations)
                
        for station in stations:
            f = open(station, 'r')
            f.readline()

            code = f.readline().split(':')[1].replace(' ', '').replace('\n', '')
            lon = float(f.readline().split(':')[1].replace(' ',''))
            lat = float(f.readline().split(':')[1].replace(' ',''))

            date_file = station.split('/')
            date_file = date_file[len(date_file)-1].replace('.csv', '')
            date_file = date_file.split('_')
            
            self.stations[code] = {'lat': lat, 'lon': lon, 'file': station.replace('.csv', '.parquet'),
                                   'date_start': date(int(date_file[3].split('-')[0]), int(date_file[3].split('-')[1]), int(date_file[3].split('-')[2])),
                                   'date_end':   date(int(date_file[4].split('-')[0]), int(date_file[4].split('-')[1]), int(date_file[4].split('-')[2]))}
            f.close()
            
            
    def convert_csv_to_parquet(self, stations):
        files = glob.glob(self.path_data + '/INMET_METEOROLOGIA_ESTACOES/dados_*_H_*.parquet')

        if len(files) == 0:
            self.extract_file()
            self.clean_files()
            
            for station in stations:
                df = pd.read_csv(station, sep=';', skiprows=10, dtype={'Hora Medicao': str}, decimal=',')
                df.to_parquet(station.replace('.csv', '.parquet'))
                
    
    def convert_transformation_to_parquet(self):
        df = pd.read_csv(self.path_data + '/fire.csv')
        df.to_parquet(self.path_data + '/fire.parquet')
        
    
    def merge_data(self):        
        f = open(self.path_data + '/fire.csv', 'r')
        data = ''
        line = f.readline()
        while line != '' and line != '\n':
            line = line.split(';')
            del line[0]
            del line[2]
            del line[4]
            data += ';'.join(line)
            
            line = f.readline()
        
        f = open(self.path_data + '/fire_merged.csv', 'w')
        f.write(data)
        f.close()
        
        files = glob.glob(self.path_data + '/INMET_METEOROLOGIA_ESTACOES/dados_*_H_*.csv')
        
        for file in files:
            print(file)
            data = ''
            f = open(file, 'r')
            
            f.readline()
            code = f.readline().split(':')[1].replace(' ', '').replace('\n', '')
            for i in range(0, 8): f.readline()
            header = f.readline().split(';')
            line = f.readline()
            
            while line != '' and line != '\n':
                line = line.replace(',', '.').replace('null', 'nan')
                line = line.split(';')
                date = line[0]
                time = line[1][0:2]+':'+line[1][2:4]
                data += f'{date} {time}:00;nan;nan;nan;nan;{code}'
                
                for i in range(0, len(header)):
                    for col in self.cols:
                        if header[i] == col:
                            data += f';{line[i]}'
                            break
                
                data += '\n'
                line = f.readline()
            
            f = open(self.path_data + '/fire_merged.csv', 'a')
            f.write(data)
            f.close()
        
        
    def extract_file(self):
         files = glob.glob(self.path_data + '/INMET_METEOROLOGIA_ESTACOES/dados_*_H_*.csv.gz')
         
         for file in files:
            with gzip.open(file, 'rb') as f_in:
                file = file.replace('.gz', '')
                with open(file, 'wb') as f_out:
                    shutil.copyfileobj(f_in, f_out)
    
    def clean_files(self):
        files = glob.glob(self.path_data + '/INMET_METEOROLOGIA_ESTACOES/dados_*_H_*.csv')
        data = ''
        for file in files:
            f = open(file, 'r')
            data = f.readline()
            for i in range(0, 10): data += f.readline()
            line = f.readline()

            while line != '' and line != '\n':
                if '00;null;null;null;null;null;null;null;null;null;null;null;null;null;null;null;null;null;null;null;null;' not in line:
                    data += line
                line = f.readline()
                
            f.close()
            
            f = open(file, 'w')
            f.write(data)
            f.close()
            
    def create_file_csv(self, header):  
        header = header.replace('\n', '') + ';distancia foco/estacao (km);estacao'
        
        for col in self.cols:
            header += f';{col.lower()}'
        header += '\n'
        
        f = open(self.path_data + '/fire.csv', 'w')
        f.write(header)
        f.close()
        
        
    def get_distances(self, fire):
        distances = {}
        fire = fire.split(';')
        lat = float(fire[4])
        lon = float(fire[5])
        
        for code in self.stations.keys():
            station = (self.stations[code]['lat'], self.stations[code]['lon'])
            fire = (lat, lon)
            distances[code] = haversine(station, fire)
        
        distances = sorted(distances.items(), key=lambda x: x[1])
        return distances


    def set_climate(self, distances, row):
        fire      = row.split(';')
        date_fire = fire[1].split(' ')[0].split('-')
        date_fire = date(int(date_fire[0]), int(date_fire[1]), int(date_fire[2]))
        hours1    = int(fire[1].split(' ')[1][0:2])
        minutes   = int(fire[1].split(' ')[1][3:5])
        
        if minutes > 30:
            hours2 = hours1 + 1 if hours1 != 23 else 0
        else:
            hours2 = hours1 - 1 if hours1 != 0 else 23 

        for dist in distances:
            if date_fire >= self.stations[dist[0]]['date_start'] and date_fire <= self.stations[dist[0]]['date_end']:
                df = pd.read_parquet(self.stations[dist[0]]['file'])
                df = df[ (~df['PRECIPITACAO TOTAL, HORARIO(mm)'].isnull()) & \
                        (df['Data Medicao'] == str(date_fire)) & \
                        ((df['Hora Medicao'] == f'{str(hours1)[0:2]}00') | (df['Hora Medicao'] == f'{str(hours2)[0:2]}00'))]
                        #(df['Hora Medicao'].isin([f'{str(hours1)[0:2]}00', f'{str(hours2)[0:2]}00'])) ]
                
                if not df.empty:
                    print(dist[1])
                    row = row.replace('\n', '') + f';{dist[1]};{dist[0]}'
                    
                    for col in self.cols:
                        row += f';{float(df[col].iloc[0])}'
                    row += '\n' 
            
                    f = open(self.path_data + '/fire.csv', 'a')
                    f.write(row)
                    f.close()
                    break

    def initialize_transformation(self):
        self.map_stations()
        f = open(self.path_data + '/focos_ocorrencias_2003_2020_cerrado_programa_queimadas_inpe.csv', 'r')
        
        header = f.readline()
        self.create_file_csv(header)
        line = f.readline()
    
        while line != '' and line != '\n':
            distances = self.get_distances(line)
            self.set_climate(distances, line)
            line = f.readline()
        
        self.convert_transformation_to_parquet()
                  
                        
if __name__=="__main__":
    """
        Author:  Aline Rodrigues
        Created: 25/11/2021
        Run data transformation
    """ 
    
    try:
        fire = Fire()
        fire.initialize_transformation()
        #fire.merge_data()
    except Exception as error:
        print (f'Error: {error}')
        