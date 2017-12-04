
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
library(dplyr)
library(caret)


diamonds002=diamonds%>%mutate(cut_flag=ifelse(cut=='Very Good',1,0))

# Use caret to create a 80%/20% stratified split. Set the random
# seed for reproducibility.
set.seed(123)
indexes <- createDataPartition(diamonds002$cut_flag, times = 1,
                               p = 0.8, list = FALSE)

train <- diamonds002[indexes,]
test <- diamonds002[-indexes,]

# Verify proportions.
prop.table(table(train$cut_flag))
prop.table(table(test$cut_flag))


# Fit glm model: model
model <- glm(cut_flag ~.,family=binomial(link='logit'),data=train)

# Predict on test: p
p <- predict(model, test, type = "response")



