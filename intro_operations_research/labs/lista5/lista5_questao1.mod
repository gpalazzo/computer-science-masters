reset;

param MAQ;
param ITENS;

set M = 1..MAQ;
set I = 1..ITENS;

param k{M};
param C{M, I};

var x{M} binary;

minimize Z {m in M}: k[m] * x[m] + sum {i in I} C[m, i] * x[m];

subject to R1: sum {m in M} x[m] = 1;

option solver gurobi;

