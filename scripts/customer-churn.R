# ECO 520
# Business Analytics II
# Assignment 4
# Prof. Peter Bondarenko
# Thuy Chinh Van Nguyen

# Load the necessary libraries into the R environment
# Each library provides specific functions for data analysis and visualization.
library(ggplot2)     # For creating various types of plots
library(stargazer)   # For displaying regression results in a nice format
library(corrplot)    # For visualizing correlation matrices
library(car)         # For calculating Variance Inflation Factor (VIF) to check multicollinearity
library(dplyr)       # For data manipulation and transformation
library(tidyr)       # For tidying data (cleaning and organizing it)
library(readr)
library(caTools)
library(rpart)
library(rpart.plot)

### Question 1
## 1.1

# Import the insurance dataset
d <- read_csv("customer_churn_dataset.csv")
View(d)

## 1.2
# Tabulate the Churn variable
churn_table <-table(d$Churn)
print("Churn table:")
print(churn_table)

# Calculate the percentage of customers who switched vendor
total_customer <- sum(churn_table)
switched_customers <- churn_table["Yes"]
perc_switched <- switched_customers/total_customer*100
print("Percentage of customers who switched:")
print(perc_switched)

## 1.3
# Convert categorical variables to factors
d$Sex <- factor(d$Sex, levels = c("Female", "Male"))
d$Marital_Status <- factor(d$Marital_Status, levels = c("Single", "Married"))
d$Phone_service <- factor(d$Phone_service, levels = c("No", "Yes"))

# Convert both "yes" and "Yes" to "Yes"
d$International_plan <- ifelse(d$International_plan %in% c("yes", "Yes"), "Yes", d$International_plan)
d$International_plan <- factor(d$International_plan, levels = c("No", "Yes"))

d$Voice_mail_plan <- factor(d$Voice_mail_plan, levels = c("No", "Yes"))
d$Multiple_line <- factor(d$Multiple_line, levels = c("No phone", "No", "Yes"))
d$Internet_service <- factor(d$Internet_service, levels = c("No Internet", "DSL", "Fiber optic", "Cable"))
d$Technical_support <- factor(d$Technical_support, levels = c("No internet", "No", "Yes"))
d$Streaming_Videos <- factor(d$Streaming_Videos, levels = c("No internet", "No", "Yes"))
d$Agreement_period <- factor(d$Agreement_period, levels = c("Monthly contract", "One year contract", "Two year contract"))
d$Churn <- factor(d$Churn, levels = c("No", "Yes"))

View(d)

# Use the set.seed() command
set.seed(123)

## 1.4
# Create a random sample 70:30
sample <- sample.split(d$Churn, SplitRatio = 0.70)

# Create 2 sub-dataset
train_data <- subset(d, sample == TRUE)
test_data <- subset(d, sample == FALSE)

# Check the dimensions of the training and testing sets
dim(train_data)  # Should be approximately 70% of the total data
dim(test_data)   # Should be approximately 30% of the total data

## 1.5
# Estimate the full decision tree model
tree_model <- rpart(Churn ~ ., data = train_data, cp = -1)

## 1.6, 1.7
# View the model summary
summary(tree_model)

# Plot the decision tree
rpart.plot(tree_model, main = "Decision Tree for Churn", 
           type = 3, 
           extra = 101, 
           fallen.leaves = TRUE)


### Question 2
## 2.1
# Train a decision tree model
tree_model2 <- rpart(Churn ~ ., data = train_data, 
                    method = "class", parms = list(split = 'information'),
                    control = rpart.control(maxdepth = 3, 
                                            minsplit = 2, 
                                            minbucket = 2))

# View the model summary
summary(tree_model2)

## 2.2
# Plot the pruned decision tree using training data set
library(rpart.plot)  
library(officer)     

png("pruned_tree_plot.png", width = 800, height = 600)
rpart.plot(tree_model2, type = 3, extra = 104, 
           fallen.leaves = TRUE, 
           main = "Pruned Decision Tree (Training Dataset)")
dev.off()

## 2.3, 2.4, 2.5
summary(tree_model2)

### Question 3
## 3.1
# Predict churn outcomes for testing data set
testing_outcome_preds <- predict(tree_model2, test_data, type= "class")

## 3.2
# Classification table
class_table <- table(test_data$Churn, testing_outcome_preds)
class_table

## 3.3
# Calculate the accuracy for pruned model
accuracy <- (class_table["No", "No"]+ class_table["Yes", "Yes"])/ sum(class_table)*100
print("Accuracy percantage of the pruned model:")
print(accuracy)

## 3.4
# Predict churn probabilities for testing data set
testing_prob_preds <- predict(tree_model2, test_data, type= "prob")
testing_prob_preds

## 3.5
# Count the number of customers in the target group
high_risk_count <- sum(testing_prob_preds[, "Yes"]> 0.7)
sorted_prob <- testing_prob_preds[order(-testing_prob_preds[,"Yes"]),]
head(sorted_prob)
print("Number of customers in the target group:")
print(high_risk_count)

### Question 4
## 4.1
library(randomForest)

# Fit the random forest model
set.seed(123) 
rf_model <- randomForest(as.factor(Churn) ~ ., data = train_data, ntree = 5000, mtry = 3, importance = TRUE)

# Print the model summary
print(rf_model)

# Plot for a quick visual
varImpPlot(rf_model)
## 4.2
# Check variable importance
importance(rf_model)

## 4.3
rf_outcome_preds <- predict(rf_model, test_data, type= "class")
rf_outcome_preds  

## 4.4
# Classification table
class_table2 <- table(test_data$Churn, rf_outcome_preds)
class_table2

## 4.5
rf_accuracy <- (class_table2["No", "No"]+ class_table2["Yes", "Yes"])/ sum(class_table2)*100
print("Accuracy percantage of the random forest model:")
print(rf_accuracy)

## 4.6
rf_prob_preds <- predict(rf_model, test_data, type= "prob")
rf_prob_preds  

## 4.7
# Count the number of customers in the target group
high_risk_count2 <- sum(rf_prob_preds[, "Yes"]> 0.7, na.rm = TRUE)
sorted_prob2 <- rf_prob_preds[order(-rf_prob_preds[,"Yes"]),na.rm = TRUE]
head(sorted_prob2)
print("Number of customers in the target group:")
print(high_risk_count2)


