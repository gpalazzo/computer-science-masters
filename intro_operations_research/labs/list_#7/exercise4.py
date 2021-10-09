from criticalpath import Node
import pandas as pd


# def parse_and_link_input(df: pd.DataFrame, project: Node):
#
#     for index, row in df.iterrows():
#
#         print()
#         print(
#             f"Avaliando:\nAtividade: {row['atividade']} // Predecessoras: {row['predecessoras']} // Duração: {row['duracao']}"
#         )
#
#         ativ = row["atividade"]
#         pred = row["predecessoras"]
#
#         _node = project.add(Node(name=ativ, duration=row["duracao"]))
#
#         if pd.notna(pred):
#             pred_split = pred.split(",")
#             for _pred in pred_split:
#                 _node_pred = project.


p = Node("project")
df = pd.read_csv("exercise4.csv")

# parse_and_link_input(df=df, project=p)

a = p.add(Node("A", duration=1))
b = p.add(Node("B", duration=2))
c = p.add(Node("C", duration=1))
d = p.add(Node("D", duration=2))
e = p.add(Node("E", duration=6))
f = p.add(Node("F", duration=10))
g = p.add(Node("G", duration=3))
h = p.add(Node("H", duration=1))
i = p.add(Node("I", duration=1))
j = p.add(Node("J", duration=5))
k = p.add(Node("K", duration=2))
l = p.add(Node("L", duration=1))
m = p.add(Node("M", duration=2))
n = p.add(Node("N", duration=4))
o = p.add(Node("O", duration=2))
p = p.add(Node("P", duration=2))
q = p.add(Node("Q", duration=1))
r = p.add(Node("R", duration=7))
s = p.add(Node("S", duration=7))
t = p.add(Node("T", duration=3))

p.link(a, c).link(c, d).link(b, e).link(c, e).link(d, f).link(f, g).link(g, h).link(
    f, i
).link(e, j).link(h, j).link(i, k).link(f, l).link(j, l).link(f, m).link(l, n).link(
    m, n
).link(
    g, o
).link(
    j, o
).link(
    o, p
).link(
    i, q
).link(
    p, q
).link(
    p, r
).link(
    i, s
).link(
    n, s
).link(
    s, t
)

p.update_all()

crit_path = [str(n) for n in p.get_critical_path()]

print(crit_path)

print(p.duration)
