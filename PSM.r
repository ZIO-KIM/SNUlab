
#### Install ####
install.packages('MatchIt') 
install.packages('tableone') # SMD
install.packages("httpgd")
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
#################


#### read df

ht <- read.csv('D:\\BFM\\HT_psm.csv', encoding = 'euc-kr')
ar <- read.csv('D:\\BFM\\AR_psm.csv', encoding = 'euc-kr')

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
  df <- subset(df, select=-c(기수, EDATE, NIHID, DRUGHT))

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
  df <- subset(df, select=-c(기수, EDATE, NIHID))
  
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
  
######################


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
  
df2 <- df[variables]

full <- glm(target ~ ., family=binomial(link="logit"), data = df2)
step_lm <- step(full, direction = 'both')

summary(step_lm)

step_variables <- c(all.vars(formula(step_lm)[[3]])) # stepwise로 선택된 변수들만 가져오기

#########################


# 선택된 변수들에서 인슐린 빼기 (AR, 인슐린 매칭 안 됨)

step_variables <- step_variables[!step_variables %in% c('DRUGINS')]

variables <- variables[!variables %in% c('DRUGINS')]


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
    
    # 1:4
    mod_match <- matchit(psm_f, method = "nearest", ratio = 4, data = df)
    
    mod_match

    dta_m <- match.data(mod_match)
    
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


#### GLM ####
  
  # create glm formula
  variables = c(variables, psm_col)
  glm_f <- as.formula(
    paste('final_CKD', 
          paste(variables, collapse = " + "), 
          sep = " ~ ")
  )
  
  glm_f
  
  # fit
  fit <- glm(glm_f, family=binomial(link="logit"), data = dta_m)
  summary(fit)

####################
  
################# end #################

t.test(final_CKD ~ ht_drug_90, data = dta_m)
