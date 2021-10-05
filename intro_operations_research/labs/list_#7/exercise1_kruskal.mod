# INCOMPLETE!

reset;

# setup inicial
param N integer > 2; # total de nós

set Nos ordered := {1..N};
set Arcos := {i in Nos, j in Nos: i <> j}; # conjunto de Arcos (i, j)

param Dist{(i,j) in Arcos}; # matriz completa de distâncias

# algoritmo de Kruskal
# passo 1
set C default {1}; #nós rotulados
set D ordered := {2..N}; #nós não rotulados
set T default {}; #guarda os conjuntos da árvore mínima
param LT := 0; #custo total da árvore mínima

param k := 0;
param j := 0;
param menor_dist;

# passo 2
repeat {

	let menor_dist := Infinity;
	
	for {(r, s) in {r in C, s in D: r <> s}} {
		
		if Dist[r, s] < menor_dist then {
			let menor_dist := Dist[r, s];
			let k := r;
			let j := s;
		}
	}
	
} while card(D) > 0;
	
	
	
	