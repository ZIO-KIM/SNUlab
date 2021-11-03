
#### Install ####
install.packages('depmixS4') 
install.packages('poLCA')
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
library(depmixS4)
library(poLCA)
#################


#### read df

mme <- read.csv('data\\MME_data\\MME_preprocessed.csv', encoding = 'euc-kr')
mme_f <- read.csv('data\\MME_data\\MME_F_preprocessed.csv', encoding = 'euc-kr')
mme_m <- read.csv('data\\MME_data\\MME_M_preprocessed.csv', encoding = 'euc-kr')


# simLCA <- function(alpha, ProbMat, sampleSize, nsim) {
#     ## Reformat the probability Matrix to a form required by poLCA.simdata

#     probs = vector("list", nrow(ProbMat))
    
#     for (i in 1:nrow(ProbMat)) {
#     probs[[i]] = cbind(ProbMat[i,], 1 - ProbMat[i,])
#     }
    
#     X = poLCA.simdata(N = sampleSize*nsim, probs = probs, P = alpha)$dat
#     split(X, rep(1:nsim, each=sampleSize))
# }

# set.seed(37421)
# X = simLCA(alpha, mme, sampleSize=50, nsim=1)[[1]]
# head(X)

colnames(mme)

model_definition <- mix(list(AGE ~ 1, GLU0_ORI ~ 1, R_GTP_TR ~ 1, 
AST_ORI ~ 1, ALT_ORI ~ 1, TCHL_ORI ~ 1, HDL_ORI ~ 1, TRIGLY_ORI ~ 1, HB_ORI ~ 1, TOTALC ~ 1, 
PHYACTL ~ 1, PHYACTM ~ 1, PHYACTH ~ 1, MET_CAL ~ 1, SBP ~ 1, DBP ~ 1, eGFR ~ 1, BMI ~ 1),
 family = list(multinomial("identity"), #For every corresponding 
 multinomial("identity"),  #  indicator a family of distribution 
 multinomial("identity"),  # should be indicated in the list.
 multinomial("identity"), multinomial("identity"),multinomial("identity"),
 multinomial("identity"), multinomial("identity"), multinomial("identity"),
 multinomial("identity"), multinomial("identity"), multinomial("identity"),
 multinomial("identity"), multinomial("identity"), multinomial("identity"),
 multinomial("identity"), multinomial("identity"), multinomial("identity")),
 data = mme,
 nstates = 2, #This is the number of classes
 nstart = c(0.5, 0.5), # Prior probabilities of classes
 initdata = mme #Our data
)
fit.mod <- fit(model_definition)   # Fit the model

fit.mod
