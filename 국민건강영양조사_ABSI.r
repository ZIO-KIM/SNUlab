<<<<<<< HEAD

# install.packages('dlnm')
# install.packages('splines')
# install.packages("httpgd")
# install.packages("knitr")
# install.packages("rmarkdown")
install.packages("ggplot2")

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
library(survival)
library(ggplot2)
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

#### --------------------------------------------------------------------------------------------- ####


# ABSI 모델링

htn_df <- read.csv('0. data\\국건영_ABSI\\absi_htn.csv', encoding = 'euc-kr')
dm_df <- read.csv('0. data\\국건영_ABSI\\absi_dm.csv', encoding = 'euc-kr')
mi_df <- read.csv('0. data\\국건영_ABSI\\absi_mi.csv', encoding = 'euc-kr')
lip_df <- read.csv('0. data\\국건영_ABSI\\absi_lip.csv', encoding = 'euc-kr')
ceva_df <- read.csv('0. data\\국건영_ABSI\\absi_ceva.csv', encoding = 'euc-kr')
gout_df <- read.csv('0. data\\국건영_ABSI\\absi_gout.csv', encoding = 'euc-kr')

#### copy df to use

# HTN
df <- copy(htn_df)
target <- df$HTN_final
target_name <- "HTN_final"

# DM
df <- copy(dm_df)
target <- df$DM_final
target_name <- "DM_final"

# MI
df <- copy(mi_df)
target <- df$MI_final
target_name <- "MI_final"

# LIP
df <- copy(lip_df)
target <- df$LIP_final
target_name <- "LIP_final"

# CEVA
df <- copy(ceva_df)
target <- df$CEVA_final
target_name <- "CEVA_final"

# GOUT
df <- copy(gout_df)
target <- df$GOUT_final
target_name <- "GOUT_final"

###################


#### 추가 전처리 및 factor

# 중간처리 변수들 빼기
df <- subset(df, select = -c(EDATE, maxdate, mindate, 평균, 표준편차))

df$SMOKE <- factor(df$SMOKE)
df$DRINK <- factor(df$DRINK)

###################


#### Stepwise variable selection ####

# variables 리스트 생성
variables <- colnames(df)

# 선택되면 안되는 변수들 빼기
variables <- variables[!variables %in% c(target_name, "기수", "NIHID", "VISITALL", "TIME", "BMI", 
"ABSI", "ABSI_Z", "HTN_age", "DM_age", 'MI_age', "LIP_age", "CEVA_age", "GOUT_age")]

df2 <- df[variables]

full <- glm(target ~ ., family = binomial(link = "logit"), data = df2)
step_lm <- step(full, direction = "both")

summary(step_lm)

step_variables <- c(all.vars(formula(step_lm)[[3]])) # stepwise로 선택된 변수들만 가져오기

step_variables

#########################


#### GLM ####

# create glm formula - ABSI only
variables <- c(step_variables, "ABSI_Z")
variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

glm_f <- as.formula(
  paste(target_name,
    paste(variables, collapse = " + "),
    sep = " ~ "
  )
)

glm_f

# fit
fit <- glm(glm_f, family = binomial(link = "logit"), data = df)
summary(fit)



# create glm formula - BMI only
variables <- c(step_variables, "BMI")
variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

glm_f <- as.formula(
  paste(target_name,
    paste(variables, collapse = " + "),
    sep = " ~ "
  )
)

glm_f

# fit
fit <- glm(glm_f, family = binomial(link = "logit"), data = df)
summary(fit)



# create glm formula - ABSI_Z & BMI
variables <- c(step_variables, "ABSI_Z", "BMI")
variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

glm_f <- as.formula(
  paste(target_name,
    paste(variables, collapse = " + "),
    sep = " ~ "
  )
)

glm_f

# fit
fit <- glm(glm_f, family = binomial(link = "logit"), data = df)
summary(fit)



#### COX ####
    
    # ABSI_Z only
    variables <- c(step_variables, "ABSI_Z")
    variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

    x = paste(variables, collapse = " + ")
    y = "Surv(TIME, target)"
    cox_f = as.formula(paste(y, "~", x))

    cox_f

    # fit
    fit <- coxph(cox_f, data = df) # nolint
    summary(fit)

    # visualization
    ggsurvplot(surv_fit(fit, data = df), data = df, risk.table = TRUE)

    # LML plot
    ggsurvplot(surv_fit(fit, data = df), data = df, fun = "cloglog") # nolint




    # BMI only
    variables <- c(step_variables, "BMI")
    variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

    x = paste(variables, collapse = " + ")
    y = "Surv(TIME, target)"
    cox_f = as.formula(paste(y, "~", x))

    # fit
    fit <- coxph(cox_f, data = df) # nolint
    summary(fit)

    # visualization
    ggsurvplot(surv_fit(fit, data = df), data = df, risk.table = TRUE)

    # LML plot
    ggsurvplot(surv_fit(fit, data = df), data = df, fun = "cloglog") # nolint




    # ABSI_Z + BMI
    variables <- c(step_variables, "ABSI_Z", "BMI")
    variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

    x = paste(variables, collapse = " + ")
    y = "Surv(TIME, target)"
    cox_f = as.formula(paste(y, "~", x))

    # fit
    fit <- coxph(cox_f, data = df) # nolint
    summary(fit)

    # visualization
    ggsurvplot(surv_fit(fit, data = df), data = df, risk.table = TRUE)

    # LML plot
    ggsurvplot(surv_fit(fit, data = df), data = df, fun = "cloglog") # nolint
    
#####################
=======

# install.packages('dlnm')
# install.packages('splines')
# install.packages("httpgd")
# install.packages("knitr")
# install.packages("rmarkdown")
install.packages("ggplot2")

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
library(survival)
library(ggplot2)
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

#### --------------------------------------------------------------------------------------------- ####


# ABSI 모델링

htn_df <- read.csv('0. data\\국건영_ABSI\\absi_htn.csv', encoding = 'euc-kr')
dm_df <- read.csv('0. data\\국건영_ABSI\\absi_dm.csv', encoding = 'euc-kr')
mi_df <- read.csv('0. data\\국건영_ABSI\\absi_mi.csv', encoding = 'euc-kr')
lip_df <- read.csv('0. data\\국건영_ABSI\\absi_lip.csv', encoding = 'euc-kr')
ceva_df <- read.csv('0. data\\국건영_ABSI\\absi_ceva.csv', encoding = 'euc-kr')
gout_df <- read.csv('0. data\\국건영_ABSI\\absi_gout.csv', encoding = 'euc-kr')

#### copy df to use

# HTN
df <- copy(htn_df)
target <- df$HTN_final
target_name <- "HTN_final"

# DM
df <- copy(dm_df)
target <- df$DM_final
target_name <- "DM_final"

# MI
df <- copy(mi_df)
target <- df$MI_final
target_name <- "MI_final"

# LIP
df <- copy(lip_df)
target <- df$LIP_final
target_name <- "LIP_final"

# CEVA
df <- copy(ceva_df)
target <- df$CEVA_final
target_name <- "CEVA_final"

# GOUT
df <- copy(gout_df)
target <- df$GOUT_final
target_name <- "GOUT_final"

###################


#### 추가 전처리 및 factor

# 중간처리 변수들 빼기
df <- subset(df, select = -c(EDATE, maxdate, mindate, 평균, 표준편차))

df$SMOKE <- factor(df$SMOKE)
df$DRINK <- factor(df$DRINK)

###################


#### Stepwise variable selection ####

# variables 리스트 생성
variables <- colnames(df)

# 선택되면 안되는 변수들 빼기
variables <- variables[!variables %in% c(target_name, "기수", "NIHID", "VISITALL", "TIME", "BMI", 
"ABSI", "ABSI_Z", "HTN_age", "DM_age", 'MI_age', "LIP_age", "CEVA_age", "GOUT_age")]

df2 <- df[variables]

full <- glm(target ~ ., family = binomial(link = "logit"), data = df2)
step_lm <- step(full, direction = "both")

summary(step_lm)

step_variables <- c(all.vars(formula(step_lm)[[3]])) # stepwise로 선택된 변수들만 가져오기

step_variables

#########################


#### GLM ####

# create glm formula - ABSI only
variables <- c(step_variables, "ABSI_Z")
variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

glm_f <- as.formula(
  paste(target_name,
    paste(variables, collapse = " + "),
    sep = " ~ "
  )
)

glm_f

# fit
fit <- glm(glm_f, family = binomial(link = "logit"), data = df)
summary(fit)



# create glm formula - BMI only
variables <- c(step_variables, "BMI")
variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

glm_f <- as.formula(
  paste(target_name,
    paste(variables, collapse = " + "),
    sep = " ~ "
  )
)

glm_f

# fit
fit <- glm(glm_f, family = binomial(link = "logit"), data = df)
summary(fit)



# create glm formula - ABSI_Z & BMI
variables <- c(step_variables, "ABSI_Z", "BMI")
variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

glm_f <- as.formula(
  paste(target_name,
    paste(variables, collapse = " + "),
    sep = " ~ "
  )
)

glm_f

# fit
fit <- glm(glm_f, family = binomial(link = "logit"), data = df)
summary(fit)



#### COX ####
    
    # ABSI_Z only
    variables <- c(step_variables, "ABSI_Z")
    variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

    x = paste(variables, collapse = " + ")
    y = "Surv(TIME, target)"
    cox_f = as.formula(paste(y, "~", x))

    cox_f

    # fit
    fit <- coxph(cox_f, data = df) # nolint
    summary(fit)

    # visualization
    ggsurvplot(surv_fit(fit, data = df), data = df, risk.table = TRUE)

    # LML plot
    ggsurvplot(surv_fit(fit, data = df), data = df, fun = "cloglog") # nolint




    # BMI only
    variables <- c(step_variables, "BMI")
    variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

    x = paste(variables, collapse = " + ")
    y = "Surv(TIME, target)"
    cox_f = as.formula(paste(y, "~", x))

    # fit
    fit <- coxph(cox_f, data = df) # nolint
    summary(fit)

    # visualization
    ggsurvplot(surv_fit(fit, data = df), data = df, risk.table = TRUE)

    # LML plot
    ggsurvplot(surv_fit(fit, data = df), data = df, fun = "cloglog") # nolint




    # ABSI_Z + BMI
    variables <- c(step_variables, "ABSI_Z", "BMI")
    variables <- variables[!variables %in% c('WAIST', 'HEIGHT', 'WEIGHT')]

    x = paste(variables, collapse = " + ")
    y = "Surv(TIME, target)"
    cox_f = as.formula(paste(y, "~", x))

    # fit
    fit <- coxph(cox_f, data = df) # nolint
    summary(fit)

    # visualization
    ggsurvplot(surv_fit(fit, data = df), data = df, risk.table = TRUE)

    # LML plot
    ggsurvplot(surv_fit(fit, data = df), data = df, fun = "cloglog") # nolint
    
#####################
>>>>>>> 065348a622de3301ae5fd51741255d7898482d84
