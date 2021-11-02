
#### Install ####
install.packages('depmixS4') 
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
#################


#### read df

mme <- read.csv('data\\MME_data\\MME_preprocessed.csv', encoding = 'euc-kr')
mme_f <- read.csv('data\\MME_data\\MME_F_preprocessed.csv', encoding = 'euc-kr')
mme_m <- read.csv('data\\MME_data\\MME_M_preprocessed.csv', encoding = 'euc-kr')


model_definition <- mix(list(trust_family ~ 1, trust ~ 1, trust_strangers ~ 1),
 family = list(multinomial("identity"), #For every corresponding 
 multinomial("identity"),  #  indicator a family of distribution 
 multinomial("identity")), # should be indicated in the list.
 data = wvs.canada,
 nstates = 2, #This is the number of classes
 nstart=c(0.5, 0.5), # Prior probabilities of classes
 initdata = wvs.canada #Our data
)
fit.mod <- fit(model_definition)   # Fit the model
