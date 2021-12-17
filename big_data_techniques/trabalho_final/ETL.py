import pandas as pd
import numpy as np
from haversine import haversine
import os
import warnings


arxs = os.listdir(
    "ITA/INMET_METEOROLOGIA_ESTACOES/$2a$10$zFKmy13PLWETldLA0JGKHuxNIMgkv1a3QUUkjPunnQ5eEMHnvAGmW/"
)

warnings.filterwarnings("ignore")


def AchandoAquivoList(ref):

    matchers = [ref]
    matching = [s for s in arxs if any(xs in s for xs in matchers)]
    # matching=filter(lambda x: ref in x, arquivos)

    for arquivo in matching:

        if arquivo[6 : arquivo[6:].index("_") + 6] == ref:
            if arquivo[-3:] == ".gz":
                inmet = pd.read_csv(
                    "ITA/INMET_METEOROLOGIA_ESTACOES/$2a$10$zFKmy13PLWETldLA0JGKHuxNIMgkv1a3QUUkjPunnQ5eEMHnvAGmW/"
                    + arquivo,
                    compression="gzip",
                    header=9,
                    sep=";",
                    error_bad_lines=False,
                )
                return inmet

            elif arquivo[-4:] == ".csv":
                inmet = pd.read_csv(
                    "ITA/INMET_METEOROLOGIA_ESTACOES/$2a$10$zFKmy13PLWETldLA0JGKHuxNIMgkv1a3QUUkjPunnQ5eEMHnvAGmW/"
                    + arquivo,
                    header=9,
                    sep=";",
                    error_bad_lines=False,
                )
                return inmet

    return pd.DataFrame()


def Distancia(temp, lat, long):

    resultado = []

    for i in range(temp.shape[0]):
        resultado.append(haversine((lat, long), (temp.iloc[i, 4], temp.iloc[i, 3])))

    return resultado


def Tratamento(inmet):

    inmet = inmet[
        [
            "Data Medicao",
            "Hora Medicao",
            "PRECIPITACAO TOTAL, HORARIO(mm)",
            "PRESSAO ATMOSFERICA AO NIVEL DA ESTACAO, HORARIA(mB)",
            "PRESSAO ATMOSFERICA REDUZIDA NIVEL DO MAR, AUT(mB)",
            "PRESSAO ATMOSFERICA MAX.NA HORA ANT. (AUT)(mB)",
            "PRESSAO ATMOSFERICA MIN. NA HORA ANT. (AUT)(mB)",
            "RADIACAO GLOBAL(Kj/m²)",
            "TEMPERATURA DA CPU DA ESTACAO(°C)",
            "TEMPERATURA DO AR - BULBO SECO, HORARIA(°C)",
            "TEMPERATURA DO PONTO DE ORVALHO(°C)",
            "TEMPERATURA MAXIMA NA HORA ANT. (AUT)(°C)",
            "TEMPERATURA MINIMA NA HORA ANT. (AUT)(°C)",
            "TEMPERATURA ORVALHO MAX. NA HORA ANT. (AUT)(°C)",
            "TEMPERATURA ORVALHO MIN. NA HORA ANT. (AUT)(°C)",
            "TENSAO DA BATERIA DA ESTACAO(V)",
            "UMIDADE REL. MAX. NA HORA ANT. (AUT)(%)",
            "UMIDADE REL. MIN. NA HORA ANT. (AUT)(%)",
            "UMIDADE RELATIVA DO AR, HORARIA(%)",
            "VENTO, DIRECAO HORARIA (gr)(° (gr))",
            "VENTO, RAJADA MAXIMA(m/s)",
            "VENTO, VELOCIDADE HORARIA(m/s)",
        ]
    ]

    for i in range(2, len(inmet.columns)):
        inmet[inmet.columns[i]] = inmet[inmet.columns[i]].apply(
            lambda x: float(str(x).replace(",", "."))
        )

    inmet[inmet.columns[0]] = pd.to_datetime(inmet[inmet.columns[0]])
    inmet[inmet.columns[1]] = inmet[inmet.columns[1]].astype(int)
    return inmet


df = pd.read_csv("ITA/CatalogoEstaçõesAutomáticas.csv", sep=";")
df1 = pd.read_csv(
    "ITA/focos_ocorrencias_2003_2020_cerrado_programa_queimadas_inpe.csv", sep=";"
)
estados = pd.read_csv(
    "https://raw.githubusercontent.com/leogermani/estados-e-municipios-ibge/master/estados.csv"
)

df1.estado = df1.estado.apply(lambda x: x.lower())
estados.NOME = estados.NOME.apply(lambda x: x.lower())
estados.SIGLA = estados.SIGLA.apply(lambda x: x.strip())

df1 = df1.merge(estados, left_on="estado", right_on="NOME", how="inner").drop(
    ["COD", "NOME", "geometria"], axis=1
)
df1.drop(["id_foco"], axis=1, inplace=True)
df1.data_hora = pd.to_datetime(df1.data_hora)

df.VL_LATITUDE = df.VL_LATITUDE.apply(lambda x: x.replace(",", ".")).astype(float)
df.VL_LONGITUDE = df.VL_LONGITUDE.apply(lambda x: x.replace(",", ".")).astype(float)
df.VL_ALTITUDE = df.VL_ALTITUDE.apply(lambda x: x.replace(",", ".")).astype(float)

df.drop(["DT_INICIO_OPERACAO"], axis=1, inplace=True)
df.columns = [
    "DC_NOME",
    "SG_ESTADO",
    "CD_SITUACAO",
    "VL_LONGITUDE",
    "VL_LATITUDE",
    "VL_ALTITUDE",
    "CD_ESTACAO",
]


final = []
# for est in df1.SIGLA.unique():

for est in ["RO"]:
    df2 = df1[df1.SIGLA == est]
    os.mkdir("ITA/analise/" + est)
    print(est)

    for i in range(df2.shape[0]):
        temp = df[df.SG_ESTADO == df2.iloc[i, 5]]
        temp["distancia"] = Distancia(temp, df2.iloc[i, 3], df2.iloc[i, 4])
        temp = temp.sort_values(by="distancia").iloc[0, :].to_frame().T
        ref = (
            df2.iloc[0, :]
            .to_frame()
            .T.merge(temp, left_on="SIGLA", right_on="SG_ESTADO")
            .drop(["SG_ESTADO", "VL_LATITUDE", "VL_LONGITUDE", "distancia"], axis=1)
        )

        final.append(ref)

df = pd.concat(final)
resultado = []

for estacao in df.CD_ESTACAO.unique():

    temp = df[df.CD_ESTACAO == estacao]
    inmet = AchandoAquivoList(estacao)

    if inmet.shape[0] == 0:
        continue

    inmet = Tratamento(inmet)
    inmet["estado"] = temp.estado.values[0]
    inmet["bioma"] = temp.bioma.values[0]
    inmet["latitude"] = temp.latitude.values[0]
    inmet["longitude"] = temp.longitude.values[0]
    inmet["SIGLA"] = temp.SIGLA.values[0]
    inmet["DC_NOME"] = temp.DC_NOME.values[0]
    inmet["CD_SITUACAO"] = temp.CD_SITUACAO.values[0]
    inmet["VL_ALTITUDE"] = temp.VL_ALTITUDE.values[0]
    inmet["CD_ESTACAO"] = temp.CD_ESTACAO.values[0]
    inmet["INDENDIO"] = 0

    for i in range(temp.shape[0]):
        indice = inmet[
            np.logical_and(
                inmet.iloc[:, 0] == str(temp.iloc[i, :].data_hora)[:10],
                inmet.iloc[:, 1] == int(temp.iloc[i, :].data_hora[11:13] + "00"),
            )
        ]

        if indice.shape[0] > 0:
            indice = indice.index[0]
            inmet.loc[indice, "INDENDIO"] = 1

    resultado.append(inmet)

df_ultimo = pd.concat(resultado)

df_ultimo.to_csv("ITA/analise/df.csv", index=False)
