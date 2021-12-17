# não funcional

reset;

param N integer > 2; # Number of nodes

set NODES ordered := {1..N};

set Arcs := {i in NODES, j in NODES: i < j};

param C{(i,j) in Arcs};

param n; # number of cutting planes
set S {1..n} within NODES;

var x {NODES, NODES} binary;

minimize z: sum {i in NODES, j in NODES: i < j} C[i,j] * x[i,j];

subject to
Degree {i in NODES}:
	sum {j in NODES: j < i} x[j,i] +
	sum {j in NODES: j > i} x[i,j] = 2;
Sep {k in 1..n}:
	sum {i in S[k], j in S[k]: i < j}
		x[i,j] <= card(S[k]) - 1;