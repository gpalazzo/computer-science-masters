"""
Encontrar a arvore minima pelo algoritmo de Kruskal
"""

import pandas as pd
from typing import List


class Arestas:
    def __init__(self, origem, destino, distancia):
        self.origem = origem
        self.destino = destino
        self.distancia = distancia


class Grafo:
    def __init__(self, qtd_nos, lista_arestas):
        self.qtd_nos = qtd_nos
        self.lista_arestas = lista_arestas
        self.parente = []
        self.rank = []
        self.resultado = []

    def encontrar_parente(self, no):
        if no != self.parente[no]:
            self.parente[no] = self.encontrar_parente(self.parente[no])
        return self.parente[no]

    def kruskal(self):

        # ordena objetos baseado na distancia da aresta
        self.lista_arestas.sort(key=lambda aresta: aresta.distancia)

        self.parente = [None] * self.qtd_nos
        self.rank = [None] * self.qtd_nos

        for n in range(self.qtd_nos):
            self.parente[n] = n
            self.rank[n] = 0  # rank de todos os nos e 0 no inicio

        for aresta in self.lista_arestas:
            root1 = self.encontrar_parente(aresta.origem)
            root2 = self.encontrar_parente(aresta.destino)

            if root1 != root2:
                self.resultado.append(aresta)
                if self.rank[root1] < self.rank[root2]:
                    self.parente[root1] = root2
                    self.rank[root2] += 1
                else:
                    self.parente[root2] = root1
                    self.rank[root1] += 1

        print("\nArestas da árvore geradora mínima:", end="\n")
        custo = 0
        for aresta in self.resultado:
            print(
                "["
                + str(aresta.origem)
                + "-"
                + str(aresta.destino)
                + "]("
                + str(aresta.distancia)
                + ")",
                end="\n",
            )
            custo += aresta.distancia
        print("\nCusto da árvore geradora mínima: " + str(custo))


def gerar_arestas(df: pd.DataFrame) -> List[Arestas]:

    data = df.to_dict(orient="index")
    todas_arestas = []

    for origem, destino_dict in data.items():
        for destino, distancia in destino_dict.items():
            arestas_dict = {
                "origem": origem + 1,
                "destino": int(destino),
                "distancia": distancia,
            }
            todas_arestas.append(Arestas(**arestas_dict))

    return todas_arestas


def main():

    df = pd.read_csv("exercise1.csv")
    dados_arestas = gerar_arestas(df=df)

    QTD_NOS = 16

    grafo = Grafo(QTD_NOS, dados_arestas)
    grafo.kruskal()


if __name__ == "__main__":
    main()
