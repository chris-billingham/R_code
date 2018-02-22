install.packages("benchmarkme")

library(benchmarkme)

res=benchmark_std(runs=3)
plot(res)

# Assign the variable `ram` to the amount of RAM on this machine
ram <- get_ram()
ram

# Assign the variable `cpu` to the cpu specs
cpu <- get_cpu()
cpu