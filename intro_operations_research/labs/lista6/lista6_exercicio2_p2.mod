reset;

var x1 >= 0;
var x2 >= 0;
var x3 >= 0;
var x4 >= 0;

minimize Z: 7*x1 + 10*x2 - 3*x3 + 2*x4;

subject to R1: 3*x1 - 5*x2 + x3 - 4*x4 <= 5;
subject to R2: 2*x1 + 6*x2 - 2*x3 - 2*x4 >= 25;
subject to R3: x2 >= 5;

option solver gurobi;

solve;

display Z, x1, x2, x3, x4;