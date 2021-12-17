reset;

var p1 integer;
var p2 integer;
var p3 integer;
var m1 integer;
var m2 integer;
var m3 integer;
var g1 integer;
var g2 integer;
var g3 integer;

maximize z: (p1+p2+p3) * 10 + (m1+m2+m3) * 19 + (g1+g2+g3) * 28;

subject to r1: p1+m1+g3 <= 500;
subject to r2: p1+m1+g3 <= 800;
subject to r3: p1+m1+g3 <= 600;

subject to r4: p1+m1+g1 <= 450;
subject to r5: p2+m2+g2 <= 700;
subject to r6: p3+m3+g3 <= 300;

subject to r7: 15*p1 + 25*m1 + 30*g1 <= 7000;
subject to r8: 15*p2 + 25*m2 + 30*g2 <= 8000;
subject to r9: 15*p3 + 25*m3 + 30*g3 <= 4000;

subject to r10: (p1 + m1 + g1) * 100 / 450 = 
				(p2 + m2 + g2) * 100 / 700;
subject to r20: (p1 + m1 + g1) * 100 / 450 = 
				(p3 + m3 + g3) * 100 / 300;

subject to r11: m1 >= 0;
subject to r12: m2 >= 0;
subject to r13: m3 >= 0;
subject to r14: p1 >= 0;
subject to r15: p2 >= 0;
subject to r16: p3 >= 0;
subject to r17: g1 >= 0;
subject to r18: g2 >= 0;
subject to r19: g3 >= 0;

option solver cplexamp;

solve;

display z, p1, p2, p3, m1, m2, m3, g1, g2, g3;