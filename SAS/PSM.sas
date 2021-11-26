LIBNAME zio "D:\SNUlab\SAS";

/* PS Match - HT*/ 
ods graphics on;
proc psmatch data=zio.HT_psm;
	class ht_drug_90;
	psmodel ht_drug_90(Treated='1')= AGE SEX HEIGHT WEIGHT WAIST GLU0_ORI R_GTP_TR AST_ORI ALT_ORI
	TCHL_ORI HDL_ORI TRIGLY_ORI HB_ORI SMOKE DRUGINS DRUGICD DRUGLP FMHTN FMHEA FMDM PRT16_U
	KID TOTALC MET_CAL SBP DBP eGFR BMI;
	match method=optimal(k=1) stat=lps caliper=.;
	assess lps var=(AGE SEX HEIGHT WEIGHT WAIST GLU0_ORI R_GTP_TR AST_ORI ALT_ORI
	TCHL_ORI HDL_ORI TRIGLY_ORI HB_ORI SMOKE DRUGINS DRUGICD DRUGLP FMHTN FMHEA FMDM PRT16_U
	KID TOTALC MET_CAL SBP DBP eGFR BMI) / weight=none plots=(boxplot barchart);
	output out(obs=match)=zio.Outgs lps=_Lps matchid=_MatchID;
run;

/* PS Match - AR*/ 
ods graphics on;
proc psmatch data=zio.AR_psm;
	class ar_drug_90;
	psmodel ar_drug_90(Treated='1')= AGE SEX HEIGHT WEIGHT WAIST GLU0_ORI R_GTP_TR AST_ORI ALT_ORI
	TCHL_ORI HDL_ORI TRIGLY_ORI HB_ORI SMOKE DRUGINS DRUGICD DRUGLP FMHTN FMHEA FMDM PRT16_U
	KID TOTALC MET_CAL SBP DBP eGFR BMI;
	match method=optimal(k=1) stat=lps caliper=.;
	assess lps var=(AGE SEX HEIGHT WEIGHT WAIST GLU0_ORI R_GTP_TR AST_ORI ALT_ORI
	TCHL_ORI HDL_ORI TRIGLY_ORI HB_ORI SMOKE DRUGINS DRUGICD DRUGLP FMHTN FMHEA FMDM PRT16_U
	KID TOTALC MET_CAL SBP DBP eGFR BMI) / weight=none plots=(boxplot barchart);
	output out(obs=match)=zio.Outgs_AR lps=_Lps matchid=_MatchID;
run;

/* PS Match - DM */ 
ods graphics on;
proc psmatch data=zio.DM_all_psm;
	class dm_all_drug_90;
	psmodel dm_all_drug_90(Treated='1')= AGE SEX HEIGHT WEIGHT WAIST GLU0_ORI R_GTP_TR AST_ORI ALT_ORI
	TCHL_ORI HDL_ORI TRIGLY_ORI HB_ORI SMOKE DRUGINS DRUGICD DRUGLP FMHTN FMHEA FMDM PRT16_U
	KID TOTALC MET_CAL SBP DBP eGFR BMI;
	match method=optimal(k=1) stat=lps caliper=.;
	assess lps var=(AGE SEX HEIGHT WEIGHT WAIST GLU0_ORI R_GTP_TR AST_ORI ALT_ORI
	TCHL_ORI HDL_ORI TRIGLY_ORI HB_ORI SMOKE DRUGINS DRUGICD DRUGLP FMHTN FMHEA FMDM PRT16_U
	KID TOTALC MET_CAL SBP DBP eGFR BMI) / weight=none plots=(boxplot barchart);
	output out(obs=match)=zio.Outgs_DM lps=_Lps matchid=_MatchID;
run;

/* sort by ps score */ 
proc sort data=zio.outgs out=zio.outgs1;
by _ps_;
run;

/* print 10 ppl with lowest ps score */ 
proc print data=zio.outgs1(obs=10);
var NIHID _PS_ _LPS _MatchWgt_ _MatchID;
run;

/* logistic - HT */ 
proc logistic data=zio.outgs;
model final_CKD(event='1') = AGE SEX HEIGHT WEIGHT WAIST GLU0_ORI R_GTP_TR AST_ORI ALT_ORI
	TCHL_ORI HDL_ORI TRIGLY_ORI HB_ORI SMOKE DRUGINS DRUGICD DRUGLP FMHTN FMHEA FMDM PRT16_U
	KID TOTALC MET_CAL SBP DBP eGFR BMI ht_drug_90 / link=logit technique=fisher;
run;

/* logistic - AR */ 
proc logistic data=zio.outgs_ar;
model final_CKD(event='1') = AGE SEX HEIGHT WEIGHT WAIST GLU0_ORI R_GTP_TR AST_ORI ALT_ORI
	TCHL_ORI HDL_ORI TRIGLY_ORI HB_ORI SMOKE DRUGINS DRUGICD DRUGLP FMHTN FMHEA FMDM PRT16_U
	KID TOTALC MET_CAL SBP DBP eGFR BMI ar_drug_90 / link=logit technique=fisher;
run;

/* logistic - DM */ 
proc logistic data=zio.outgs_dm;
model final_CKD(event='1') = AGE SEX HEIGHT WEIGHT WAIST GLU0_ORI R_GTP_TR AST_ORI ALT_ORI
	TCHL_ORI HDL_ORI TRIGLY_ORI HB_ORI SMOKE DRUGINS DRUGICD DRUGLP FMHTN FMHEA FMDM PRT16_U
	KID TOTALC MET_CAL SBP DBP eGFR BMI dm_all_drug_90 / link=logit technique=fisher;
run;

/* Cox - HT */ 
ods graphics on; 
proc phreg data=zio.outgs plot(overlay)=survival; 
	model TIME*final_CKD(1) = ht_drug_90; 
	baseline covariates=zio.outgs out=_null_; 
run; 

/* Cox - AR */ 
ods graphics on; 
proc phreg data=zio.outgs_ar plot(overlay)=survival; 
	model TIME*final_CKD(1) = ar_drug_90; 
	baseline covariates=zio.outgs_ar out=_null_; 
run; 

/* Cox - DM */ 
ods graphics on; 
proc phreg data=zio.outgs_dm plot(overlay)=survival; 
	model TIME*final_CKD(1) = dm_all_drug_90; 
	baseline covariates=zio.outgs_dm out=_null_; 
run; 





