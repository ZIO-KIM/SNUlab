OPTIONS VALIDVARNAME=ANY; 
LIBNAME zio "D:\SNUlab\SAS";
LIBNAME biobank "D:\SNUlab\SAS\UKBIOBANK"; 
LIBNAME outdata "D:\SNUlab\SAS\Outdata"; 
LIBNAME result "D:\SNUlab\SAS\Results"; 


/* 고혈압 환자군 중 HTN 약물 1/0 기준으로 PS Match */ 

/* 고혈압 환자군만 뽑기 - 229,308 */ 
PROC SQL;
CREATE TABLE zio.ukb_1st_final_HBP AS 
SELECT *
FROM zio.UKB_1ST_FINAL
WHERE High_Blood_Pressure_diagnosed = 1; 
QUIT; 

/* Match 전 check */ 
proc freq data=zio.ukb_1st_final_HBP;
table high_blood_pressure_diagnosed*HTN_MED*N18;
run;

/* PS Match */ 
ods graphics on;
proc psmatch data=zio.ukb_1st_final_HBP;
	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed
	Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med;

	psmodel HTN_med(Treated='1')= WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed;

	match method=greedy(k=1) stat=lps caliper=0.25;

	assess lps var=(WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed) 
	/ weight=none plots=(boxplot barchart);

	output out(obs=match)=outdata.Outgs_UKB_HBP_HTNmed lps=_Lps matchid=_MatchID;
run;

proc univariate data=outdata.Outgs_ukb_hbp_htnmed; 
class HTN_med; 
var _PS_; 
histogram _PS_ / normal; 

ods graphics on; 
proc phreg data=outdata.Outgs_UKB_HBP_HTNmed plot(overlay)=survival; 

	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med(ref='0');

	model TIME*N18(0) =  HTN_med WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed; 

run; 

/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 




/* 고혈압 환자군 중 HTN 약물 먹은 사람만 뽑아서, ARB_ACEi 1/0 기준으로 PS Match - 이건 안해도 됨 */ 
/* ARB_ACEi : 1 - ARB_ACEi 먹은 사람, 0 - ARB_ACEi 안 먹은 사람 */ 

* HTN_med = 1, High_Blood_Pressure_diagnosed = 1인 테이블 생성; 
PROC SQL;
CREATE TABLE zio.ukb_1st_final_HBP AS 
SELECT *
FROM zio.ukb_1st_final
WHERE HTN_med = 1 AND High_Blood_Pressure_diagnosed = 1; 
QUIT; 

/* Match 전 check */ 
proc freq data=zio.ukb_1st_final_HBP_med;
table ARB_ACEi*HTN_med;
run;

/* PS Match */ 
ods graphics on;
proc psmatch data=zio.ukb_1st_final_HBP_med;
	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed
	Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi;

	psmodel ARB_ACEi(Treated='1')= WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed;

	match method=greedy(k=1) stat=lps caliper=0.25;

	assess lps var=(WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed) 
	/ weight=none plots=(boxplot barchart);

	output out(obs=match)=outdata.Outgs_UKB_HBP_ARBACEI lps=_Lps matchid=_MatchID;
run;

proc univariate data=outdata.Outgs_UKB_HBP_ARBACEI; 
class ARB_ACEi; 
var _PS_; 
histogram _PS_ / normal; 

ods graphics on; 
proc phreg data=zio.Outgs_UKB_HBP_ARBACEI plot(overlay)=survival; 

	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi(ref='0');

	model TIME*N18(0) = WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi; 

run; 

/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 


/* ARB_ACEi 먹은 사람 / Other_HTN_med 먹은 사람 기준으로 PS Match */ 
* 변수 ARB_ACEi2; 

* ARB_ACEI2 변수 생성; 
data zio.ukb_1st_final_HBP_ARBACEi2; 
set zio.ukb_1st_final_HBP; 
if HTN_med = 0 then delete; 
if ARB_ACEI=1 then ARB_ACEI2=ARB_ACEI;
if Other_HTN_med = 1 then ARB_ACEI2=0;
run; 

proc freq data=zio.ukb_1st_final_HBP_ARBACEi2; 
table ARB_ACEI2; 

/* PS Match */ 
ods graphics on;
proc psmatch data=zio.ukb_1st_final_HBP_ARBACEi2;
	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed
	Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi2;

	psmodel ARB_ACEi2(Treated='1')= WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed;

	match method=greedy(k=1) stat=lps caliper=0.3;

	assess lps var=(WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed) 
	/ weight=none plots=(boxplot barchart);

	output out(obs=match)=outdata.Outgs_UKB_HBP_ARBACEI2 lps=_Lps matchid=_MatchID;
run;

proc univariate data=outdata.Outgs_UKB_HBP_ARBACEI2; 
class ARB_ACEi2; 
var _PS_; 
histogram _PS_ / normal; 

ods graphics on; 
proc phreg data=outdata.Outgs_UKB_HBP_ARBACEI2 plot(overlay)=survival; 

	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi2(ref='0');

	model TIME*N18(0) = ARB_ACEi2 WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed; 

run; 

/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 




/* 약을 아예 안 먹은 사람 / Other_HTN_med 먹은 사람 기준으로 PS Match */ 
* 변수 HTN_med; 

data zio.ukb_1st_final_HBP_Other;
set zio.ukb_1st_final;
if high_blood_pressure_diagnosed=1;
if HTN_MED=1 and ARB_ACEI=1 then delete;
run;

/* PS Match */ 
ods graphics on;
proc psmatch data=zio.ukb_1st_final_HBP_Other;
	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed
	Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med;

	psmodel HTN_med(Treated='1')= WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed;

	match method=greedy(k=1) stat=lps caliper=0.25;

	assess lps var=(WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed) 
	/ weight=none plots=(boxplot barchart);

	output out(obs=match)=outdata.Outgs_UKB_HBP_Other lps=_Lps matchid=_MatchID;
run;

proc univariate data=outdata.Outgs_UKB_HBP_Other; 
class HTN_med; 
var _PS_; 
histogram _PS_ / normal; 

ods graphics on; 
proc phreg data=outdata.Outgs_UKB_HBP_Other plot(overlay)=survival; 

	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med(ref='0');

	model TIME*N18(0) = HTN_med WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed; 

run; 

/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 


/* 약을 아예 안 먹은 사람 / ARB_ACEi 먹은 사람 기준으로 PS Match */ 
* 변수 ARB_ACEi3 : 1 if ARB_ACEi = 1 / 0 if HTN_med = 0 ; 

data zio.ukb_1st_final_HBP_ARBACEi3; 
set zio.ukb_1st_final; 
ARB_ACEi3 =  HTN_med; 
if Other_HTN_med = 1 then delete; 
run; 

/* PS Match */ 
ods graphics on;
proc psmatch data=zio.ukb_1st_final_HBP_ARBACEi3;
	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed
	Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi3;

	psmodel ARB_ACEi3(Treated='1')= WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed;

	match method=greedy(k=1) stat=lps caliper=0.25;

	assess lps var=(WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed) 
	/ weight=none plots=(boxplot barchart);

	output out(obs=match)=outdata.Outgs_UKB_HBP_ARBACEI3 lps=_Lps matchid=_MatchID;
run;

proc univariate data=outdata.Outgs_UKB_HBP_ARBACEI3; 
class ARB_ACEi3; 
var _PS_; 
histogram _PS_ / normal; 

ods graphics on; 
proc phreg data=outdata.Outgs_UKB_HBP_ARBACEI3 plot(overlay)=survival; 

	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi3(ref='0');

	model TIME*N18(0) = ARB_ACEi3 WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed; 

run; 

/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 


* logistic check; 
proc logistic data=zio.ukb_1st_final_HBP plots=roc;

class SEX (ref='0') PA_NEW (ref = '1') FM_HISTORY_Heart_disease (ref='0') FM_HISTORY_Stroke (ref='0') FM_HISTORY_High_blood_pressure (ref='0') FM_HISTORY_Diabetes (ref='0') Stroke_diagnosed (ref='0')
Heart_disease_diagnosed (ref='0') Diabetes_diagnosed (ref='0') High_Cholesterol_diagnosed (ref='0') HTN_med (ref='0');

model N18(event='1') = WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med/ link=logit technique=fisher;

run;




















/* 전체 PS Match */ 

/* PS Match */ 
ods graphics on;
proc psmatch data=zio.ukb_1st_final;
	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed
	Diabetes_diagnosed High_Cholesterol_diagnosed High_Blood_Pressure_diagnosed HTN_med;

	psmodel HTN_med(Treated='1')= WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed High_Blood_Pressure_diagnosed;

	match method=greedy(k=1) stat=lps caliper=0.25;

	assess lps var=(WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed High_Blood_Pressure_diagnosed) 
	/ weight=none plots=(boxplot barchart);

	output out(obs=match)=zio.Outgs_UKB lps=_Lps matchid=_MatchID;
run;

ods graphics on; 
proc phreg data=zio.Outgs_UKB plot(overlay)=survival; 

	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed High_Blood_Pressure_diagnosed HTN_med;

	model TIME*N18(0) = WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed High_Blood_Pressure_diagnosed HTN_med; 

run; 

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ */ 











