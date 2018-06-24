#https://www.datacamp.com/tracks/machine-learning


#https://www.datacamp.com/courses/supervised-learning-in-r-classification
#https://www.datacamp.com/courses/supervised-learning-in-r-regression
#https://www.datacamp.com/courses/unsupervised-learning-in-r
#https://www.datacamp.com/courses/machine-learning-toolbox


#supervised-learning-in-r-classification
library(class)
library(dplyr)
signs_base=read.csv('https://assets.datacamp.com/production/course_2906/datasets/knn_traffic_signs.csv')
glimpse(signs_base)
table(signs_base$sample)

sign_types <- signs$sign_type
table(sign_types)

signs=(signs_base%>%filter(sample=='train'))[-1:-2]
glimpse(signs)

test_signs=(signs_base%>%filter(sample=='test'))[-1:-2]
glimpse(test_signs)


next_sign = signs[-1]
next_sign=head(next_sign,1)
next_sign

# Classify the next sign observed
knn(train = signs[-1], test = next_sign, cl = sign_types)

aggregate(r10 ~ sign_types, data = signs, mean)


signs_pred <- knn(train = signs[-1], test = test_signs[-1], cl = sign_types)
length(signs_pred)
head(signs_pred)
# Create a confusion matrix of the predicted versus actual values
signs_actual <- test_signs$sign_type
table(signs_pred, signs_actual)

# Compute the accuracy
mean(signs_pred == signs_actual)

signs_test=(signs_base%>%filter(sample=='test'))[-1:-2]
  
# Compute the accuracy of the baseline model (default k = 1)
k_1 <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types)
mean(signs_actual == k_1)

# Modify the above to set k = 7
k_7 <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types, k = 7)
mean(signs_actual == k_7)

# Set k = 15 and compare to the above
k_15 <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types, k = 15)
mean(signs_actual == k_15)

# Use the prob parameter to get the proportion of votes for the winning class
sign_pred <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types, k = 7, prob = TRUE)

# Get the "prob" attribute from the predicted classes
sign_prob <- attr(sign_pred, "prob")

# Examine the first several predictions
head(sign_pred)

# Examine the proportion of votes for the winning class
head(sign_prob)

# dummay variable and normalization

#Naive Bayes


where9am=read.csv('https://assets.datacamp.com/production/course_2906/datasets/locations.csv')
glimpse(where9am)
table(where9am$location)
# Compute P(A) 
p_A <- nrow(subset(where9am, location == "office")) / 91

# Compute P(B)
p_B <- nrow(subset(where9am, daytype == "weekday")) / 91

# Compute the observed P(A and B)
p_AB <- nrow(subset(where9am, where9am$location == "office" & where9am$daytype == "weekday")) / 91

# Compute P(A | B)
p_A_given_B <- p_AB / p_B
p_A_given_B


# Load the naivebayes package
install.packages('naivebayes')
library(naivebayes)
thursday9am=where9am%>%filter(hour==9,hourtype=='morning',weekday=='thursday')%>%select(daytype)
thursday9am=head(thursday9am,1)
thursday9am
saturday9am=where9am%>%filter(hour==9,hourtype=='morning',weekday=='saturday')%>%select(daytype)
saturday9am=head(saturday9am,1)
saturday9am
# Build the location prediction model
locmodel <- naive_bayes(location ~ daytype, data = where9am)
locmodel
# Predict Thursday's 9am location
predict(locmodel, thursday9am)

# Predict Saturdays's 9am location
predict(locmodel, saturday9am)


# Obtain the predicted probabilities for Thursday at 9am
predict(locmodel, thursday9am, type = "prob")

# Obtain the predicted probabilities for Saturday at 9am
predict(locmodel, saturday9am, type = "prob")


locations=where9am
glimpse(locations)
# Build a NB model of location
locmodel <- naive_bayes(location ~ daytype + hourtype, data = locations)

# Predict Brett's location on a weekday afternoon
weekday_afternoon=data.frame(daytype='weekday',hourtype='afternoon',location='office')
predict(locmodel, weekday_afternoon)

# Predict Brett's location on a weekday evening
weekday_evening=data.frame(daytype='weekday',hourtype='evening',location='home')
predict(locmodel, weekday_evening)

# Observe the predicted probabilities for a weekend afternoon
predict(locmodel, weekday_evening, type = "prob")

# Build a new model using the Laplace correction
locmodel2 <- naive_bayes(location ~ daytype + hourtype, data = locations, laplace = 1)

# Observe the new predicted probabilities for a weekend afternoon
predict(locmodel2, weekday_evening, type = "prob")



# Examine the dataset to identify potential independent variables
donors=read.csv('https://assets.datacamp.com/production/course_2906/datasets/donors.csv')
str(donors)
glimpse(donors)
# Explore the dependent variable
table(donors$donated)

# Build the donation model
donation_model <- glm(donated ~ bad_address + interest_religion + interest_veterans, 
                      data = donors, family = "binomial")

# Summarize the model results
donation_model
summary(donation_model)

# Estimate the donation probability
donors$donation_prob <- predict(donation_model, type = "response")

# Find the donation probability of the average prospect
mean(donors$donated)

# Predict a donation if probability of donation is greater than average
donors$donation_pred <- ifelse(donors$donation_prob > 0.0504, 1, 0)

# Calculate the model's accuracy
mean(donors$donated == donors$donation_pred)


# Load the pROC package
install.packages('pROC')
library(pROC)

# Create a ROC curve
ROC <- roc(donors$donated, donors$donation_prob)

# Plot the ROC curve
plot(ROC, col = "blue")

# Calculate the area under the curve (AUC)
auc(ROC)


#Dummy variables, missing data, and interactions


# Convert the wealth rating to a factor
donors$wealth_rating <- factor(donors$wealth_rating, levels = c(0, 1, 2, 3), labels = c("Unknown", "Low", "Medium", "High"))

# Use relevel() to change reference category
donors$wealth_rating <- relevel(donors$wealth_rating, ref = "Medium")

# See how our factor coding impacts the model
summary(glm(donated ~ wealth_rating, data = donors, family = "binomial"))

# Find the average age among non-missing values
summary(donors$age)

# Impute missing age values with mean(age)
donors$imputed_age <- ifelse(is.na(donors$age), 61.65, donors$age)

# Create missing value indicator for age
donors$missing_age <- ifelse(is.na(donors$age), 1, 0)

# Build a recency, frequency, and money (RFM) model
rfm_model <- glm(donated ~ recency * frequency + money, data = donors, family = "binomial")

# Summarize the RFM model to see how the parameters were coded
summary(rfm_model)

# Compute predicted probabilities for the RFM model
rfm_prob <- predict(rfm_model, data = donors, type = "response")

# Plot the ROC curve for the new model
library(pROC)
ROC <- roc(donors$donated, rfm_prob)
plot(ROC, col = "red")
auc(ROC)


# Specify a null model with no predictors
null_model <- glm(donated ~ 1, data = donors, family = "binomial")

# Specify the full model using all of the potential predictors
full_model <- glm(donated ~ ., data = donors, family = "binomial")

# Use a forward stepwise algorithm to build a parsimonious model
step_model <- step(null_model, scope = list(lower = null_model, upper = full_model), direction = "forward")

# Estimate the stepwise donation probability
step_prob <- predict(step_model, type = "response")

# Plot the ROC of the stepwise model
library(pROC)
ROC <- roc(donors$donated, step_prob)
plot(ROC, col = "red")
auc(ROC)

# Making decisions with trees

loans=read.csv('https://assets.datacamp.com/production/course_2906/datasets/loans.csv')
glimpse(loans)
table(loans$credit_score)
table(loans$default)
loans$outcome=loans$default
good_credit=loans%>%filter(credit_score=='HIGH')
bad_credit=loans%>%filter(credit_score=='LOW')
# Load the rpart package
install.packages('rpart')
library(rpart)

# Build a lending model predicting loan outcome versus loan amount and credit score
loan_model <- rpart(outcome ~ loan_amount + credit_score, data = loans, method = "class", control = rpart.control(cp = 0))

# Make a prediction for someone with good credit
predict(loan_model, good_credit, type = "class")

# Make a prediction for someone with bad credit
predict(loan_model, bad_credit, type = "class")
