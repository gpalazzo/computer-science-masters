"""
Small example of the diet problem to learn how to use PuLP
Using default PuLP solver
Adding LpConstraint object
Exploring LpProblem attributes and methods

Minimize: 20x1 + 10x2 + 16x3
Subject to:
    2x1 + 3x2 + 7x3 >= 10
    4x1 + 2x2 + 1x3 >= 15
    1x1 + 8x2 + 1x3 >= 10
    3x1 + 1x2 + 1x3 >= 8
"""

# imports
from pulp import LpMinimize, LpProblem, LpVariable, LpStatus

# model creation
lp_model = LpProblem(name="diet-problem-test", sense=LpMinimize)

# decision variables
lp_model.addVariables(
    [
        LpVariable(name="x0", lowBound=0),
        LpVariable(name="x1", lowBound=0),
        LpVariable(name="x2", lowBound=0),
    ]
)

# objective function
lp_model.setObjective(
    20 * lp_model.variables()[0]
    + 10 * lp_model.variables()[1]
    + 16 * lp_model.variables()[2]
)

# constraints
lp_model.addConstraint(
    2 * lp_model.variables()[0]
    + 3 * lp_model.variables()[1]
    + 7 * lp_model.variables()[2]
    >= 10
)
lp_model.addConstraint(
    4 * lp_model.variables()[0]
    + 2 * lp_model.variables()[1]
    + 1 * lp_model.variables()[2]
    >= 15
)
lp_model.addConstraint(
    1 * lp_model.variables()[0]
    + 8 * lp_model.variables()[1]
    + 1 * lp_model.variables()[2]
    >= 10
)
lp_model.addConstraint(
    3 * lp_model.variables()[0]
    + 1 * lp_model.variables()[1]
    + 1 * lp_model.variables()[2]
    >= 8
)

# solve model
lp_model.solve()

# reporting
print(f"Value type found: {LpStatus[lp_model.status]}")
print(f"Value itself: {lp_model.objective.value()}")

for decision_vars in lp_model.variables():
    print(f"{decision_vars.name}: {decision_vars.value()}")

for name, constraint in lp_model.constraints.items():
    print(f"{name}: {constraint.value()}")