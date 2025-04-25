# 📊 Customer Churn Analysis

This project uses real-world customer churn data to predict customer attrition using decision trees and random forests in R. It was developed as part of a Business Analytics Tools II.

---

## 📁 Project Structure
```
customer-churn-analytics/
├── data/
│   ├── customer_churn_dataset.csv
│   └── customer_churn_dataset_description.docx
├── docs/
│   └── customer-churn-output.pdf
├── scripts/
│   └── customer-churn.R
├── customer-churn.Rproj
└── README.md
```
---

## 🚀 What I Did
- Cleaned and pre-processed a telecom churn dataset (handled factors, typos, missing values)
- Built a full Decision Tree model (`rpart`) and pruned tree for interpretability
- Evaluated model performance with confusion matrices and accuracy scores
- Built a Random Forest model to improve prediction performance
- Identified top features driving customer churn
- Exported all results into a structured PDF report

---

## 📄 Outputs

- Final write-up: `docs/customer-churn-output.pdf`
- All analysis code: `scripts/customer-churn.R`

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

## 📈 How to Run the Code
1. Clone or download the repository
2. Open `customer-churn.Rproj` in RStudio
3. Open the script inside `scripts/`
4. Install any missing libraries
5. Run the R script to replicate the full analysis

---

**Author:** Thuy Nguyen  
**Term:** Fall 2024  
**Project Type:** Individual school project (DePaul University)  
**Tools:** R
