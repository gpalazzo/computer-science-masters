import pandas as pd
from ortools.graph import pywrapgraph
from typing import List


def parse_input(df: pd.DataFrame, total_nos: int) -> List[int]:
    """
    Input exemplo
        start_nodes = [0, 0, 1,2, 2, 3,3,4,5]
        end_nodes =   [1, 2, 3,3, 4, 5,6,5,6]
        capacities =  [6, 7, 3, 5, 4, 4,2,5,8]
    """

    nos_entrada = []
    nos_saida = []
    fluxo_maximo = []

    for idx, rows in df.iterrows():
        for i in range(total_nos + 1):
            if rows[i] > 0:
                nos_entrada.append(idx)
                nos_saida.append(i)
                fluxo_maximo.append(int(rows[i]))

    return nos_entrada, nos_saida, fluxo_maximo


def main():

    TOTAL_NOS = 12

    df = pd.read_csv("exercise3.csv")

    nos_entrada, nos_saida, fluxo_maximo = parse_input(df=df, total_nos=TOTAL_NOS)

    max_flow = pywrapgraph.SimpleMaxFlow()
    for i in range(0, len(nos_entrada)):
        max_flow.AddArcWithCapacity(nos_entrada[i], nos_saida[i], fluxo_maximo[i])

    # find the optimal max flow value
    if max_flow.Solve(0, TOTAL_NOS) == max_flow.OPTIMAL:
        print("Fluxo máximo:", max_flow.OptimalFlow())
        print("------------------------")
        print(" Arco    Fluxo / Capacidade")
        for i in range(max_flow.NumArcs()):
            print(
                "%1s -> %1s   %3s  / %3s"
                % (
                    max_flow.Tail(i),
                    max_flow.Head(i),
                    max_flow.Flow(i),
                    max_flow.Capacity(i),
                )
            )

    else:
        print("Input incorreto.")


if __name__ == "__main__":
    main()
