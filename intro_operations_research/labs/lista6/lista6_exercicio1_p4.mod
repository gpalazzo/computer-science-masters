reset;

var x1 >= 0, <= 1;
var x2 >= 0, <= 1;
var x3 >= 0, <= 1;
var x4 >= 0, <= 1;

maximize Z: 10 * x1 + 15 * x2 + 36 * x3 + 20 * x4;

subject to R1: 10 * x1 + 17 * x2 + 49 * x3 + 30 * x4 <= 100;
subject to R2: x4 >= 1;
subject to R3: x3 >= 1;

option solver gurobi;

solve;

display Z, x1, x2, x3, x4;