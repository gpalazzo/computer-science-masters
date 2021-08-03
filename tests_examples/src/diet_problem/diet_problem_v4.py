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
from pulp import LpMinimize, LpProblem, LpVariable, LpStatus, LpConstraint

# model creation
lp_model = LpProblem(name="diet-problem-test", sense=LpMinimize)

# decision variables
decision_var_x = LpVariable(name="x", lowBound=0)
decision_var_y = LpVariable(name="y", lowBound=0)
decision_var_z = LpVariable(name="z", lowBound=0)

# constraints
constraint_1 = LpConstraint(
    2 * decision_var_x + 3 * decision_var_y + 7 * decision_var_z >= 10
)
constraint_2 = LpConstraint(
    4 * decision_var_x + 2 * decision_var_y + 1 * decision_var_z >= 15
)

lp_model.addConstraint(constraint_1)
lp_model.addConstraint(constraint_2)
lp_model.addConstraint(
    1 * decision_var_x + 8 * decision_var_y + 1 * decision_var_z >= 10
)
lp_model.addConstraint(
    3 * decision_var_x + 1 * decision_var_y + 1 * decision_var_z >= 8
)

# objective function
lp_model.setObjective(20 * decision_var_x + 10 * decision_var_y + 16 * decision_var_z)
# lp_model += 20 * decision_var_x + 10 * decision_var_y + 16 * decision_var_z

# solve model
lp_model.solve()

# reporting
print(f"Value type found: {LpStatus[lp_model.status]}")
print(f"Value itself: {lp_model.objective.value()}")

for decision_vars in lp_model.variables():
    print(f"{decision_vars.name}: {decision_vars.value()}")

for name, constraint in lp_model.constraints.items():
    print(f"{name}: {constraint.value()}")
