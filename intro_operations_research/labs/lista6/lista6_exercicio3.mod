reset;

var x1 >= 0 integer;
var x2 >= 0 integer;

maximize Z: x1 + x2;

subject to R1: -2*x1 + 2*x2 <= 3;
subject to R2: 7*x1 + 3*x2 <= 22;

option solver gurobi;

solve;

display Z, x1, x2;