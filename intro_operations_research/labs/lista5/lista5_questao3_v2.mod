reset;

param TEMPO;

set T = 1..TEMPO;

param r{T};
param s{T};
param c{T};

var x{T} binary;
var Q{T} integer;

minimize Z: sum {t in T} (s[t] * x[t] + ((Q[t] * x[t] + (sum {w in T: w < t} (Q[w] * x[w] - r[w]))) - r[t]) * c[t]);

subject to R1 {t in T}: Q[t] * x[t] + (sum {w in T: w < t} (Q[w] * x[w] - r[w])) >= r[t];

option solver gurobi;




