
install.packages('dlnm')
install.packages('splines')

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
#################

#### read df

patient <- read.csv("data\\급성심장정지조사(08-19)SAS\\patient.csv", encoding = "euc-kr")
hospital <- read.csv("data\\급성심장정지조사(08-19)SAS\\hospital.csv", encoding = "euc-kr")

################

#### GLM test ####

colnames(hospital)

summary(model1 <- glm(count ~ SO2_mean + SO2_max + CO_mean + CO_max + O3_mean + O3_max + 
NO2_mean + NO2_max + PM10_mean + PM10_max + PM25_mean + PM25_max + temp_mean + temp_max + 
rain_mean + rain_max + humi_mean + humi_max
, family="poisson", data=hospital))

####################

#### 

# create crossbasis
lag = 7

# NO2
kno <- equalknots(patient$NO2_mean,nk=2)
klag <- logknots(lag,nk=2)

ns.basis_no <- crossbasis(patient$NO2_mean,argvar=list(knots=kno),group=patient$air_out_idx,
                          arglag=list(knots=klag),
                          lag=lag) ;#ns.basis_no
patient$ns.basis_no <- crossbasis(patient$NO2_mean,argvar=list(knots=kno),group=patient$air_out_idx,
                                    arglag=list(knots=klag),
                                    lag=lag) ;#patient$ns.basis_no

# SO2
#lag = 1
kso <- equalknots(patient$SO2_mean,nk=2)
klag <- logknots(lag,nk=2)
# CROSSBASIS MATRIX
ns.basis_so <- crossbasis(patient$SO2_mean,argvar=list(knots=kso),group=patient$air_out_idx,
                          arglag=list(knots=klag),
                          lag=lag) ;#ns.basis_so
patient$ns.basis_so <- crossbasis(patient$SO2_mean,argvar=list(knots=kso),group=patient$air_out_idx,
                                    arglag=list(knots=klag),      
                                    lag=lag) ;#patient$ns.basis_so


# CO
kco <- equalknots(patient$CO_mean,nk=2)
klag <- logknots(lag,nk=2)
# CROSSBASIS MATRIX
ns.basis_co <- crossbasis(patient$CO_mean,argvar=list(knots=kco),group=patient$air_out_idx,
                          arglag=list(knots=klag),    
                          lag=lag) ;#ns.basis_co
patient$ns.basis_co <- crossbasis(patient$CO_mean,argvar=list(knots=kco),group=patient$air_out_idx,
                                    arglag=list(knots=klag),   
                                    lag=lag) ; # patient$ns.basis_co


# O3
ko3 <- equalknots(patient$O3_mean,nk=2)
klag <- logknots(lag,nk=2)
# CROSSBASIS MATRIX
ns.basis_o3 <- crossbasis(patient$O3_mean,argvar=list(knots=ko3),group=patient$air_out_idx,
                          arglag=list(knots=klag), 
                          lag=lag) ;#ns.basis_o3
patient$ns.basis_o3 <- crossbasis(patient$O3_mean,argvar=list(knots=ko3),group=patient$air_out_idx,
                                    arglag=list(knots=klag),
                                    lag=lag) ;#patient$ns.basis_o3     


# PM10
kpm <- equalknots(patient$PM10_mean,nk=2)
klag <- logknots(lag,nk=2)
# CROSSBASIS MATRIX
ns.basis_pm <- crossbasis(patient$PM10_mean,argvar=list(knots=kpm),group=patient$air_out_idx,
                          arglag=list(knots=klag),
                          lag=lag) ;#ns.basis_pm
patient$ns.basis_pm <- crossbasis(patient$PM10_mean,argvar=list(knots=kpm),group=patient$air_out_idx,
                                    arglag=list(knots=klag),
                                    lag=lag) ;#patient$ns.basis_pm

# temp_tc - 일단 빼고 (max - min임)
ktemp_tc <- equalknots(patient$temp_tc_total,nk=2)
klag <- logknots(1,nk=1)

ns.basis_temp_tc <- crossbasis(patient$temp_tc_total,argvar=list(knots=ktemp_tc),group=patient$air_out_idx,
                               arglag=list(knots=klag),lag=0) ;#ns.basis_temp_tc
patient$ns.basis_temp_tc <- crossbasis(patient$temp_tc_total,argvar=list(knots=ktemp_tc),group=patient$air_out_idx,
                                         arglag=list(knots=klag),lag=0) ;#patient$ns.basis_temp_tc


# tmp_mean_total <- tmp_mean으로 변경 (일단)
ktemp_tc2 <- equalknots(patient$temp_mean,nk=2)
ns.basis_temp_mean <- crossbasis(patient$temp_mean,argvar=list(knots=ktemp_tc2),group=patient$air_out_idx,
                                 arglag=list(knots=klag),lag=0) ;#ns.basis_temp_tc
patient$ns.basis_temp_mean <- crossbasis(patient$temp_mean,argvar=list(knots=ktemp_tc2),group=patient$air_out_idx,
                                           arglag=list(knots=klag),lag=0) ;#patient$ns.basis_temp_tc


# humi
khumi <- equalknots(patient$humi_mean,nk=2)
klag <- logknots(1,nk=1)
# CROSSBASIS MATRIX
ns.basis_humi <- crossbasis(patient$humi_mean,argvar=list(knots=khumi),group=patient$air_out_idx,
                            arglag=list(knots=klag),lag=0) ;#ns.basis_humi
patient$ns.basis_humi <- crossbasis(patient$humi_mean,argvar=list(knots=khumi),group=patient$air_out_idx,
                                      arglag=list(knots=klag),lag=0) ;#patient$ns.basis_humi

length(unique(patient$air_out_idx))


patient$PRE_ER_ARREST_DT
# hist(patient$ns.basis_humi)

colnames(patient)
library(lubridate)
patient$day=wday(
  patient$PRE_ER_ARREST_DT,
  label = FALSE,
  abbr = TRUE,
  week_start = getOption("lubridate.week.start", 7),
  locale = Sys.getlocale("LC_TIME")
)
colnames(patient)
patient$count[1:1000]
summary(model1 <- glm(count ~ ns.basis_no , family="quasipoisson", data=patient))

cor(patient[,c(4,11,17,23,29,35,41,47,53)],use="complete.obs")
cor(patient$count,patient$PM10_mean)
patient_cor=patient[complete.cases(patient[,c(4,11,17,23,29,35,41,47,53)]),c(4,11,17,23,29,35,41,47,53)]
cor(patient_cor)

table(patient$count,patient$day)
percentiles_no <- round(quantile(patient$NO2_mean,c(0.05,0.25,0.75,0.95),na.rm=TRUE), digits=4); percentiles_no
ns.pred_no <- crosspred(ns.basis_no,model1,at=seq(percentiles_no[1],percentiles_no[4], 0.001),cen = percentiles_no[1]);


plot(ns.pred_no,zlab="RR",xlab="NO2_mean")
plot(ns.pred_no,"overall",xlab="NO2_mean")



tail(cbind(ns.pred_no$allRRfit,ns.pred_no$allRRlow,ns.pred_no$allRRhigh),1)

