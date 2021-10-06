from scipy.sparse import csr_matrix
from scipy.sparse.csgraph import dijkstra
import pandas as pd

# setup inicial
NO_TARGET = 2

# carrega dados
df = pd.read_csv("exercise1.csv")

# ajusta estrutura de dados para o algoritmo
lista_distancias = df.to_numpy().tolist()

# gera matriz esparsa
grafo = csr_matrix(lista_distancias)

# aplica algoritmo de Dijkstra
# indices = NO_TARGET - 1 porque começa em 0
distancias = dijkstra(csgraph=grafo, directed=False, indices=NO_TARGET - 1)

# output
print(
    f"Menores distâncias do nó {NO_TARGET} em relação aos demais são descritas a seguir:"
)
for i, dist in enumerate(distancias, 1):
    if i == NO_TARGET:
        continue
    print(f"{NO_TARGET} -> {i} = {dist}")
