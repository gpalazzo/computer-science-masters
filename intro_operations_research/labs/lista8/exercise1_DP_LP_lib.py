"""
The goal of this exercise is solving a linear programming (LP) problem using dynamic programming (DP)

Problem statement:
    Min Z = 2x + 3y
    S.T
        x + 2y >= 10
        3x + 4y >= 25
        x, y >= 0
"""

from gekko import GEKKO

m = GEKKO(remote=False)
m.options.solver = 1

x = m.Var(lb=0)
y = m.Var(lb=0)

m.Minimize(2 * x + 3 * y)  # Profit function
m.Equation(x + 2 * y >= 10)  # Units of A
m.Equation(3 * x + 4 * y >= 25)  # Units of B

m.solve(disp=False)

_x = x.value[0]
_y = y.value[0]
print(f"valor x: {_x}")
print(f"valor y: {_y}")
print(f"FO: {_x * 2 + _y * 3}")
