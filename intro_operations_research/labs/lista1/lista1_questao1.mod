reset;

var x1 integer;
var x2 integer;
var	x3 integer;
var	x4 integer;
var	x5 integer;

maximize z: 35*x1 + 40*x2 + 55*x3 + 25*x4 + 50*x5	 -
            (2*x1 + 5*x2 + 7*x3 + 6*x4 + 4*x5)/60*20 -
            (6*x1 + 2*x2 + 4*x3 + 2*x4 + 5*x5)/60*15 -
            (4*x1 + 3*x2 + 2*x3 + 1*x4 + 3*x5)/60*35;

subject to r1: (2*x1 + 5*x2 + 7*x3 + 6*x4 + 4*x5)/60 <= 700;
subject to r2: (6*x1 + 2*x2 + 4*x3 + 2*x4 + 5*x5)/60 <= 580;
subject to r3: (4*x1 + 3*x2 + 2*x3 + 1*x4 + 3*x5)/60 <= 800;

subject to r4: x1 >= 0;
subject to r5: x2 >= 0;
subject to r6: x3 >= 0;
subject to r7: x4 >= 0;
subject to r8: x5 >= 0;


#option solver cplexamp;

solve;

display z, x1, x2, x3, x4, x5;
