## PuLP library
- defining the parameter `upBound` as inf `(float("inf") or np.inf)` when instantiating 
a `LpVariable` object doesn't work
- using `msg=True` when applying GLPK solver makes it very verbose