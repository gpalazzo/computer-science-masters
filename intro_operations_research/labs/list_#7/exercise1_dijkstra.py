"""
Find minimum distance between nodes using Dijkstra's algorithm
"""

import pandas as pd
from queue import PriorityQueue


class Graph:
    def __init__(self, num_of_vertices):
        self.v = num_of_vertices
        self.edges = [
            [-1 for i in range(num_of_vertices)] for j in range(num_of_vertices)
        ]
        self.visited = []

    def add_edge(self, u, v, weight):
        self.edges[u][v] = weight
        self.edges[v][u] = weight

    def dijkstra(self, start_vertex):
        D = {v: float("inf") for v in range(self.v)}
        D[start_vertex] = 0

        pq = PriorityQueue()
        pq.put((0, start_vertex))

        while not pq.empty():
            (dist, current_vertex) = pq.get()
            self.visited.append(current_vertex)

            for neighbor in range(self.v):
                if self.edges[current_vertex][neighbor] != -1:
                    distance = self.edges[current_vertex][neighbor]
                    if neighbor not in self.visited:
                        old_cost = D[neighbor]
                        new_cost = D[current_vertex] + distance
                        if new_cost < old_cost:
                            pq.put((new_cost, neighbor))
                            D[neighbor] = new_cost
        return D


def parse_generate_edges(_graph: Graph, _df: pd.DataFrame) -> Graph:

    data = _df.to_dict(orient="index")

    for src, dst_dict in data.items():
        for dst, weight in dst_dict.items():
            edge_dict = {"u": src + 1, "v": int(dst), "weight": weight}
            _graph.add_edge(**edge_dict)

    return _graph


df = pd.read_csv("exercise1.csv")
QTD_NOS = 16
TARGET_NODE = 2
g = Graph(QTD_NOS)

graph = parse_generate_edges(_graph=g, _df=df)

D = graph.dijkstra(TARGET_NODE)

for vertex in range(len(D)):
    print(f"Distance from vertex {TARGET_NODE} to vertex {vertex} is {D[vertex]}")
