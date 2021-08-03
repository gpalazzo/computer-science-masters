## Environment Setup for Mac Users
1. install poetry with pip
    - `pip install poetry==1.0.10` or 
    `pip install -r requirements.txt`
    
2. poetry is the package management tool from now on
    - generate lock file by reading pyproject.toml file
    with a poetry section
        - `poetry lock`
    - install dependencies from lock file
        - `poetry install`
        
3. install sdkman as a sdk management tool
    - `curl -s "https://get.sdkman.io" | bash`
    - `source "$HOME/.sdkman/bin/sdkman-init.sh"`
    - verify installation: `sdk version`
    
4. install java using sdkman
    - `sdk list java` to see possible options
    - installation: `sdk install java 8.0.292.hs-adpt`

5. enable default solvers for PuLP
    - `pulptest` 

6. install GLPK
    - `brew install glpk`