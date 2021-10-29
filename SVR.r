
#### Install ####
install.packages('MatchIt') 
install.packages('tableone') # SMD
install.packages("httpgd")
install.packages("e1071")
install.packages("glmnet")
#################

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
library(e1071)
library(glmnet)
#################


#### read df

ht <- read.csv('D:\\BFM\\HT_psm.csv', encoding = 'euc-kr')
ar <- read.csv('D:\\BFM\\AR_psm.csv', encoding = 'euc-kr')
dm_all <- read.csv('DM_all_psm.csv', encoding = 'euc-kr')

################

#### copy df to use

  # HT (고혈압)
  df <- copy(ht)
  target <- df$ht_drug_90
  psm_col <- "ht_drug_90"

  # AR (관절염)
  df <- copy(ar)
  target <- df$ar_drug_90
  psm_col <- "ar_drug_90"

  # DM (당뇨병)
  df <- copy(dm_all)
  target <- df$dm_all_drug_90
  psm_col <- "dm_all_drug_90"

###################


#### EDA

colSums(is.na(df))
describe(df)
summary(df)

df_0 <- df[df[psm_col] == 0, ]
df_1 <- df[df[psm_col] == 1, ]

describe(df_0)
describe(df_1)

#############


#### Preprocess ####

#### HT
  df <- subset(df, select = -c(기수, EDATE, NIHID, DRUGHT))

  # WEIGHT, HEIGHT 빼기 (BMI와 corr 높음)
  df <- subset(df, select = -c(WEIGHT, HEIGHT))

  # KID = 2 (신장 치료 받고 있는 사람들) 빼기
  df <- df[df$KID != 2, ]
  df <- subset(df, select = -c(KID))

  # 운동, 알콜 관련 categorical 변수들 뺄 때 실행
  df <- subset(df, select=-c(PHYACTL, PHYACTM, PHYACTH, DRK_NEW, PA_NEW))
  
  # factor
  df$SMOKE = factor(df$SMOKE) 
  
  # # PA_NEW, DRK_NEW 전처리 (NEW 변수들 안 뺄 경우에만 실행)
  # df <- df[df$PA_NEW != 0, ]
  # df <- df[df$DRK_NEW != 0, ]
  # 
  # df$DRK_NEW = factor(df$DRK_NEW)
  # df$PA_NEW = factor(df$PA_NEW)


#### AR
  df <- subset(df, select = -c(기수, EDATE, NIHID))

   # WEIGHT, HEIGHT 빼기 (BMI와 corr 높음)
  df <- subset(df, select = -c(WEIGHT, HEIGHT))

  # KID = 2 (신장 치료 받고 있는 사람들) 빼기
  df <- df[df$KID != 2, ]
  df <- subset(df, select = -c(KID))
  
  # 운동, 알콜 관련 categorical 변수들 뺄 때 실행
  df <- subset(df, select = -c(PHYACTL, PHYACTM, PHYACTH, DRK_NEW, PA_NEW))
  
  # factor
  df$SMOKE = factor(df$SMOKE)
  
  # # PA_NEW, DRK_NEW 전처리 (NEW 변수들 안 뺄 경우에만 실행)
  # df <- df[df$PA_NEW != 0, ]
  # df <- df[df$DRK_NEW != 0, ]
  # 
  # df$DRK_NEW = factor(df$DRK_NEW)
  # df$PA_NEW = factor(df$PA_NEW)


#### DM
  df <- subset(df, select = -c(기수, EDATE, NIHID, DRUGINS))

   # WEIGHT, HEIGHT 빼기 (BMI와 corr 높음)
  df <- subset(df, select = -c(WEIGHT, HEIGHT))

  # KID = 2 (신장 치료 받고 있는 사람들) 빼기
  df <- df[df$KID != 2, ]
  df <- subset(df, select = -c(KID))
  
  # 운동, 알콜 관련 categorical 변수들 뺄 때 실행
  df <- subset(df, select = -c(PHYACTL, PHYACTM, PHYACTH, DRK_NEW, PA_NEW))
  
  # factor
  df$SMOKE = factor(df$SMOKE)
  
  # # PA_NEW, DRK_NEW 전처리 (NEW 변수들 안 뺄 경우에만 실행)
  # df <- df[df$PA_NEW != 0, ]
  # df <- df[df$DRK_NEW != 0, ]
  # 
  # df$DRK_NEW = factor(df$DRK_NEW)
  # df$PA_NEW = factor(df$PA_NEW)
  
######################


#### 유의했던 변수들만 살리기 ####
  
  # DM
  df <- subset(df, select = c(AGE, SEX, AST_ORI, TRIGLY_ORI, DRUGHT, TOTALC, MET_CAL, 
  eGFR, BMI, GLU0_ORI, KID, WAIST, HB_ORI, FMDM, dm_all_drug_90, final_CKD))

  # HT
  df <- subset(df, select = c(AGE, SEX, TRIGLY_ORI, FMHTN, eGFR, BMI, AST_ORI, MET_CAL, R_GTP_TR,
  HB_ORI, DRUGINS, FMHEA, ht_drug_90, final_CKD))

  # AR
  df <- subset(df, select = -c(GLU0_ORI, TCHL_ORI, HDL_ORI, TRIGLY_ORI, SMOKE, DRUGICD, DRUGLP, SBP, DBP, BMI))


################################


#### Variables ####

  # variables 리스트 생성
  variables <- colnames(df)

  # 신장변수 전체 (약물변수 포함)
  variables <- variables[!variables %in% c(psm_col, 'final_CKD')]  # for PSM

  # # pvalue > 0.5 인 변수들 추가로 빼기 (HT, 1:1)
  # variables <- variables[!variables %in% c('GLU0_ORI', 'R_GTP_TR', 'ALT_ORI', 'HDL_ORI', 'HB_ORI', 'SMOKE', 'DRUGICD', 'FMDM', 'SBP')]

  variables

#############


#### Stepwise variable selection ####

target <- df[[psm_col]]
df2 <- df[variables]

full <- glm(target ~ ., family = binomial(link = "logit"), data = df2)
step_lm <- step(full, direction = 'both')

summary(step_lm)

step_variables <- c(all.vars(formula(step_lm)[[3]])) # stepwise로 선택된 변수들만 가져오기

#########################


# 변수들에서 인슐린 빼기 (AR일 경우만, 인슐린 매칭 x)
  # ALL
  variables <- variables[!variables %in% c('DRUGINS')]
  # STEP
  step_variables <- step_variables[!step_variables %in% c('DRUGINS')]

# 변수들에서 뇌졸중약 빼기 (DM일 경우만, ICD 매칭 x)
  # ALL
  variables <- variables[!variables %in% c('DRUGICD')]
  # STEP
  step_variables <- step_variables[!step_variables %in% c('DRUGICD')]


#### PS Matching ####

  #### create psm formula - with all variables
  psm_f <- as.formula(
    paste(psm_col, 
          paste(variables, collapse = " + "),
          sep = " ~ ")
  )
  
  psm_f
  
  #### create psm formula - with only selected variables
  psm_f <- as.formula(
    paste(psm_col, 
          paste(step_variables, collapse = " + "), 
          sep = " ~ ")
  )
  
  psm_f
  
  #### Matching

    # 1:1
    mod_match <- matchit(psm_f, method = "nearest", data = df)
    
    # 1:2
    mod_match <- matchit(psm_f, method = "nearest", ratio = 2, data = df)
    
    # 1:3
    mod_match <- matchit(psm_f, method = "nearest", ratio = 3, data = df)

    # 1:3 - optimal
    mod_match <- matchit(psm_f, method = "optimal", ratio = 3, data = df)

    # 1:3 - nearest + randomforest
    mod_match <- matchit(psm_f, method = "nearest", distance = "randomforest", ratio = 3, data = df)
    
    # 1:4
    mod_match <- matchit(psm_f, method = "nearest", ratio = 4, data = df)

    # # 1:5
    # mod_match <- matchit(psm_f, method = "nearest", ratio = 5, data = df)
    
    mod_match

    dta_m <- match.data(mod_match)
    
    # # export dta_m
    # write.csv(dta_m, file = "HT_psm_4.csv", row.names = TRUE)
    
    # vars - with all variables
    vars <- c(variables)
    
    # vars - with only selected variables
    vars <- c(step_variables)
    
#################

    
#### SMD ####
tabmatched <- CreateTableOne(vars = vars, strata = psm_col, data = dta_m, test = FALSE)
print(tabmatched, smd = TRUE)
# summary(tabmatched)

  # calculate CKD patients in each group
  # 약물 복용 x
  count(dta_m[dta_m[psm_col] == 0 & dta_m$final_CKD == 0, ])
  count(dta_m[dta_m[psm_col] == 0 & dta_m$final_CKD == 1, ])
  
  # 약물 복용 o
  count(dta_m[dta_m[psm_col] == 1 & dta_m$final_CKD == 0, ])
  count(dta_m[dta_m[psm_col] == 1 & dta_m$final_CKD == 1, ])

##############

# # pvalue > 0.5 인 변수들 추가로 빼기 (AR, selected, 1:3)
# variables <- variables[!variables %in% c('WAIST', 'GLU0_ORI', 'AST_ORI', 'TCHL_ORI', 'HB_ORI', 'SMOKE', 'DRUGINS', 'DRUGICD', 'FMHEA', 'FMDM', 'PRT16_U', 'TOTALC')]

# # pvalue > 0.6 인 변수들 추가로 빼기 (DM, ALL, 1:4)
# variables <- variables[!variables %in% c('SMOKE', 'DRUGHT', 'DRUGLP', 'FMHEA', 'KID', 'MET_CAL')]

#### GLM ####
  
  # create glm formula
  variables = c(variables, psm_col)

  # # DM일 경우 실행
  # variables <- variables[!variables %in% c('DRUGICD')]

  # # HT일 경우 실행
  # variables <- variables[!variables %in% c('DRUGINS')]

  # AR일 경우 실행
  variables <- variables[!variables %in% c('DRUGINS')]

  glm_f <- as.formula(
    paste("final_CKD", 
          paste(variables, collapse = " + "),
          sep = " ~ ")
  )
  
  glm_f
  
  # fit
  fit <- glm(glm_f, family = binomial(link = "logit"), data = dta_m)
  summary(fit)

####################


#### SVR ####
  svr_f <- as.formula(
    paste("final_CKD", 
          paste(variables, collapse = " + "),
          sep = " ~ ")
  )
  
  svr_f

  fit <- svm(svr_f, data = dta_m)
  summary(fit)
  coef(fit)

table(df$SMOKE)
  vif(fit)
################# end #################


#### Penalized logistic regression ####

x <- model.matrix(final_CKD ~ variables, dta_m)
y <- dta_m$final_CKD

model <- glmnet(x, y, family = "binomial", alpha = 1, lambda = NULL)
coef(model)
summary(model)

#######################################

t.test(final_CKD ~ ht_drug_90, data = dta_m)
