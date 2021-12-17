reset;

# decision variables
var Q1 integer;
var Q2 integer;
var Q3 integer;

# objective function
maximize z: 50*Q1 + Q2 + 5*Q3;

# constraints
subject to r1: 400*Q1 + 25*Q2 + 50*Q3 <= 20000;
subject to r2: Q2 >= 2*Q1;
subject to r3: Q3 >= 5;
subject to r4: Q2 <= 400;
subject to r5: Q1 >= 0;
subject to r6: Q2 >= 0;

option solver cplex;

solve;

display z, Q1, Q2, Q3;

