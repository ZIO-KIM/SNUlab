OPTIONS VALIDVARNAME=ANY; 
LIBNAME zio "D:\SNUlab\SAS";
LIBNAME biobank "D:\SNUlab\SAS\UKBIOBANK"; 
LIBNAME result "D:\SNUlab\SAS\Results"; 


/* 고혈압 환자군만 뽑아서 PS Match - 229,308 */ 
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

	match method=optimal(k=1) stat=lps caliper=0.25;

	assess lps var=(WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed) 
	/ weight=none plots=(boxplot barchart);

	output out(obs=match)=zio.Outgs_UKB_HBP_optimal lps=_Lps matchid=_MatchID;
run;

ods graphics on; 
proc phreg data=zio.Outgs_UKB_HBP plot(overlay)=survival; 

	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med;

	model TIME*N18(0) = WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med; 

run; 

/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 




/* 고혈압 환자군 중 HTN 약물 먹은 사람만 뽑아서, ARB_ACEi 1/0 기준으로 PS Match */ 

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

	output out(obs=match)=zio.Outgs_UKB_HBP_ARBACEI lps=_Lps matchid=_MatchID;
run;

ods graphics on; 
proc phreg data=zio.Outgs_UKB_HBP_ARBACEI plot(overlay)=survival; 

	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi;

	model TIME*N18(0) = WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi; 

run; 

/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 


/* 약을 아예 안 먹은 사람 / ARB_ACEi 먹은 사람 기준으로 PS Match */ 
* 변수 ARB_ACEi2; 
* ARB_ACEi와 Other_HTN_med 둘 다 먹은 사람 자름, optimal로 변경; 

/* PS Match */ 
ods graphics on;
proc psmatch data=zio.ukb_1st_final_dropdup;
	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed
	Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi2;

	psmodel ARB_ACEi2(Treated='1')= WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed;

	match method=optimal(k=1) stat=lps caliper=0.3;

	assess lps var=(WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed) 
	/ weight=none plots=(boxplot barchart);

	output out(obs=match)=zio.Outgs_UKB_HBP_ARBACEI2 lps=_Lps matchid=_MatchID;
run;

ods graphics on; 
proc phreg data=zio.Outgs_UKB_HBP_ARBACEI2 plot(overlay)=survival; 

	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi2;

	model TIME*N18(0) = WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed ARB_ACEi2; 

run; 

/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 




/* 약을 아예 안 먹은 사람 / Other_HTN_med 먹은 사람 기준으로 PS Match */ 
* 변수 HTN_med; 

/* PS Match */ 
ods graphics on;
proc psmatch data=zio.ukb_1st_final_new2;
	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed
	Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med;

	psmodel HTN_med(Treated='1')= WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed;

	match method=greedy(k=1) stat=lps caliper=0.25;

	assess lps var=(WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed) 
	/ weight=none plots=(boxplot barchart);

	output out(obs=match)=zio.Outgs_UKB_HBP_Other lps=_Lps matchid=_MatchID;
run;

ods graphics on; 
proc phreg data=zio.Outgs_UKB_HBP_Other plot(overlay)=survival; 

	class SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed  
	Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med;

	model TIME*N18(0) = WSTC HGHT AGE SBP DBP ALT_num AST_num CREA_num GGT_num HDL_num LDL_num TG_num SEX PA_NEW FM_HISTORY_Heart_disease FM_HISTORY_Stroke 
	FM_HISTORY_High_blood_pressure FM_HISTORY_Diabetes Stroke_diagnosed Heart_disease_diagnosed Diabetes_diagnosed High_Cholesterol_diagnosed HTN_med; 

run; 

/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 

























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
