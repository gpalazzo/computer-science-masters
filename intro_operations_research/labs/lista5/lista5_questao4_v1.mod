#não funcional

reset;

param N;

set Station := {1..N};
set Arcs := {i in Station, j in Station: i<>j};

param C {Arcs};

var x{(i,j) in Arcs} binary;

minimize Total_cost:
sum {(i,j) in Arcs} C[i,j]*x[i,j];

subject to Middle { j in Station } :
 	sum {i in Station} x[i,j] = sum{i in Station} x[j,i mod N +1];
 	
subject to ServedOnly { i in Station} :
 	sum{j in Station} x[i,j] =  1;
 
option solver gurobi;