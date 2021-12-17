"""
Encontra distancia minima entre 2 nos
"""

import pandas as pd
from queue import PriorityQueue


class Grafo:
    def __init__(self, qtd_vertices):
        self.v = qtd_vertices
        self.arestas = [[-1 for i in range(qtd_vertices)] for j in range(qtd_vertices)]
        self.visitados = []

    def adicionar_arestas(self, u, v, dist):
        self.arestas[u][v] = dist
        self.arestas[v][u] = dist

    def dijkstra(self, vertice_inicio):
        D = {v: float("inf") for v in range(self.v)}
        D[vertice_inicio] = 0

        pq = PriorityQueue()
        pq.put((0, vertice_inicio))

        while not pq.empty():
            (dist, vertice_atual) = pq.get()
            self.visitados.append(vertice_atual)

            for vertice_vizinho in range(self.v):
                if self.arestas[vertice_atual][vertice_vizinho] != -1:
                    distancia = self.arestas[vertice_atual][vertice_vizinho]
                    if vertice_vizinho not in self.visitados:
                        custo_antigo = D[vertice_vizinho]
                        custo_novo = D[vertice_atual] + distancia
                        if custo_novo < custo_antigo:
                            pq.put((custo_novo, vertice_vizinho))
                            D[vertice_vizinho] = custo_novo
        return D


def gerar_arestas(_grafo: Grafo, _df: pd.DataFrame) -> Grafo:

    data = _df.to_dict(orient="index")

    for u, v_dict in data.items():
        for v, dist in v_dict.items():
            arestas_dict = {"u": u + 1, "v": int(v), "dist": dist}
            _grafo.adicionar_arestas(**arestas_dict)

    return _grafo


df = pd.read_csv("exercise1.csv")  # carrega dados

QTD_NOS = 16  # numero de nos (total de nos + 1)
NO_TARGET = 2  # no para calcular as distancias minimas contra todos os outros

_grafo = Grafo(QTD_NOS)
grafo = gerar_arestas(_grafo=_grafo, _df=df)
D = grafo.dijkstra(NO_TARGET)

for vertices in range(len(D)):
    print(f"Distancia do vertice {NO_TARGET} para o vertice {vertices} e {D[vertices]}")
