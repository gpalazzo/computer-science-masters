reset;

# decision variables
var X1;
var X2;

# objective function
maximize z: X1 + 3*X2;

# constraints
subject to r1: X2 <= 2;
subject to r2: X1 <= 3;
subject to r3: X1 - X2 >= -1;
subject to r4: X1 - 2*X2 <= 2;
subject to r5: 4*X1 + 5*X2 <= 20;
subject to r6: X1 >= 0;
subject to r7: X2 >= 0;

option solver cplex;

solve;

display z, X1, X2;

