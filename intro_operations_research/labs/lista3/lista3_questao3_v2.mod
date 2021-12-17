reset;

# decision variables
var X1;
var X2;
var X3;
var X4;
var X5;
var X6;

# objective function
minimize z: -2*X1 - 5*X2 - X3;

# constraints
subject to r1: X1 + X2 - X4 = 6;
subject to r2: X2 - X3 - X5 = 4;
subject to r3: 4*X1 + 2*X2 + X3 + X6 = 15;
subject to r4: X1 >= 0;
subject to r5: X2 >= 0;
subject to r6: X3 >= 0;
subject to r7: X4 >= 0;
subject to r8: X5 >= 0;
subject to r9: X6 >= 0;

option solver cplex;

solve;

display z, X1, X2, X3, X4, X5, X6;

