from scipy.sparse import csr_matrix
from scipy.sparse.csgraph import minimum_spanning_tree
import pandas as pd


# carrega dados
df = pd.read_csv("exercise1.csv")

# ajusta estrutura de dados para o algoritmo
lista_distancias = df.to_numpy().tolist()

# gera matriz esparsa
grafo = csr_matrix(lista_distancias)

# aplica algoritmo de Kruskal
mst = minimum_spanning_tree(grafo)

print(mst.toarray().astype(int))
