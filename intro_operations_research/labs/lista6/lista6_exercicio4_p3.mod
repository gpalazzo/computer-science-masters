reset;

var x1 >= 0;
var x2 >= 0;
var x3 >= 0;

maximize Z: 6*x1 + 9*x2 + 7*x3;

subject to R1: 3*x1 + 5*x2 + 4*x3 <= 14;
subject to R2: x1 <= 4;
subject to R3: x2 <= 0;

option solver gurobi;

solve;

display Z, x1, x2, x3;