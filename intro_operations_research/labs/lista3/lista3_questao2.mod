reset;

# decision variables
var X1 integer;
var X2 integer;

# objective function
minimize z: -X1 - X2;

# constraints
subject to r1: X1 + X2 <= 6;
subject to r2: X1 - X2 <= 4;
subject to r3: X2 <= 1;
subject to r4: X1 >= 0;
subject to r5: X2 >= 0;

option solver cplex;

solve;

display z, X1, X2;

