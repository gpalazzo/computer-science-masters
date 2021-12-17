reset;

var x1;
var x2;
var x3;
var x4;
var x5;
var x6;
var x7;

minimize z: - x1 - 3*x2;

subject to r1: x2 + x3 = 2;
subject to r2: x1 + x4 = 3;
subject to r3: x1 - x2 - x5 = -1;
subject to r4: x1 - 2*x2 + x6 = 2;
subject to r5: 4*x1 + 5*x2 + x7 = 20;
subject to r6: x1 >= 0;
subject to r7: x2 >= 0;
subject to r8: x3 >= 0;
subject to r9: x4 >= 0;
subject to r10: x5 >= 0;
subject to r11: x6 >= 0;
subject to r12: x7 >= 0;

option solver cplex;

solve;

display z, x1, x2, x3, x4, x5, x6, x7;