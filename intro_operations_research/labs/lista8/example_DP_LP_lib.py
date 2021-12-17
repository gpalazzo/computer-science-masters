"""
The goal of this exercise is solving a linear programming (LP) problem using dynamic programming (DP)

Problem statement:
    Max Z = 2x1 + 5x2
    S.T
        2x1 + x2 <= 430
        x2 <= 230
        x1, x2 >= 0
"""

from gekko import GEKKO

m = GEKKO(remote=False)
m.options.solver = 1

x1 = m.Var(lb=0)
x2 = m.Var(lb=0)

m.Maximize(2 * x1 + 5 * x2)  # Profit function
m.Equation(2 * x1 + x2 <= 430)  # Units of A
m.Equation(x2 <= 230)  # Units of B

m.solve(disp=True)

_x1 = x1.value[0]
_x2 = x2.value[0]
print(f"valor x1: {_x1}")
print(f"valor x2: {_x2}")
print(f"FO: {_x1 * 2 + _x2 * 5}")
