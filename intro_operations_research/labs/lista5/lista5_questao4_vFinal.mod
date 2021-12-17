reset;

param N integer > 2; # total de nós

set Nos ordered := {1..N};
set Arcos := {i in Nos, j in Nos: i <> j}; # conjunto de Arcos (i, j)

param D{(i,j) in Arcos}; # distância

var x{(i,j) in Arcos} binary;
var u{Nos} >= 0; # quantidade de cidades visitadas em cada nó

minimize Dist: sum {(i,j) in Arcos} D[i,j] * x[i,j];

subject to SaidaNosUnica {i in Nos}: sum{(i,j) in Arcos} x[i,j] = 1;
subject to EntradaNosUnica {i in Nos}: sum{(j,i) in Arcos} x[j,i] = 1;

subject to EvitaSubrotas1 {(i,j) in Arcos: i <> j and i >= 2 and j >= 2}:
	u[i] - u[j] + N * x[i,j] <= N - 1;

subject to EvitaSubrotas2 {i in Nos: i >= 2}:
	u[i] <= N - 1 - (N - 2) * x[1,i];

subject to EvitaSubrotas3 {i in Nos: i >= 2}:
	u[i] >= 1 + (N - 2) * x[i,1];

option solver gurobi;

# cplex
# 11 - 5 - 13 - 2 - 7 - 10 - 3 - 14 - 12 - 6 - 4 - 9 - 15 - 8 - 1

# gurobi
# 8 - 15 - 9 - 4 - 6 - 12 - 14 - 3 - 10 - 7 - 2 - 13 - 5 - 11 - 1