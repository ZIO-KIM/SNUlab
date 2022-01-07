
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

setwd('D:\\SNUlab\\data\\out of hospital sudden cardiac arrest\\')

weather_0819 <- read.csv('weather_0819_zio.csv', encoding = 'euc-kr')
weather_index <- read.csv("weather_index.csv")

weather_0819 <- merge(weather_0819, weather_index, by = "지점") ; length(unique(weather_0819$air_out_idx)) # 수도권 72곳 중 63군데 matched

weather_0819 <- weather_0819 %>% arrange(air_out_idx, dt) ; weather_0819$date = as.factor(weather_0819$dt)

## humidity NA 몇개 검색해서 넣기 (3곳 17days: 고양시 덕양구(19) 8days, 수원시 영통구(126) 8days, 경기도 의정부시(182) 1day) 
weather_0819$humi_mean <- 
  ifelse(weather_0819$air_out_idx==19 & is.na(weather_0819$humi_mean) & weather_0819$date=="2013-08-17", 80.42, 
         ifelse(weather_0819$air_out_idx==19 & is.na(weather_0819$humi_mean) & weather_0819$date=="2013-08-18", 85.88,
                ifelse(weather_0819$air_out_idx==19 & is.na(weather_0819$humi_mean) & weather_0819$date=="2013-08-19", 76.25,
                       ifelse(weather_0819$air_out_idx==19 & is.na(weather_0819$humi_mean) & weather_0819$date=="2013-08-20", 71.63,
                              ifelse(weather_0819$air_out_idx==19 & is.na(weather_0819$humi_mean) & weather_0819$date=="2013-08-21", 71.42,
                                     ifelse(weather_0819$air_out_idx==19 & is.na(weather_0819$humi_mean) & weather_0819$date=="2013-12-08", 80.42,
                                            ifelse(weather_0819$air_out_idx==19 & is.na(weather_0819$humi_mean) & weather_0819$date=="2013-12-09", 86.21,       
                                                   ifelse(weather_0819$air_out_idx==19 & is.na(weather_0819$humi_mean) & weather_0819$date=="2015-10-29", 69.92,       
                                                          
                                                          # weather_0819$air_out_idx==126
                                                          ifelse(weather_0819$air_out_idx==126 & is.na(weather_0819$humi_mean) & weather_0819$date=="2017-06-30", 70,       
                                                                 
                                                                 # weather_0819$air_out_idx==171
                                                                 ifelse(weather_0819$air_out_idx==171 & is.na(weather_0819$humi_mean) & weather_0819$date=="2017-05-16", 75.04,
                                                                        ifelse(weather_0819$air_out_idx==171 & is.na(weather_0819$humi_mean) & weather_0819$date=="2017-05-17", 67.25,
                                                                               ifelse(weather_0819$air_out_idx==171 & is.na(weather_0819$humi_mean) & weather_0819$date=="2017-05-18", 66.58,
                                                                                      ifelse(weather_0819$air_out_idx==171 & is.na(weather_0819$humi_mean) & weather_0819$date=="2017-06-13", 78.71,
                                                                                             ifelse(weather_0819$air_out_idx==171 & is.na(weather_0819$humi_mean) & weather_0819$date=="2017-06-21", 75.33,
                                                                                                    ifelse(weather_0819$air_out_idx==171 & is.na(weather_0819$humi_mean) & weather_0819$date=="2017-06-25", 85.5,
                                                                                                           ifelse(weather_0819$air_out_idx==171 & is.na(weather_0819$humi_mean) & weather_0819$date=="2017-06-29", 79.96,
                                                                                                                  ifelse(weather_0819$air_out_idx==171 & is.na(weather_0819$humi_mean) & weather_0819$date=="2017-06-30", 80.63,
                                                                                                                         
                                                                                                                         # weather_0819$air_out_idx==182
                                                                                                                         ifelse(weather_0819$air_out_idx==182 & is.na(weather_0819$humi_mean) & weather_0819$date=="2017-12-28", 63,
                                                                                                                                
                                                                                                                                weather_0819$humi_mean))))))))))))))))))

sum(is.na(weather_0819$humi_mean)) 

## temp NA 하나 검색해서 넣기 (경기도 의정부시(128) 2017.12.28)
weather_0819$temp_mean <- ifelse(is.na(weather_0819$temp_mean), 0.2083, weather_0819$temp_mean)  # temp_mean NA면 0.2083로 대체

sum(is.na(weather_0819$temp_mean)) 


# 54,69,83,148,93,106->200  
weather_1317_3_54=weather_0819[which(weather_0819$air_out_idx==200),] ; weather_1317_3_54$air_out_idx=54
weather_1317_3_69=weather_0819[which(weather_0819$air_out_idx==200),] ; weather_1317_3_69$air_out_idx=69
weather_1317_3_83=weather_0819[which(weather_0819$air_out_idx==200),] ; weather_1317_3_83$air_out_idx=83
weather_1317_3_148=weather_0819[which(weather_0819$air_out_idx==200),] ; weather_1317_3_148$air_out_idx=148
weather_1317_3_93=weather_0819[which(weather_0819$air_out_idx==200),] ; weather_1317_3_93$air_out_idx=93
weather_1317_3_106=weather_0819[which(weather_0819$air_out_idx==200),] ; weather_1317_3_106$air_out_idx=106

# 127,128,181->125
weather_1317_3_127=weather_0819[which(weather_0819$air_out_idx==125),] ; weather_1317_3_127$air_out_idx=127
weather_1317_3_128=weather_0819[which(weather_0819$air_out_idx==125),] ; weather_1317_3_128$air_out_idx=128
weather_1317_3_181=weather_0819[which(weather_0819$air_out_idx==125),] ; weather_1317_3_181$air_out_idx=181

# 138,139->27
weather_1317_3_138=weather_0819[which(weather_0819$air_out_idx==27),] ; weather_1317_3_138$air_out_idx=138
weather_1317_3_139=weather_0819[which(weather_0819$air_out_idx==27),] ; weather_1317_3_139$air_out_idx=139

# 15,20,47->231
weather_1317_3_15=weather_0819[which(weather_0819$air_out_idx==231),] ; weather_1317_3_15$air_out_idx=15
weather_1317_3_20=weather_0819[which(weather_0819$air_out_idx==231),] ; weather_1317_3_20$air_out_idx=20
weather_1317_3_47=weather_0819[which(weather_0819$air_out_idx==231),] ; weather_1317_3_47$air_out_idx=47

# 28,92->131
weather_1317_3_28=weather_0819[which(weather_0819$air_out_idx==131),] ; weather_1317_3_28$air_out_idx=28
weather_1317_3_92=weather_0819[which(weather_0819$air_out_idx==131),] ; weather_1317_3_92$air_out_idx=92

# 40->136
weather_1317_3_40=weather_0819[which(weather_0819$air_out_idx==136),] ; weather_1317_3_40$air_out_idx=40
# 


weather_1317_4=rbind(weather_0819,
                     
                     weather_1317_3_54,weather_1317_3_69,weather_1317_3_83,weather_1317_3_148,weather_1317_3_93,weather_1317_3_106,
                     
                     weather_1317_3_127,weather_1317_3_128,weather_1317_3_181,
                     
                     weather_1317_3_138,weather_1317_3_139,
                     
                     weather_1317_3_15,weather_1317_3_20,weather_1317_3_47,
                     
                     weather_1317_3_28,weather_1317_3_92,
                     
                     weather_1317_3_40,
                     
                     # weather_1317_3_169, 
                     
                     # weather_1317_3_170,
                     
                     # weather_1317_3_114,
                     
                     # weather_1317_3_237,
                     
                     # weather_1317_3_122,
                     
                     # weather_1317_3_113,
                     
                     # weather_1317_3_168,
                     
                     # weather_1317_3_177,
                     
                     # weather_1317_3_43,
                     
                     # weather_1317_3_110,
                     
                     # weather_1317_3_197, 
                     
                     # weather_1317_3_144,
                     
                     # weather_1317_3_6
)


length(unique(weather_1317_4$air_out_idx)) # 72
a=data.frame(weather_1317_4[is.na(weather_1317_4$humi_mean),])