reset;

# decision variables
var X1;
var X2;
var X3;
var X4;
var X5;

# objective function
minimize z: -3*X1 - 2*X2 - X3;

# constraints
subject to r1: 3*X1 - 3*X2 + 2*X3 + X4 = 3;
subject to r2: -X1 + 2*X2 + X3 + X5 = 6;
subject to r3: X1 >= 0;
subject to r4: X2 >= 0;
subject to r5: X3 >= 0;
subject to r6: X4 >= 0;
subject to r7: X5 >= 0;

option solver cplex;

solve;

display z, X1, X2, X3, X4, X5;

