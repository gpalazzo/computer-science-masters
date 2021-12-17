reset;

var x1;
var x2;
var x3;

minimize z: - x1 - 5*x2 - 3*x3;

subject to r1: x1 + 2*x2 + x3 = 3;
subject to r2: 2*x1 - x2 = 4;
subject to r3: x1 >= 0;
subject to r4: x2 >= 0;
subject to r5: x3 >= 0;

option solver cplex;

solve;

display z, x1, x2, x3;