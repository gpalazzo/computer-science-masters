from pertchart import PertChart

pc = PertChart()
tasks = pc.getInput("exercise4.json")
pc.create_pert_chart(pc.calculate_values(tasks))
