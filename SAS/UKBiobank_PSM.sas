OPTIONS VALIDVARNAME=ANY; 
LIBNAME zio "D:\SNUlab\SAS";
LIBNAME biobank "D:\SNUlab\SAS\UKBIOBANK"; 
LIBNAME result "D:\SNUlab\SAS\Results"; 

/* 고혈압 환자군만 뽑아서 PS Match */ 
PROC SQL;
CREATE TABLE zio.ukb_1st_final_HBP AS 
SELECT *
FROM zio.UKB_1ST_FINAL
WHERE High_Blood_Pressure_diagnosed = 1; 
QUIT; 

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

	output out(obs=match)=zio.Outgs_UKB_HBP lps=_Lps matchid=_MatchID;
run;

ods graphics on; 
proc phreg data=zio.Outgs_UKB_HBP plot(overlay)=survival; 

	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med;

	model TIME*N18(0) = WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med; 

run; 









data zio.ukb_1st_final2;
set zio.ukb_1st_final;
if HTN_med=1 then high_blood_pressure_diagnosed=1;
high_blood_pressure_diagnosed2=high_blood_pressure_diagnosed;
if SBP >130 or DBP>80 then high_blood_pressure_diagnosed2=1;
run;

proc phreg data=zio.ukb_1st_final2 plot(overlay)=survival; 
where high_blood_pressure_diagnosed2=1;
	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med;

	model TIME*N18(0) = WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med; 

run; 

proc freq data=zio.ukb_1st_final2;
table high_blood_pressure_diagnosed*HTN_MED*N18;
run;
