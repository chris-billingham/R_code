
# Import the log4r package.
library('log4r')

# Create a new logger object with create.logger().
logger <- create.logger()

# Set the logger's file output: currently only allows flat files.
logfile(logger) <- file.path('base.log')

# Set the current level of the logger.
level(logger) <- "DEBUG"

v1=1+2
v3
# Try logging messages at different priority levels.
debug(logger, 'A Debugging Message') # Won't print anything



pr.out <- prcomp(iris[-5], scale = TRUE)
# Inspect model output
summary(pr.out)

# Variability of each principal component: pr.var
pr.var <- pr.out$sdev^2

# Variance explained by each principal component: pve
pve <- pr.var / sum(pr.var)
# Plot variance explained for each principal component
plot(pve, xlab = "Principal Component",
     ylab = "Proportion of Variance Explained",
     ylim = c(0, 1), type = "b")


biplot(pr.out)
