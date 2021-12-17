"""
Encontra a distancia minima entre todos os nos
"""


import pandas as pd


def Floyd(distancias):

    dist = list(map(lambda p: list(map(lambda q: q, p)), distancias))

    # loop incremental entre todos os nos
    for r in range(QTD_NOS):
        for p in range(QTD_NOS):
            for q in range(QTD_NOS):
                dist[p][q] = min(dist[p][q], dist[p][r] + dist[r][q])

    mostra_output(dist)


def mostra_output(dist):
    for p in range(QTD_NOS):
        for q in range(QTD_NOS):
            if dist[p][q] == INF:
                print("INF", end=" ")
            else:
                print(dist[p][q], end="  ")
        print(" ")


def gerar_arestas(_df: pd.DataFrame):

    return _df.to_numpy().tolist()


df = pd.read_csv("exercise1.csv")
QTD_NOS = 15  # numero de nos (total de nos + 1)
INF = 9999  # valor para representar infinito

lista_distancias = gerar_arestas(_df=df)

Floyd(lista_distancias)
