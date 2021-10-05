"""
Solve the minimum spanning tree problem with Kruskal's algorithm
"""

import pandas as pd
import numpy as np
import itertools

# setup inicial
df = pd.read_csv("exercise1.csv")
df = df.replace(
    to_replace=0, value=np.inf
)  # ajuste para os valores 0 nunca serem escolhidos

QTD_NOS = 15

# algoritmo de Kruskal
# passo 1
C = [0]  # nós rotulados
D = list(range(1, QTD_NOS, 1))  # nós não rotulados
T = []  # guarda os conjuntos da árvore mínima
LT = 0  # custo total da árvore mínima

counter = 1

# passo 2
while len(D) != 0:

    print(f"Iteração: {counter}")

    tmp_menor_dist = np.inf
    tmp_menor_arco = []

    combinations = itertools.product(C, D)

    for i, comb in enumerate(combinations, 1):

        if df.iat[comb] < tmp_menor_dist:
            tmp_menor_dist = df.iat[comb]
            tmp_menor_arco = comb

    print(
        f"Resumo da Iteração {counter}:\nMenor dist: {tmp_menor_dist}, Arco: {tmp_menor_arco}\n"
    )

    C.append(tmp_menor_arco[1])
    D.remove(tmp_menor_arco[1])
    T.append((tmp_menor_arco[0] + 1, tmp_menor_arco[1] + 1))
    LT += tmp_menor_dist

    counter += 1


print(f"Resumo:\nÁrvore geradora mínima: {T}\nDistância mínima: {LT}")
