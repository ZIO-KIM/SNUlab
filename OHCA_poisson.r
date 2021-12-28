
#### library ####
library(dplyr)
library(forecast)
library(Metrics)
library(broom)
library(caret)
library(lme4)
library(sjPlot)
library(MASS)
library(data.table)
library(car)
library(psych) # describe
library(MatchIt)
library(tableone)
library(gbm)
#################

#### read df

group_patient_idx <- read.csv("data\\급성심장정지조사(08-19)SAS\\group_patient_idx.csv", encoding = "euc-kr")
group_hospital_idx <- read.csv("data\\급성심장정지조사(08-19)SAS\\group_hospital_idx.csv", encoding = "euc-kr")

################