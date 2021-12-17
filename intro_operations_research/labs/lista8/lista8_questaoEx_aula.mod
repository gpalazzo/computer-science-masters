reset;

var x1;
var	x2;

maximize z: 2*x1 + 5*x2;

subject to r1: 2*x1 + x2 <= 430;
subject to r2: x2 <= 230;
subject to r3: x1 >= 0;
subject to r4: x2 >= 0;

option solver cplex;

solve;

display z, x1, x2;