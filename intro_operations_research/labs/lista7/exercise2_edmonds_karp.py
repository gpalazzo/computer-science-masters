from scipy.sparse import csr_matrix
from scipy.sparse.csgraph import maximum_flow
import pandas as pd

df = pd.read_csv("exercise2.csv")

# ajusta estrutura de dados para o algoritmo
lista_fluxos = df.to_numpy().tolist()

grafo_orientado = csr_matrix(lista_fluxos)

# 0 e 6 na verdade representam os nos 1 e 7, porque a estrutura de dados comeca em 0
max_flow = maximum_flow(grafo_orientado, 0, 6)

# output
print(f"O fluxo máximo é: {max_flow.flow_value}")
