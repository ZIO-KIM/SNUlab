LIBNAME zio "D:\SNUlab\SAS";

/* PS Match */ 
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

/* sort by ps score */ 
proc sort data=zio.outgs out=zio.outgs1;
by _ps_;
run;

/* print 10 ppl with lowest ps score */ 
proc print data=zio.outgs1(obs=10);
var NIHID _PS_ _LPS _MatchWgt_ _MatchID;
run;

/* logistic */ 
proc logistic data=zio.outgs;
model final_CKD(event='1') = AGE SEX HEIGHT WEIGHT WAIST GLU0_ORI R_GTP_TR AST_ORI ALT_ORI
	TCHL_ORI HDL_ORI TRIGLY_ORI HB_ORI SMOKE DRUGINS DRUGICD DRUGLP FMHTN FMHEA FMDM PRT16_U
	KID TOTALC MET_CAL SBP DBP eGFR BMI ht_drug_90 / link=logit technique=fisher;
run;

/* Cox */ 





