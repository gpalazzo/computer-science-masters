reset;

param JOG;
param HAB;
param POS;

set J = 1..JOG;
set H = 1..HAB;
set P = 1..POS;

param TOTAL_JOG := 5;

param S{J, H};
param B{J, P};

var x{J} binary;

minimize Z: sum {j in J} S[j, 4] * x[j];

subject to R1: sum {j in J} B[j, 1] * x[j] >= 2;
subject to R2: sum {j in J} B[j, 2] * x[j] >= 2;
subject to R3: sum {j in J} B[j, 3] * x[j] >= 3;
subject to R4: x[2] + x[3] >= 1;
subject to R5: x[1] <= x[4] + x[5];
subject to R6 {h in H}: sum {j in J} (S[j, h] * x[j]) / TOTAL_JOG >= 2;
subject to R7: sum {j in J} x[j] = TOTAL_JOG;
subject to R8: -x[6] >= (x[3] - 1);

option solver gurobi;


