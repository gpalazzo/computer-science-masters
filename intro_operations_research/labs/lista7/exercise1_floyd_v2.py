from scipy.sparse import csr_matrix
from scipy.sparse.csgraph import floyd_warshall
import pandas as pd


def recria_caminho_pred(pred, i, j):
    path = [j]
    k = j
    while pred[i, k] != -9999:  # -9999 é o output padrao do scipy para inconsistencias
        path.append(pred[i, k])
        k = pred[i, k]
    return [_path + 1 for _path in path[::-1]]


def parse_output(dist, pred, i, j):
    caminho = recria_caminho_pred(pred=pred, i=i, j=j)

    return dist[i][j], caminho


df = pd.read_csv("exercise1.csv")

# ajusta estrutura de dados para o algoritmo
lista_distancias = df.to_numpy().tolist()

grafo = csr_matrix(lista_distancias)

dist, pred = floyd_warshall(csgraph=grafo, directed=False, return_predecessors=True)

dist_2_15, caminho_pred_2_15 = parse_output(dist=dist, pred=pred, i=1, j=14)
dist_3_8, caminho_pred_3_8 = parse_output(dist=dist, pred=pred, i=2, j=7)
dist_11_12, caminho_pred_11_12 = parse_output(dist=dist, pred=pred, i=10, j=11)

# output
print(
    f"Resumo nós 2 e 15\nCaminho mínimo: {caminho_pred_2_15}\nDistância mínima: {dist_2_15}"
)
print(
    f"\nResumo nós 3 e 8\nCaminho mínimo: {caminho_pred_3_8}\nDistância mínima: {dist_3_8}"
)
print(
    f"\nResumo nós 11 e 12\nCaminho mínimo: {caminho_pred_11_12}\nDistância mínima: {dist_11_12}"
)
