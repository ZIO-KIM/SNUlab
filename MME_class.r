
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

length(mme_f2r$V36)

# 
names(mme_f2r)[names(mme_f2r) == 'V36'] <- 'CLASS'
names(mme_f3r)[names(mme_f3r) == 'V36'] <- 'CLASS'
names(mme_m2r)[names(mme_m2r) == 'V36'] <- 'CLASS'
names(mme_m3r)[names(mme_m3r) == 'V36'] <- 'CLASS'

# cbind
mme_f2r <- cbind(mme_f, mme_f2r[c('CLASS')])
mme_f3r <- cbind(mme_f, mme_f3r[c('CLASS')])

mme_m2r <- cbind(mme_m, mme_m2r[c('CLASS')])
mme_m3r <- cbind(mme_m, mme_m3r[c('CLASS')])

# add column names
# mme_f2r
names(mme_f2r)[names(mme_f2r) == 'V1'] <- '기수'
names(mme_f2r)[names(mme_f2r) == 'V2'] <- 'EDATE'
names(mme_f2r)[names(mme_f2r) == 'V3'] <- 'NIHID'
names(mme_f2r)[names(mme_f2r) == 'V4'] <- 'AGE'
names(mme_f2r)[names(mme_f2r) == 'V5'] <- 'SEX'
names(mme_f2r)[names(mme_f2r) == 'V6'] <- 'HEIGHT'
names(mme_f2r)[names(mme_f2r) == 'V7'] <- 'WEIGHT'
names(mme_f2r)[names(mme_f2r) == 'V8'] <- 'WAIST'
names(mme_f2r)[names(mme_f2r) == 'V9'] <- 'GLU0_ORI'
names(mme_f2r)[names(mme_f2r) == 'V10'] <- 'R_GTP_TR'
names(mme_f2r)[names(mme_f2r) == 'V11'] <- 'AST_ORI'
names(mme_f2r)[names(mme_f2r) == 'V12'] <- 'ALT_ORI'
names(mme_f2r)[names(mme_f2r) == 'V13'] <- 'TCHL_ORI'
names(mme_f2r)[names(mme_f2r) == 'V14'] <- 'HDL_ORI'
names(mme_f2r)[names(mme_f2r) == 'V15'] <- 'TRIGLY_ORI'
names(mme_f2r)[names(mme_f2r) == 'V16'] <- 'HB_ORI'
names(mme_f2r)[names(mme_f2r) == 'V17'] <- 'SMOKE'
names(mme_f2r)[names(mme_f2r) == 'V18'] <- 'DRUGINS'
names(mme_f2r)[names(mme_f2r) == 'V19'] <- 'DRUGHT'
names(mme_f2r)[names(mme_f2r) == 'V20'] <- 'TREATD5'
names(mme_f2r)[names(mme_f2r) == 'V21'] <- 'DRUGICD'
names(mme_f2r)[names(mme_f2r) == 'V22'] <- 'DRUGLP'
names(mme_f2r)[names(mme_f2r) == 'V23'] <- 'FMHTN'
names(mme_f2r)[names(mme_f2r) == 'V24'] <- 'FMHEA'
names(mme_f2r)[names(mme_f2r) == 'V25'] <- 'FMDM'
names(mme_f2r)[names(mme_f2r) == 'V26'] <- 'PRT16_U'
names(mme_f2r)[names(mme_f2r) == 'V27'] <- 'TREATD14'
names(mme_f2r)[names(mme_f2r) == 'V28'] <- 'KID'
names(mme_f2r)[names(mme_f2r) == 'V29'] <- 'KIDAG'
names(mme_f2r)[names(mme_f2r) == 'V30'] <- 'KIDCU'
names(mme_f2r)[names(mme_f2r) == 'V31'] <- 'TOTALC'
names(mme_f2r)[names(mme_f2r) == 'V32'] <- 'PHYACTL'
names(mme_f2r)[names(mme_f2r) == 'V33'] <- 'PHYACTM'
names(mme_f2r)[names(mme_f2r) == 'V34'] <- 'PHYACTH'
names(mme_f2r)[names(mme_f2r) == 'V35'] <- 'BODYFAT'
names(mme_f2r)[names(mme_f2r) == 'V36'] <- 'MET_CAL'
names(mme_f2r)[names(mme_f2r) == 'V37'] <- 'PA_NEW'
names(mme_f2r)[names(mme_f2r) == 'V38'] <- 'SBP'
names(mme_f2r)[names(mme_f2r) == 'V39'] <- 'DBP'
names(mme_f2r)[names(mme_f2r) == 'V40'] <- 'eGFR'
names(mme_f2r)[names(mme_f2r) == 'V41'] <- 'BMI'
names(mme_f2r)[names(mme_f2r) == 'V42'] <- 'DRK_NEW'


# mme_f3r
names(mme_f3r)[names(mme_f3r) == 'V1'] <- '기수'
names(mme_f3r)[names(mme_f3r) == 'V2'] <- 'EDATE'
names(mme_f3r)[names(mme_f3r) == 'V3'] <- 'NIHID'
names(mme_f3r)[names(mme_f3r) == 'V4'] <- 'AGE'
names(mme_f3r)[names(mme_f3r) == 'V5'] <- 'SEX'
names(mme_f3r)[names(mme_f3r) == 'V6'] <- 'HEIGHT'
names(mme_f3r)[names(mme_f3r) == 'V7'] <- 'WEIGHT'
names(mme_f3r)[names(mme_f3r) == 'V8'] <- 'WAIST'
names(mme_f3r)[names(mme_f3r) == 'V9'] <- 'GLU0_ORI'
names(mme_f3r)[names(mme_f3r) == 'V10'] <- 'R_GTP_TR'
names(mme_f3r)[names(mme_f3r) == 'V11'] <- 'AST_ORI'
names(mme_f3r)[names(mme_f3r) == 'V12'] <- 'ALT_ORI'
names(mme_f3r)[names(mme_f3r) == 'V13'] <- 'TCHL_ORI'
names(mme_f3r)[names(mme_f3r) == 'V14'] <- 'HDL_ORI'
names(mme_f3r)[names(mme_f3r) == 'V15'] <- 'TRIGLY_ORI'
names(mme_f3r)[names(mme_f3r) == 'V16'] <- 'HB_ORI'
names(mme_f3r)[names(mme_f3r) == 'V17'] <- 'SMOKE'
names(mme_f3r)[names(mme_f3r) == 'V18'] <- 'DRUGINS'
names(mme_f3r)[names(mme_f3r) == 'V19'] <- 'DRUGHT'
names(mme_f3r)[names(mme_f3r) == 'V20'] <- 'TREATD5'
names(mme_f3r)[names(mme_f3r) == 'V21'] <- 'DRUGICD'
names(mme_f3r)[names(mme_f3r) == 'V22'] <- 'DRUGLP'
names(mme_f3r)[names(mme_f3r) == 'V23'] <- 'FMHTN'
names(mme_f3r)[names(mme_f3r) == 'V24'] <- 'FMHEA'
names(mme_f3r)[names(mme_f3r) == 'V25'] <- 'FMDM'
names(mme_f3r)[names(mme_f3r) == 'V26'] <- 'PRT16_U'
names(mme_f3r)[names(mme_f3r) == 'V27'] <- 'TREATD14'
names(mme_f3r)[names(mme_f3r) == 'V28'] <- 'KID'
names(mme_f3r)[names(mme_f3r) == 'V29'] <- 'KIDAG'
names(mme_f3r)[names(mme_f3r) == 'V30'] <- 'KIDCU'
names(mme_f3r)[names(mme_f3r) == 'V31'] <- 'TOTALC'
names(mme_f3r)[names(mme_f3r) == 'V32'] <- 'PHYACTL'
names(mme_f3r)[names(mme_f3r) == 'V33'] <- 'PHYACTM'
names(mme_f3r)[names(mme_f3r) == 'V34'] <- 'PHYACTH'
names(mme_f3r)[names(mme_f3r) == 'V35'] <- 'BODYFAT'
names(mme_f3r)[names(mme_f3r) == 'V36'] <- 'MET_CAL'
names(mme_f3r)[names(mme_f3r) == 'V37'] <- 'PA_NEW'
names(mme_f3r)[names(mme_f3r) == 'V38'] <- 'SBP'
names(mme_f3r)[names(mme_f3r) == 'V39'] <- 'DBP'
names(mme_f3r)[names(mme_f3r) == 'V40'] <- 'eGFR'
names(mme_f3r)[names(mme_f3r) == 'V41'] <- 'BMI'
names(mme_f3r)[names(mme_f3r) == 'V42'] <- 'DRK_NEW'



# mme_m2r
names(mme_m2r)[names(mme_m2r) == 'V1'] <- '기수'
names(mme_m2r)[names(mme_m2r) == 'V2'] <- 'EDATE'
names(mme_m2r)[names(mme_m2r) == 'V3'] <- 'NIHID'
names(mme_m2r)[names(mme_m2r) == 'V4'] <- 'AGE'
names(mme_m2r)[names(mme_m2r) == 'V5'] <- 'SEX'
names(mme_m2r)[names(mme_m2r) == 'V6'] <- 'HEIGHT'
names(mme_m2r)[names(mme_m2r) == 'V7'] <- 'WEIGHT'
names(mme_m2r)[names(mme_m2r) == 'V8'] <- 'WAIST'
names(mme_m2r)[names(mme_m2r) == 'V9'] <- 'GLU0_ORI'
names(mme_m2r)[names(mme_m2r) == 'V10'] <- 'R_GTP_TR'
names(mme_m2r)[names(mme_m2r) == 'V11'] <- 'AST_ORI'
names(mme_m2r)[names(mme_m2r) == 'V12'] <- 'ALT_ORI'
names(mme_m2r)[names(mme_m2r) == 'V13'] <- 'TCHL_ORI'
names(mme_m2r)[names(mme_m2r) == 'V14'] <- 'HDL_ORI'
names(mme_m2r)[names(mme_m2r) == 'V15'] <- 'TRIGLY_ORI'
names(mme_m2r)[names(mme_m2r) == 'V16'] <- 'HB_ORI'
names(mme_m2r)[names(mme_m2r) == 'V17'] <- 'SMOKE'
names(mme_m2r)[names(mme_m2r) == 'V18'] <- 'DRUGINS'
names(mme_m2r)[names(mme_m2r) == 'V19'] <- 'DRUGHT'
names(mme_m2r)[names(mme_m2r) == 'V20'] <- 'TREATD5'
names(mme_m2r)[names(mme_m2r) == 'V21'] <- 'DRUGICD'
names(mme_m2r)[names(mme_m2r) == 'V22'] <- 'DRUGLP'
names(mme_m2r)[names(mme_m2r) == 'V23'] <- 'FMHTN'
names(mme_m2r)[names(mme_m2r) == 'V24'] <- 'FMHEA'
names(mme_m2r)[names(mme_m2r) == 'V25'] <- 'FMDM'
names(mme_m2r)[names(mme_m2r) == 'V26'] <- 'PRT16_U'
names(mme_m2r)[names(mme_m2r) == 'V27'] <- 'TREATD14'
names(mme_m2r)[names(mme_m2r) == 'V28'] <- 'KID'
names(mme_m2r)[names(mme_m2r) == 'V29'] <- 'KIDAG'
names(mme_m2r)[names(mme_m2r) == 'V30'] <- 'KIDCU'
names(mme_m2r)[names(mme_m2r) == 'V31'] <- 'TOTALC'
names(mme_m2r)[names(mme_m2r) == 'V32'] <- 'PHYACTL'
names(mme_m2r)[names(mme_m2r) == 'V33'] <- 'PHYACTM'
names(mme_m2r)[names(mme_m2r) == 'V34'] <- 'PHYACTH'
names(mme_m2r)[names(mme_m2r) == 'V35'] <- 'BODYFAT'
names(mme_m2r)[names(mme_m2r) == 'V36'] <- 'MET_CAL'
names(mme_m2r)[names(mme_m2r) == 'V37'] <- 'PA_NEW'
names(mme_m2r)[names(mme_m2r) == 'V38'] <- 'SBP'
names(mme_m2r)[names(mme_m2r) == 'V39'] <- 'DBP'
names(mme_m2r)[names(mme_m2r) == 'V40'] <- 'eGFR'
names(mme_m2r)[names(mme_m2r) == 'V41'] <- 'BMI'
names(mme_m2r)[names(mme_m2r) == 'V42'] <- 'DRK_NEW'


# mme_m3r
names(mme_m3r)[names(mme_m3r) == 'V1'] <- '기수'
names(mme_m3r)[names(mme_m3r) == 'V2'] <- 'EDATE'
names(mme_m3r)[names(mme_m3r) == 'V3'] <- 'NIHID'
names(mme_m3r)[names(mme_m3r) == 'V4'] <- 'AGE'
names(mme_m3r)[names(mme_m3r) == 'V5'] <- 'SEX'
names(mme_m3r)[names(mme_m3r) == 'V6'] <- 'HEIGHT'
names(mme_m3r)[names(mme_m3r) == 'V7'] <- 'WEIGHT'
names(mme_m3r)[names(mme_m3r) == 'V8'] <- 'WAIST'
names(mme_m3r)[names(mme_m3r) == 'V9'] <- 'GLU0_ORI'
names(mme_m3r)[names(mme_m3r) == 'V10'] <- 'R_GTP_TR'
names(mme_m3r)[names(mme_m3r) == 'V11'] <- 'AST_ORI'
names(mme_m3r)[names(mme_m3r) == 'V12'] <- 'ALT_ORI'
names(mme_m3r)[names(mme_m3r) == 'V13'] <- 'TCHL_ORI'
names(mme_m3r)[names(mme_m3r) == 'V14'] <- 'HDL_ORI'
names(mme_m3r)[names(mme_m3r) == 'V15'] <- 'TRIGLY_ORI'
names(mme_m3r)[names(mme_m3r) == 'V16'] <- 'HB_ORI'
names(mme_m3r)[names(mme_m3r) == 'V17'] <- 'SMOKE'
names(mme_m3r)[names(mme_m3r) == 'V18'] <- 'DRUGINS'
names(mme_m3r)[names(mme_m3r) == 'V19'] <- 'DRUGHT'
names(mme_m3r)[names(mme_m3r) == 'V20'] <- 'TREATD5'
names(mme_m3r)[names(mme_m3r) == 'V21'] <- 'DRUGICD'
names(mme_m3r)[names(mme_m3r) == 'V22'] <- 'DRUGLP'
names(mme_m3r)[names(mme_m3r) == 'V23'] <- 'FMHTN'
names(mme_m3r)[names(mme_m3r) == 'V24'] <- 'FMHEA'
names(mme_m3r)[names(mme_m3r) == 'V25'] <- 'FMDM'
names(mme_m3r)[names(mme_m3r) == 'V26'] <- 'PRT16_U'
names(mme_m3r)[names(mme_m3r) == 'V27'] <- 'TREATD14'
names(mme_m3r)[names(mme_m3r) == 'V28'] <- 'KID'
names(mme_m3r)[names(mme_m3r) == 'V29'] <- 'KIDAG'
names(mme_m3r)[names(mme_m3r) == 'V30'] <- 'KIDCU'
names(mme_m3r)[names(mme_m3r) == 'V31'] <- 'TOTALC'
names(mme_m3r)[names(mme_m3r) == 'V32'] <- 'PHYACTL'
names(mme_m3r)[names(mme_m3r) == 'V33'] <- 'PHYACTM'
names(mme_m3r)[names(mme_m3r) == 'V34'] <- 'PHYACTH'
names(mme_m3r)[names(mme_m3r) == 'V35'] <- 'BODYFAT'
names(mme_m3r)[names(mme_m3r) == 'V36'] <- 'MET_CAL'
names(mme_m3r)[names(mme_m3r) == 'V37'] <- 'PA_NEW'
names(mme_m3r)[names(mme_m3r) == 'V38'] <- 'SBP'
names(mme_m3r)[names(mme_m3r) == 'V39'] <- 'DBP'
names(mme_m3r)[names(mme_m3r) == 'V40'] <- 'eGFR'
names(mme_m3r)[names(mme_m3r) == 'V41'] <- 'BMI'
names(mme_m3r)[names(mme_m3r) == 'V42'] <- 'DRK_NEW'
