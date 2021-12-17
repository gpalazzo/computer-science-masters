reset;

# decision variables
var X1;
var X2;
var X3;

# objective function
maximize z: 2*X1 + 5*X2 + X3;

# constraints
subject to r1: X1 + X2 >= 6;
subject to r2: X2 - X3 >= 4;
subject to r3: 4*X1 + 2*X2 + X3 <= 15;
subject to r4: X1 >= 0;
subject to r5: X2 >= 0;
subject to r6: X3 >= 0;

option solver cplex;

solve;

display z, X1, X2, X3;

