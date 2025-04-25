# 📊 Customer Churn Analysis

This project uses real-world customer churn data to predict customer attrition using decision trees and random forests in R. It was developed as part of a Business Analytics Tools II.

---

## 📁 Project Structure
- `data/`: Raw dataset and dataset description
- `scripts/`: R script performing data cleaning, model training, evaluation, and visualization
- `docs/`: Final analysis output in PDF format
- `customer-churn.Rproj`: RStudio project file for navigation

---

## 🚀 What I Did
- Cleaned and pre-processed a telecom churn dataset (handled factors, typos, missing values)
- Built a full Decision Tree model (`rpart`) and pruned tree for interpretability
- Evaluated model performance with confusion matrices and accuracy scores
- Built a Random Forest model to improve prediction performance
- Identified top features driving customer churn
- Exported all results into a structured PDF report

---

## 📊 Key Results
- Decision Tree Accuracy: **79.3%**
- Random Forest Accuracy: **82%**
- Top churn drivers: `Monthly Charges`, `Total Charges`, `Term`, `Agreement Period`

---

## 🛠️ Libraries Used
- `ggplot2`
- `stargazer`
- `corrplot`
- `car`
- `dplyr`
- `tidyr`
- `readr`
- `caTools`
- `rpart`
- `rpart.plot`
- `randomForest`
- `officer`

---

## 📈 How to Reproduce
1. Clone or download the repository
2. Open `customer-churn.Rproj` in RStudio
3. Open the script inside `scripts/`
4. Install any missing libraries
5. Run the R script to replicate the full analysis

---

## 📬 Contact
Created by **Thuy Chinh Van Nguyen**  
For questions or collaborations, feel free to connect!
