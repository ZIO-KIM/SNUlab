
# install.packages('dlnm')
# install.packages('splines')
# install.packages("httpgd")
# install.packages("knitr")
# install.packages("rmarkdown")

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
library(dlnm)
library(splines)
library(httpgd)
library(lubridate)
library(ape)
library(knitr)
library(rmarkdown)
#################


basic0719 <- read.csv('D:\\국민건강영양조사\\basic0719.csv', encoding = 'euc-kr')
basic0720 <- read.csv('D:\\국민건강영양조사\\basic0720.csv', encoding = 'euc-kr')


# year 2007 -> 0, ..., 2019 -> 12로 수정


basic0719 <- basic0719 %>% mutate(year_new = 
    case_when(
    year == 2007 ~ 0, 
    year == 2008 ~ 1, 
    year == 2009 ~ 2, 
    year == 2010 ~ 3, 
    year == 2011 ~ 4, 
    year == 2012 ~ 5, 
    year == 2013 ~ 6, 
    year == 2014 ~ 7, 
    year == 2015 ~ 8, 
    year == 2016 ~ 9, 
    year == 2017 ~ 10,
    year == 2018 ~ 11,
    year == 2019 ~ 12, 
    TRUE ~ NA_real_)
)

# year 2007 -> 0, ..., 2020 -> 13으로 수정
basic0720 <- basic0720 %>%mutate(year_new = case_when(
    year == 2007 ~ 0,
    year == 2008 ~ 1, 
    year == 2009 ~ 2, 
    year == 2010 ~ 3, 
    year == 2011 ~ 4, 
    year == 2012 ~ 5, 
    year == 2013 ~ 6, 
    year == 2014 ~ 7, 
    year == 2015 ~ 8, 
    year == 2016 ~ 9, 
    year == 2017 ~ 10, 
    year == 2018 ~ 11, 
    year == 2019 ~ 12, 
    year == 2020 ~ 13, 
    TRUE ~ NA_real_
    )
)


# age, 조사년도, interaction check
model1 <- lm(ABSI ~ year_new * age, data=basic0719)
summary(model1)

model2 <- glm(ABSI ~ year_new * age, family=gaussian, data=basic0719)
summary(model2)

model3_1 <- lm(ABSI ~ year_new + age, data=basic0720)
summary(model3_1)

model3 <- lm(ABSI ~ year_new * age, data=basic0720)
summary(model3)

model4 <- glm(ABSI ~ year_new * age, family=gaussian, data=basic0720)
summary(model4)




# 표준화된 ABSI ~ ht, wt, wc, bmi

MME_A01_absi_standardized <- read.csv('MME_A01_absi_standardized.csv')

model5 <- lm(ABSI_Z ~ HEIGHT, data=MME_A01_absi_standardized)
summary(model5)

model5 <- lm(ABSI_Z ~ WEIGHT, data=MME_A01_absi_standardized)
summary(model5)

model5 <- lm(ABSI_Z ~ WAIST, data=MME_A01_absi_standardized)
summary(model5)

model5 <- lm(ABSI_Z ~ BMI, data=MME_A01_absi_standardized)
summary(model5)


# BMI ~ ht, wt, wc

model5 <- lm(BMI ~ HEIGHT, data=MME_A01_absi_standardized)
summary(model5)

model5 <- lm(BMI ~ WEIGHT, data=MME_A01_absi_standardized)
summary(model5)

model5 <- lm(BMI ~ WAIST, data=MME_A01_absi_standardized)
summary(model5)

cor(MME_A01_absi_standardized$BMI, MME_A01_absi_standardized$HEIGHT)
cor(MME_A01_absi_standardized$BMI, MME_A01_absi_standardized$WEIGHT)
cor(MME_A01_absi_standardized$BMI, MME_A01_absi_standardized$WAIST)


# BMI ~ ht, wt, wc UKB에서 check

ukb_1st_final <- read.csv('SAS\\ukb_1st_final.csv')

ukb_1st_final$BMI = ukb_1st_final$WGHT / ((ukb_1st_final$HGHT / 100)**2)

model5 <- lm(BMI ~ HGHT, data=ukb_1st_final)
summary(model5)

model5 <- lm(BMI ~ WGHT, data=ukb_1st_final)
summary(model5)

model5 <- lm(BMI ~ WSTC, data=ukb_1st_final)
summary(model5)