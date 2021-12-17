reset;

var x1;
var	x2;
var x3;
var x4;
var x5;

minimize z: 8.0*x1 + 6.5*x2 + 9.0*x3 + 7.5*x4 + 8.5*x5;

subject to r1: 35*x1 + 15*x2 + 45*x3 + 20*x4 + 50*x5 = 20;
subject to r2: 55*x1 + 20*x2 + 25*x3 + 10*x4 + 20*x5 = 35;
subject to r3: 10*x1 + 65*x2 + 30*x3 + 70*x4 + 30*x5 = 45;
						
subject to r4: x1 >= 0;
subject to r5: x2 >= 0;
subject to r6: x3 >= 0;
subject to r7: x4 >= 0;
subject to r8: x5 >= 0;

subject to r9: x1 + x2 + x3 + x4 + x5 = 1;

option solver cplexamp;

solve;

display z, x1, x2, x3, x4, x5;