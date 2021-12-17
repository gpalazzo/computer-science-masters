reset;

# decision variables
var X1;
var X2;
var X3;

# objective function
maximize z: 3*X1 + 2*X2 + X3;

# constraints
subject to r1: 3*X1 - 3*X2 + 2*X3 <= 3;
subject to r2: -X1 + 2*X2 + X3 <= 6;
subject to r3: X1 >= 0;
subject to r4: X2 >= 0;
subject to r5: X3 >= 0;

option solver cplex;

solve;

display z, X1, X2, X3;

