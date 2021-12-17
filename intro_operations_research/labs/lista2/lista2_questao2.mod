reset;

# decision variables
var Q1 integer;
var Q2 integer;

# constants
param CT = 5*8*60 integer;

# objective function
maximize z: 8*Q1 + 12*Q2;

# constraints
subject to r1: 20*Q1 + 60*Q2 <= CT*25;
subject to r2: 70*Q1 + 60*Q2 <= CT*35;
subject to r3: 12*Q1 + 4*Q2 <= CT*5;
subject to r4: Q1 >= 0;
subject to r5: Q2 >= 0;

option solver cplex;

solve;

display z, Q1, Q2;

