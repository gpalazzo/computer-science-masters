"""
Solve the minimum spanning tree problem with Kruskal's algorithm
"""

import pandas as pd
from typing import List


class Edge:
    def __init__(self, arg_src, arg_dst, arg_weight):
        self.src = arg_src
        self.dst = arg_dst
        self.weight = arg_weight


class Graph:
    def __init__(self, arg_num_nodes, arg_edgelist):
        self.num_nodes = arg_num_nodes
        self.edgelist = arg_edgelist
        self.parent = []
        self.rank = []
        # mst stores edges of the minimum spanning tree
        self.mst = []

    def FindParent(self, node):
        # With path-compression.
        if node != self.parent[node]:
            self.parent[node] = self.FindParent(self.parent[node])
        return self.parent[node]

        # Without path compression
        # if node == self.parent[node]:
        #     return node
        # return self.FindParent(self.parent[node])

    def KruskalMST(self):

        # Sort objects of an Edge class based on attribute (weight)
        self.edgelist.sort(key=lambda Edge: Edge.weight)

        self.parent = [None] * self.num_nodes
        self.rank = [None] * self.num_nodes

        for n in range(self.num_nodes):
            self.parent[n] = n  # Every node is the parent of itself at the beginning
            self.rank[n] = 0  # Rank of every node is 0 at the beginning

        for edge in self.edgelist:
            root1 = self.FindParent(edge.src)
            root2 = self.FindParent(edge.dst)

            # Parents of the source and destination nodes are not in the same subset
            # Add the edge to the spanning tree
            if root1 != root2:
                self.mst.append(edge)
                if self.rank[root1] < self.rank[root2]:
                    self.parent[root1] = root2
                    self.rank[root2] += 1
                else:
                    self.parent[root2] = root1
                    self.rank[root1] += 1

        print("\nEdges of minimum spanning tree in graph :", end=" ")
        cost = 0
        for edge in self.mst:
            print(
                "["
                + str(edge.src)
                + "-"
                + str(edge.dst)
                + "]("
                + str(edge.weight)
                + ")",
                end=" ",
            )
            cost += edge.weight
        print("\nCost of minimum spanning tree : " + str(cost))


def parse_generate_edges(df: pd.DataFrame) -> List[Edge]:

    data = df.to_dict(orient="index")
    all_edges = []

    for src, dst_dict in data.items():
        for dst, weight in dst_dict.items():
            edge_dict = {"arg_src": src + 1, "arg_dst": int(dst), "arg_weight": weight}
            all_edges.append(Edge(**edge_dict))

    return all_edges


def main():

    df = pd.read_csv("exercise1.csv")
    edges_data = parse_generate_edges(df=df)

    # Edge(source, destination, weight)
    num_nodes = 16

    g1 = Graph(num_nodes, edges_data)
    g1.KruskalMST()


if __name__ == "__main__":
    main()
