reset;

param TEMPO;

set T = 1..TEMPO;

param r{T};
param s{T};
param c{T};

var y{T} binary;
var x{T} integer;

minimize Z: (sum {t in T} s[t] * y[t]) + (x[1] - r[1]) * c[1] + (sum {t in T: t >= 2} (x[t] + x[t-1] - r[t]) * c[t]);

subject to R1: x[1] * y[1] >= r[1];
subject to R2: sum {t in T: t >= 2} x[t] * y[t] + x[t-1] - r[t-1] - r[t] >= 0;

option solver gurobi;


