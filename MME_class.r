
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

mme_f2r <- read.table('data\\MME_F2R.dat', encoding = 'euc-kr')
mme_f3r <- read.table('data\\MME_F3R.dat', encoding = 'euc-kr')
mme_m2r <- read.table('data\\MME_M2R.dat', encoding = 'euc-kr')
mme_m3r <- read.table('data\\MME_M3R.dat', encoding = 'euc-kr')
mme_f <- read.table('data\\MME_F.dat', encoding = 'euc-kr')
mme_m <- read.table('data\\MME_M.dat', encoding = 'euc-kr')

ckd = read.csv('CKD_final_Baseline1st+OccuredTwiceOrMoreInARow.csv', encoding = 'euc-kr')

# change V36, V37 to class
names(mme_f2r)[names(mme_f2r) == 'V36'] <- 'CLASS'
names(mme_f3r)[names(mme_f3r) == 'V37'] <- 'CLASS'
names(mme_m2r)[names(mme_m2r) == 'V36'] <- 'CLASS'
names(mme_m3r)[names(mme_m3r) == 'V37'] <- 'CLASS'

# cbind
mme_f2r <- cbind(mme_f, mme_f2r[c('CLASS')])
mme_f3r <- cbind(mme_f, mme_f3r[c('CLASS')])
mme_m2r <- cbind(mme_m, mme_m2r[c('CLASS')])
mme_m3r <- cbind(mme_m, mme_m3r[c('CLASS')])

# add column names
add_columns <- function(df) {
    names(df)[names(df) == 'V1'] <- '기수'
    names(df)[names(df) == 'V2'] <- 'EDATE'
    names(df)[names(df) == 'V3'] <- 'NIHID'
    names(df)[names(df) == 'V4'] <- 'AGE'
    names(df)[names(df) == 'V5'] <- 'SEX'
    names(df)[names(df) == 'V6'] <- 'HEIGHT'
    names(df)[names(df) == 'V7'] <- 'WEIGHT'
    names(df)[names(df) == 'V8'] <- 'WAIST'
    names(df)[names(df) == 'V9'] <- 'GLU0_ORI'
    names(df)[names(df) == 'V10'] <- 'R_GTP_TR'
    names(df)[names(df) == 'V11'] <- 'AST_ORI'
    names(df)[names(df) == 'V12'] <- 'ALT_ORI'
    names(df)[names(df) == 'V13'] <- 'TCHL_ORI'
    names(df)[names(df) == 'V14'] <- 'HDL_ORI'
    names(df)[names(df) == 'V15'] <- 'TRIGLY_ORI'
    names(df)[names(df) == 'V16'] <- 'HB_ORI'
    names(df)[names(df) == 'V17'] <- 'SMOKE'
    names(df)[names(df) == 'V18'] <- 'DRUGINS'
    names(df)[names(df) == 'V19'] <- 'DRUGHT'
    names(df)[names(df) == 'V20'] <- 'TREATD5'
    names(df)[names(df) == 'V21'] <- 'DRUGICD'
    names(df)[names(df) == 'V22'] <- 'DRUGLP'
    names(df)[names(df) == 'V23'] <- 'FMHTN'
    names(df)[names(df) == 'V24'] <- 'FMHEA'
    names(df)[names(df) == 'V25'] <- 'FMDM'
    names(df)[names(df) == 'V26'] <- 'PRT16_U'
    names(df)[names(df) == 'V27'] <- 'TREATD14'
    names(df)[names(df) == 'V28'] <- 'KID'
    names(df)[names(df) == 'V29'] <- 'KIDAG'
    names(df)[names(df) == 'V30'] <- 'KIDCU'
    names(df)[names(df) == 'V31'] <- 'TOTALC'
    names(df)[names(df) == 'V32'] <- 'PHYACTL'
    names(df)[names(df) == 'V33'] <- 'PHYACTM'
    names(df)[names(df) == 'V34'] <- 'PHYACTH'
    names(df)[names(df) == 'V35'] <- 'BODYFAT'
    names(df)[names(df) == 'V36'] <- 'MET_CAL'
    names(df)[names(df) == 'V37'] <- 'PA_NEW'
    names(df)[names(df) == 'V38'] <- 'SBP'
    names(df)[names(df) == 'V39'] <- 'DBP'
    names(df)[names(df) == 'V40'] <- 'eGFR'
    names(df)[names(df) == 'V41'] <- 'BMI'
    names(df)[names(df) == 'V42'] <- 'DRK_NEW'

    return (df)
}
mme_f2r <- add_columns(mme_f2r)
mme_f3r <- add_columns(mme_f3r)
mme_m2r <- add_columns(mme_m2r)
mme_m3r <- add_columns(mme_m3r)

# # dummy class
# # 남자 2그룹 
# mme_m2r <- mme_m2r %>%
#     mutate(CLASS_1 = if_else(CLASS == 1, 1, 0)) %>%
#     mutate(CLASS_2 = if_else(CLASS == 2, 1, 0)) 
# mme_m2r <- subset(mme_m2r, select = -c(CLASS))

# # 여자 2그룹
# mme_f2r <- mme_f2r %>%
#     mutate(CLASS_3 = if_else(CLASS == 1, 1, 0)) %>%
#     mutate(CLASS_4 = if_else(CLASS == 2, 1, 0)) 
# mme_f2r <- subset(mme_f2r, select = -c(CLASS))

# # 남자 3그룹
# mme_m3r <- mme_m3r %>%
#     mutate(CLASS_1 = if_else(CLASS == 1, 1, 0)) %>%
#     mutate(CLASS_2 = if_else(CLASS == 2, 1, 0)) %>%
#     mutate(CLASS_3 = if_else(CLASS == 3, 1, 0))
# mme_m3r <- subset(mme_m3r, select = -c(CLASS))

# # 여자 3그룹
# mme_f3r <- mme_f3r %>%
#     mutate(CLASS_4 = if_else(CLASS == 1, 1, 0)) %>%
#     mutate(CLASS_5 = if_else(CLASS == 2, 1, 0)) %>%
#     mutate(CLASS_6 = if_else(CLASS == 3, 1, 0))
# mme_f3r <- subset(mme_f3r, select = -c(CLASS))


# reassign female class values 1,2 to 3,4
mme_f2r$CLASS[mme_f2r$CLASS == 1] <- 3
mme_f2r$CLASS[mme_f2r$CLASS == 2] <- 4

mme_f3r$CLASS[mme_f3r$CLASS == 1] <- 4
mme_f3r$CLASS[mme_f3r$CLASS == 2] <- 5
mme_f3r$CLASS[mme_f3r$CLASS == 3] <- 6

# create group2, group3 finaldf
mme_group2 <- rbind(mme_m2r, mme_f2r)
mme_group3 <- rbind(mme_m3r, mme_f3r)

# merge CKD
final_group2 = merge(mme_group2, ckd, by = 'NIHID')
final_group3 = merge(mme_group3, ckd, by = 'NIHID')


# copy df to use
df = copy(final_group2)
df$CLASS = factor(df$CLASS)
df$CLASS <- relevel(df$CLASS, ref="2")   # reference 변경

df = copy(final_group3)
df$CLASS = factor(df$CLASS)
df$CLASS <- relevel(df$CLASS, ref="3")   # reference 변경


# WEIGHT, HEIGHT 빼기 (BMI와 corr 높음)
df <- subset(df, select = -c(SEX, WEIGHT, HEIGHT))

# SEX 빼기 (CLASS 변수 대신 사용)
df <- subset(df, select = -c(SEX, WEIGHT, HEIGHT))

# KID = 2 (신장 치료 받고 있는 사람들) 빼기
df <- df[df$KID != 2, ]
df <- subset(df, select = -c(KID, KIDAG, KIDCU))
  
# 운동, 알콜 관련 categorical 변수들 뺄 때 실행
df <- subset(df, select = -c(PHYACTL, PHYACTM, PHYACTH, DRK_NEW, PA_NEW))
  

# factor
df$SMOKE = factor(df$SMOKE) 

variables = colnames(df)
variables <- variables[!variables %in% c('기수', 'NIHID', 'EDATE', 'final_CKD')]

# glm 
glm_f <- as.formula(
    paste("final_CKD", 
          paste(variables, collapse = " + "),
          sep = " ~ ")
  )

glm_f
  
# fit
fit <- glm(glm_f, family = binomial(link = "logit"), data = df)
summary(fit)
