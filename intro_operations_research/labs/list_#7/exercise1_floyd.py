"""
Find minimum distance between pair of nodes using Floyd's algorithm
"""


import pandas as pd
from typing import List


# Algorithm
def floyd(G):

    dist = list(map(lambda p: list(map(lambda q: q, p)), G))

    # Adding vertices individually
    for r in range(QTD_NOS):
        for p in range(QTD_NOS):
            for q in range(QTD_NOS):
                dist[p][q] = min(dist[p][q], dist[p][r] + dist[r][q])
    sol(dist)


# Printing the output
def sol(dist):
    for p in range(QTD_NOS):
        for q in range(QTD_NOS):
            if dist[p][q] == INF:
                print("INF", end=" ")
            else:
                print(dist[p][q], end="  ")
        print(" ")


def parse_generate_edges(_df: pd.DataFrame):

    return _df.to_numpy().tolist()


df = pd.read_csv("exercise1.csv")
QTD_NOS = 15
INF = 9999

graph_list = parse_generate_edges(_df=df)

floyd(graph_list)
