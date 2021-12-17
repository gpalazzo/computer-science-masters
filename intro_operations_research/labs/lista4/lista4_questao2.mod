reset;

var x1;
var x2;
var x3;
var x4;

maximize z: 3/4*x1 - 20*x2 + 1/2*x3 - 6*x4;

subject to r1: 1/4*x1 - 8*x2 - x3 + 9*x4 <= 0;
subject to r2: 1/2*x1 - 12*x2 - 1/2*x3 + 3*x4 <= 0;
subject to r3: x3 <= 1;
subject to r4: x1 >= 0;
subject to r5: x2 >= 0;
subject to r6: x3 >= 0;
subject to r7: x4 >= 0;

option solver cplex;

solve;

display z, x1, x2, x3, x4;