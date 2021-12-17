reset;

var x1 binary;
var x2 binary;
var x3 binary;
var x4 binary;

maximize Z: 10 * x1 + 15 * x2 + 36 * x3 + 20 * x4;

subject to R1: 10 * x1 + 17 * x2 + 49 * x3 + 30 * x4 <= 100;

option solver gurobi;

solve;

display Z, x1, x2, x3, x4;