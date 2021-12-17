reset;

var x;
var	y;

minimize z: 2*x + 3*y;

subject to r1: x + 2*y >= 10;
subject to r2: 3*x + 4*y >= 25;
subject to r3: x >= 0;
subject to r4: y >= 0;

option solver cplex;

solve;

display z, x, y;