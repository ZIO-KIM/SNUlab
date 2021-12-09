OPTIONS VALIDVARNAME=ANY; 
LIBNAME zio "D:\SNUlab\SAS";
LIBNAME biobank "D:\SNUlab\SAS\UKBIOBANK"; 

/* 필요한 변수만 추출 - UKB45783 검진변수 */ 
OPTIONS VALIDVARNAME=ANY; 
DATA zio.UKB45783_new; 
SET biobank.UKB45783 (encoding = asciiany); 
KEEP eid /* id */ 
'21003-0.0'n '21003-1.0'n '21003-2.0'n '21003-3.0'n /* Age when attended assessment centre */ 
'53-0.0'n '53-1.0'n '53-2.0'n '53-3.0'n /* Date of attending assessment centre */ 
'31-0.0'n /* sex */ 
'50-0.0'n '50-1.0'n '50-2.0'n '50-3.0'n /* standing height */ 
'21002-0.0'n '21002-1.0'n '21002-2.0'n '21002-3.0'n /* weight */ 
'21001-0.0'n '21001-1.0'n '21001-2.0'n '21001-3.0'n /* BMI */ 
'4080-0.0'n '4080-0.1'n '4080-1.0'n '4080-1.1'n '4080-2.0'n '4080-2.1'n '4080-3.0'n '4080-3.1'n /* 	Systolic blood pressure, automated reading */ 
'4079-0.0'n '4079-0.1'n '4079-1.0'n '4079-1.1'n '4079-2.0'n '4079-2.1'n '4079-3.0'n '4079-3.1'n /* 	Diastolic blood pressure, automated reading */ 
'48-0.0'n '48-1.0'n '48-2.0'n '48-3.0'n /* Waist circumference */ 
'4056-0.0'n '4056-1.0'n '4056-2.0'n '4056-3.0'n /* Age stroke diagnosed */ 
'3894-0.0'n '3894-1.0'n '3894-2.0'n '3894-3.0'n /* Age heart attack diagnosed */ 
'3627-0.0'n '3627-1.0'n '3627-2.0'n '3627-3.0'n /* Age angina diagnosed */ 
'2966-0.0'n '2966-1.0'n '2966-2.0'n '2966-3.0'n /* Age high blood pressure diagnosed */ 
'2976-0.0'n '2976-1.0'n '2976-2.0'n '2976-3.0'n /* Age diabetes diagnosed */ 
'6153-0.0'n '6153-0.1'n '6153-0.2'n '6153-0.3'n '6153-1.0'n '6153-1.1'n '6153-1.2'n '6153-1.3'n '6153-2.0'n '6153-2.1'n '6153-2.2'n '6153-2.3'n '6153-3.0'n '6153-3.1'n '6153-3.2'n '6153-3.3'n /* Medication for cholesterol, blood pressure, diabetes, or take exogenous hormones */ 
'6177-0.0'n '6177-0.1'n '6177-0.2'n '6177-1.0'n '6177-1.1'n '6177-1.2'n '6177-2.0'n '6177-2.1'n '6177-2.2'n '6177-3.0'n '6177-3.1'n '6177-3.2'n /* Medication for cholesterol, blood pressure or diabetes */ 
'20414-0.0'n /* Frequency of drinking alcohol - 새로운 변수 받아와서 바꿔야 함! - 그냥 빼야 함 */ 
'874-0.0'n '874-1.0'n '874-2.0'n '874-3.0'n /* Duration of walks */ 
'894-0.0'n '894-1.0'n '894-2.0'n '894-3.0'n /* Duration of moderate activity */ 
'914-0.0'n '914-1.0'n '914-2.0'n '914-3.0'n /* Duration of vigorous activity */ 
'20107-0.0'n '20107-0.1'n '20107-0.2'n '20107-0.3'n '20107-0.4'n '20107-0.5'n '20107-0.6'n '20107-0.7'n '20107-0.8'n '20107-0.9'n 
'20107-1.0'n '20107-1.1'n '20107-1.2'n '20107-1.3'n '20107-1.4'n '20107-1.5'n '20107-1.6'n '20107-1.7'n '20107-1.8'n '20107-1.9'n 
'20107-2.0'n '20107-2.1'n '20107-2.2'n '20107-2.3'n '20107-2.4'n '20107-2.5'n '20107-2.6'n '20107-2.7'n '20107-2.8'n '20107-2.9'n 
'20107-3.0'n '20107-3.1'n '20107-3.2'n '20107-3.3'n '20107-3.4'n '20107-3.5'n '20107-3.6'n '20107-3.7'n '20107-3.8'n '20107-3.9'n /* Illnesses of father */ 
'20110-0.0'n '20110-0.1'n '20110-0.2'n '20110-0.3'n '20110-0.4'n '20110-0.5'n '20110-0.6'n '20110-0.7'n '20110-0.8'n '20110-0.9'n '20110-0.10'n
'20110-1.0'n '20110-1.1'n '20110-1.2'n '20110-1.3'n '20110-1.4'n '20110-1.5'n '20110-1.6'n '20110-1.7'n '20110-1.8'n '20110-1.9'n '20110-1.10'n
'20110-2.0'n '20110-2.1'n '20110-2.2'n '20110-2.3'n '20110-2.4'n '20110-2.5'n '20110-2.6'n '20110-2.7'n '20110-2.8'n '20110-2.9'n '20110-2.10'n
'20110-3.0'n '20110-3.1'n '20110-3.2'n '20110-3.3'n '20110-3.4'n '20110-3.5'n '20110-3.6'n '20110-3.7'n '20110-3.8'n '20110-3.9'n '20110-3.10'n /* Illnesses of mother */;  
RUN; 

/* 필요한 변수만 추출 - UKB45783 약물변수 */ 
OPTIONS VALIDVARNAME=ANY; 
DATA zio.UKB45783_drug; 
SET biobank.UKB45783 (encoding = asciiany); 
KEEP eid /* id */ 
'20003-0.0'n--'20003-3.47'n; 
RUN; 

/* 필요한 변수만 추출 - UKB37332 */ 
OPTIONS VALIDVARNAME=ANY; 
DATA zio.UKB37332_new; 
SET biobank.UKB37332 (encoding = asciiany); 
KEEP eid /* id */ 
'30740-0.0'n '30740-1.0'n /* glucose - 공복혈당과 가장 가까운 변수임, fasting인지 확실치 않음, mean 5.12 (단위가 다르다) */ 
'30730-0.0'n '30730-1.0'n /* Gamma glutamyltransferase */ 
'30650-0.0'n '30650-1.0'n /* Aspartate aminotransferase AST */ 
'30620-0.0'n '30620-1.0'n /* Alanine aminotransferase ALT */ 
'30690-0.0'n '30690-1.0'n /* Cholesterol */ 
'30760-0.0'n '30760-1.0'n /* HDL cholesterol */ 
'30780-0.0'n '30780-1.0'n /* LDL direct */ 
'30870-0.0'n '30870-1.0'n /* Triglycerides */ 
'30700-0.0'n '30700-1.0'n /* Creatinine */; 
RUN; 

/* 필요한 변수만 추출 - UKB46987 Diagnoses */ 
DATA zio.UKB46987_new; 
SET biobank.UKB46987 (encoding=asciiany); 
KEEP eid /* id */ 
'41270-0.0'n--'41270-0.222'n  /* Diagnoses - ICD10 */ 
'41280-0.0'n--'41280-0.222'n  /* Date of first in-patient diagnosis - ICD10 */; 
RUN; 

/* 2021-12-09 */ 
/* UKB46987 Diagnoses ICD9 변수 table 새로 생성 */ 
DATA zio.UKB46987_new_icd9; 
SET biobank.UKB46987 (encoding=asciiany); 
KEEP eid /* id */ 
'41271-0.0'n--'41271-0.46'n  /* Diagnoses - ICD9 */ 
'41281-0.0'n--'41281-0.46'n  /* Date of first in-patient diagnosis - ICD9 */ ; 
RUN; 

/* change UKB37332_new eid from character to numeric */ 
DATA zio.UKB37332_NEW;
SET zio.UKB37332_NEW; 
	eid_num = input(eid, 16.);
RUN;

/* UKB45783_new + UKB37332_new eid로 join */ 
PROC SQL; 
CREATE TABLE zio.UKB_merged AS 
SELECT *
FROM zio.UKB45783_NEW AS a INNER JOIN zio.UKB37332_NEW AS b 
ON a.eid = b.eid_num; 
QUIT; 

/* UKB_merged 에서 1기만 추출하기 (0.0) */ 
DATA zio.UKB_merged_1st; 
SET zio.UKB_merged; 
KEEP eid /* id */ 
'21003-0.0'n /* Age when attended assessment centre */ 
'53-0.0'n  /* Date of attending assessment centre */ 
'31-0.0'n /* sex */ 
'50-0.0'n /* standing height */ 
'21002-0.0'n /* weight */ 
'21001-0.0'n  /* BMI */ 
'4080-0.0'n '4080-0.1'n /* 	Systolic blood pressure, automated reading */ 
'4079-0.0'n '4079-0.1'n /* 	Diastolic blood pressure, automated reading */ 
'48-0.0'n  /* Waist circumference */ 
'4056-0.0'n '4056-1.0'n '4056-2.0'n '4056-3.0'n /* Age stroke diagnosed */ 
'3894-0.0'n '3894-1.0'n '3894-2.0'n '3894-3.0'n /* Age heart attack diagnosed */ 
'3627-0.0'n '3627-1.0'n '3627-2.0'n '3627-3.0'n /* Age angina diagnosed */ 
'2966-0.0'n '2966-1.0'n '2966-2.0'n '2966-3.0'n /* Age high blood pressure diagnosed */ 
'2976-0.0'n '2976-1.0'n '2976-2.0'n '2976-3.0'n /* Age diabetes diagnosed */ 
'6153-0.0'n '6153-0.1'n '6153-0.2'n '6153-0.3'n  /* Medication for cholesterol, blood pressure, diabetes, or take exogenous hormones */ 
'6177-0.0'n '6177-0.1'n '6177-0.2'n  /* Medication for cholesterol, blood pressure or diabetes */ 
'20414-0.0'n /* Frequency of drinking alcohol - 새로운 변수 받아와서 바꿔야 함! */ 
'874-0.0'n /* Duration of walks */ 
'894-0.0'n /* Duration of moderate activity */ 
'914-0.0'n /* Duration of vigorous activity */ 
'20107-0.0'n '20107-0.1'n '20107-0.2'n '20107-0.3'n '20107-0.4'n '20107-0.5'n '20107-0.6'n '20107-0.7'n '20107-0.8'n '20107-0.9'n  /* Illnesses of father */ 
'20110-0.0'n '20110-0.1'n '20110-0.2'n '20110-0.3'n '20110-0.4'n '20110-0.5'n '20110-0.6'n '20110-0.7'n '20110-0.8'n '20110-0.9'n '20110-0.10'n /* Illnesses of mother */
'30730-0.0'n /* Gamma glutamyltransferase */ 
'30650-0.0'n /* Aspartate aminotransferase AST */ 
'30620-0.0'n /* Alanine aminotransferase ALT */ 
'30690-0.0'n /* Cholesterol */ 
'30760-0.0'n /* HDL cholesterol */ 
'30780-0.0'n /* LDL direct */ 
'30870-0.0'n /* Triglycerides */ 
'30700-0.0'n /* Creatinine */; 
RUN; 

/*/* zio.UKB46987_new check CKD patients */ */
/*PROC SQL; */
/*TITLE test;*/
/*SELECT COUNT(eid) as freq*/
/*FROM zio.UKB46987_new*/
/*WHERE '41270-0.0'n = 'N180' or '41270-0.0'n = 'N181' or '41270-0.0'n = 'N182' or '41270-0.0'n = 'N183' or '41270-0.0'n = 'N184' or '41270-0.0'n = 'N185' or '41270-0.0'n = 'N186'*/
/*or '41270-0.0'n = 'N187' or '41270-0.0'n = 'N188' or '41270-0.0'n = 'N189'; */
/*QUIT; */

/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 

/* 2021-12-06 MON ~ 
1. CKD 진단여부, CKD 진단날짜 전처리 - python에서 완료 - ukb46987_n18preprocessed.sas7bdat (icd9 처리까지 완료) 
2. 약물변수들 전처리 - python에서 완료 - ukb45783_drugpreprocessed.sas7bdat
3. Date 변수들 모아서 last follow up 열 만들기 - python 에서 진행중 - 전부 character로만 바꿔서 다시 sas로 가져오자
4. 최종 DF에서 1기만 추출하기 - 완료
5. 기본 검진변수들 전처리 - sas에서 완료 - ukb_merged_1st_preprocessed.sass7bdat
*/ 

* ukb37332 - Date 변수만 추출하기; 
DATA zio.ukb37332_date; 
SET biobank.ukb37332; 
KEEP eid  /* id */
'23048-0.0'n '23048-1.0'n  /* Antigen assay date */ 
'30502-0.0'n '30502-1.0'n  /* Microalbumin in urine acquisition time */ 
'30512-0.0'n '30512-1.0'n  /* Creatinine (enzymatic) in urine acquisition time */ 
'30522-0.0'n '30522-1.0'n  /* Potassium in urine acquisition time */ 
'30601-0.0'n '30601-1.0'n  /* Albumin assay date */ 
'30611-0.0'n '30611-1.0'n  /* Alkaline phosphatase assay date */ 
'30621-0.0'n '30621-1.0'n  /* Alanine aminotransferase assay date */ 
'30631-0.0'n '30631-1.0'n  /* Apolipoprotein A assay date */ 
'30651-0.0'n '30651-1.0'n  /* Aspartate aminotransferase assay date */ 
'30661-0.0'n '30661-1.0'n  /* Direct bilirubin assay date */ 
'30671-0.0'n '30671-1.0'n  /* Urea assay date */ 
'30681-0.0'n '30681-1.0'n  /* Calcium assay date */ 
'30691-0.0'n '30691-1.0'n  /* Cholesterol assay date */ 
'30701-0.0'n '30701-1.0'n  /* Creatinine assay date */ 
'30711-0.0'n '30711-1.0'n  /* C-reactive protein assay date */ 
'30721-0.0'n '30721-1.0'n  /* Cystatin C assay date */ 
'30731-0.0'n '30731-1.0'n  /* Gamma glutamyltransferase assay date */ 
'30741-0.0'n '30741-1.0'n  /* Glucose assay date */ 
'30751-0.0'n '30751-1.0'n  /* Glycated haemoglobin (HbA1c) assay date */ 
'30761-0.0'n '30761-1.0'n  /* HDL cholesterol assay date */ 
'30771-0.0'n '30771-1.0'n  /* IGF-1 assay date */ 
'30781-0.0'n '30781-1.0'n  /* LDL direct assay date */ 
'30791-0.0'n '30791-1.0'n  /* Lipoprotein A assay date */    
'30801-0.0'n '30801-1.0'n  /* Oestradiol assay date */ 
'30811-0.0'n '30811-1.0'n  /* Phosphate assay date */ 
'30821-0.0'n '30821-1.0'n  /* Rheumatoid factor assay date */ 
'30831-0.0'n '30831-1.0'n  /* SHBG assay date */ 
'30841-0.0'n '30841-1.0'n  /* Total bilirubin assay date */ 
'30851-0.0'n '30851-1.0'n  /* Testosterone assay date */ 
'30861-0.0'n '30861-1.0'n  /* Total protein assay date */ 
'30871-0.0'n '30871-1.0'n  /* Triglycerides assay date */ 
'30881-0.0'n '30881-1.0'n  /* Urate assay date */ 
'30891-0.0'n '30891-1.0'n  /* Vitamin D assay date */; 
RUN; 

* ukb45783 - Date 변수만 추출하기; 
DATA zio.ukb45783_date; 
SET biobank.ukb45783; 
KEEP eid  /* id */
'53-0.0'n '53-1.0'n '53-2.0'n '53-3.0'n /* Date of attending assessment centre */ 
'20078-0.0'n '20078-1.0'n '20078-2.0'n '20078-3.0'n '20078-4.0'n /* When diet questionnaire completion requested */
'20400-0.0'n /* Date of completing mental health questionnaire */ 
'22500-0.0'n /* When occupational data entered */ 
'22700-0.0'n '22700-0.1'n '22700-0.2'n '22700-0.3'n '22700-0.4'n '22700-0.5'n '22700-0.6'n '22700-0.7'n  '22700-0.8'n  
'22700-0.9'n '22700-0.10'n '22700-0.11'n '22700-0.12'n '22700-0.13'n '22700-0.14'n /* Date first recorded at location */ 
'30502-0.0'n '30502-1.0'n /* Microalbumin in urine acquisition time */ 
'30512-0.0'n '30512-1.0'n /* Creatinine (enzymatic) in urine acquisition time */ 
'30522-0.0'n '30522-1.0'n /* Potassium in urine acquisition time */ 
'30532-0.0'n '30532-1.0'n /* Sodium in urine acquisition time */ 
'40000-0.0'n '40000-1.0'n /* Date of death */ 
'40005-0.0'n '40005-1.0'n '40005-2.0'n '40005-3.0'n '40005-4.0'n '40005-5.0'n '40005-6.0'n 
'40005-7.0'n '40005-8.0'n '40005-9.0'n '40005-10.0'n '40005-11.0'n '40005-12.0'n '40005-13.0'n '40005-14.0'n '40005-15.0'n '40005-16.0'n  /* Date of cancer diagnosis*/ 
'42000-0.0'n /* Date of myocardial infarction */ 
'42002-0.0'n /* Date of STEMI */ 
'42004-0.0'n /* Date of NSTEMI */ 
'42006-0.0'n /* Date of stroke */ 
'42008-0.0'n /* Date of ischaemic stroke */ 
'42010-0.0'n /* Date of intracerebral haemorrhage */ 
'42012-0.0'n /* Date of subarachnoid haemorrhage */; 
RUN; 

* ukb46987 - Date 변수만 추출하기; 
DATA zio.ukb46987_date; 
SET biobank.ukb46987; 
KEEP eid  /* id */
'41262-0.0'n--'41262-0.74'n /* Date of first in-patient diagnosis - main ICD10 */ 
'41263-0.0'n--'41263-0.27'n /* Date of first in-patient diagnosis - main ICD9 */ 
'41280-0.0'n--'41280-0.222'n /* Date of first in-patient diagnosis - ICD10 */ 
'41281-0.0'n--'41281-0.46'n /* Date of first in-patient diagnosis - ICD9 */; 
RUN; 

/* change ukb37332_date eid from character to numeric */ 
DATA zio.ukb37332_date;
SET zio.ukb37332_date; 
	eid_num = input(eid, 16.);
RUN;

/* merge date tables */ 
PROC SQL; 
CREATE TABLE work.ukb_date_merged_tmp AS 
SELECT a.*, b.* 
FROM zio.ukb37332_date AS a INNER JOIN zio.ukb45783_date AS b
ON a.eid_num = b.eid; 
QUIT; 

/* final date table */ 
PROC SQL; 
CREATE TABLE zio.ukb_date_merged AS 
SELECT a.*, b.* 
FROM work.ukb_date_merged_tmp AS a INNER JOIN zio.ukb46987_date AS b
ON a.eid = b.eid; 
QUIT; 

/* change final date table eid from character to numeric */ 
DATA zio.ukb_date_merged;
SET zio.ukb_date_merged; 
	eid_num = input(eid, 16.);
	DROP eid; 
RUN;

/* find maximum date of all - 여기서부터 다시 */ * 자료형 다르고 열 너무 많아서 잘 안됨, python 으로 옮겨서 하자; 
* 파이썬에서도 노답임 자료형만 python에서 datetime으로 바꿔서 다시 불러오자; 

data zio.ukb_date_merged_DATETIME2;
   set zio.ukb_date_merged_DATETIME;
   array change _character_;
        do over change;
            if change=' ' then change='1900-01-01';
        end;
 run ;

PROC STDIZE DATA= zio.ukb_date_merged_DATETIME OUT=zio.ukb_date_merged_DATETIME2 REPONLY MISSING=0;
RUN;

DATA zio.ukb_date_merged_DATETIME2; 
SET zio.ukb_date_merged_DATETIME2; 
last_followup_date = max(of _character_); 
RUN; 


/******** 기본 검진변수들 전처리 ********/
/**** ukb_merged_1st.sas7bdat 에서 *****/ 

* 6153 - 약물 복용력 (female) 변수들 질환별로 분리; 
DATA zio.ukb_merged_1st_preprocessed; 
SET zio.ukb_merged_1st; 
IF '31-0.0'n = 0 AND ('6153-0.0'n = 1 OR '6153-0.1'n = 1 OR '6153-0.2'n = 1 OR '6153-0.3'n = 1) THEN Cholesterol_lowering_medication = 1;   /* Cholesterol_lowering_medication coded 1 */ 
IF '31-0.0'n = 0 AND ('6153-0.0'n = 2 OR '6153-0.1'n = 2 OR '6153-0.2'n = 2 OR '6153-0.3'n = 2) THEN Blood_pressure_medication = 1;  /* Blood pressure medication coded 2 */ 
IF '31-0.0'n = 0 AND ('6153-0.0'n = 3 OR '6153-0.1'n = 3 OR '6153-0.2'n = 3 OR '6153-0.3'n = 3) THEN Insulin = 1;  /* Insulin coded 3 */ 

IF '31-0.0'n = 0 AND ('6153-0.0'n = -7 OR '6153-0.1'n = -7 OR '6153-0.2'n = -7 OR '6153-0.3'n = -7) THEN Cholesterol_lowering_medication = 0;   /* if coded -7, none of above has been taken */ 
IF '31-0.0'n = 0 AND ('6153-0.0'n = -7 OR '6153-0.1'n = -7 OR '6153-0.2'n = -7 OR '6153-0.3'n = -7) THEN Blood_pressure_medication = 0;   /* if coded -7, none of above has been taken */ 
IF '31-0.0'n = 0 AND ('6153-0.0'n = -7 OR '6153-0.1'n = -7 OR '6153-0.2'n = -7 OR '6153-0.3'n = -7) THEN Insulin = 0;   /* if coded -7, none of above has been taken */ 

RUN; 

* 6177 - 약물 복용력 (male) 변수들 질환별로 분리; 
DATA zio.ukb_merged_1st_preprocessed; 
SET zio.ukb_merged_1st_preprocessed; 
IF '31-0.0'n = 1 AND ('6177-0.0'n = 1 OR '6177-0.1'n = 1 OR '6177-0.2'n = 1) THEN Cholesterol_lowering_medication = 1;   /* Cholesterol_lowering_medication coded 1 */ 
IF '31-0.0'n = 1 AND ('6177-0.0'n = 2 OR '6177-0.1'n = 2 OR '6177-0.2'n = 2) THEN Blood_pressure_medication = 1;  /* Blood pressure medication coded 2 */ 
IF '31-0.0'n = 1 AND ('6177-0.0'n = 3 OR '6177-0.1'n = 3 OR '6177-0.2'n = 3) THEN Insulin = 1;  /* Insulin coded 3 */ 

IF '31-0.0'n = 1 AND ('6177-0.0'n = -7 OR '6177-0.1'n = -7 OR '6177-0.2'n = -7) THEN Cholesterol_lowering_medication = 0;   /* if coded -7, none of above has been taken */ 
IF '31-0.0'n = 1 AND ('6177-0.0'n = -7 OR '6177-0.1'n = -7 OR '6177-0.2'n = -7) THEN Blood_pressure_medication = 0;   /* if coded -7, none of above has been taken */ 
IF '31-0.0'n = 1 AND ('6177-0.0'n = -7 OR '6177-0.1'n = -7 OR '6177-0.2'n = -7) THEN Insulin = 0;   /* if coded -7, none of above has been taken */ 

RUN;

* 음주 변수 drop (15만개밖에 없음); 
DATA zio.ukb_merged_1st_preprocessed; 
SET zio.ukb_merged_1st_preprocessed; 
DROP '20414-0.0'n; 
RUN; 

/* Calculate MET */ 
/* '874-0.0'n  Duration of walks */ 
/* '894-0.0'n  Duration of moderate activity */ 
/* '914-0.0'n  Duration of vigorous activity */ 
DATA zio.ukb_merged_1st_preprocessed; 
SET zio.ukb_merged_1st_preprocessed; 

IF '874-0.0'n ^= -1 AND '874-0.0'n ^= -3 THEN walk = '874-0.0'n;  
IF '894-0.0'n ^= -1 AND '894-0.0'n ^= -3 THEN moderate = '894-0.0'n; 
IF '914-0.0'n ^= -1 AND '914-0.0'n ^= -3 THEN vigorous = '914-0.0'n; 

MET= vigorous*8 + moderate*4 + walk*3.3;

IF MET<600 THEN PA_NEW=1;
ELSE IF MET<=3000 THEN PA_NEW=2;
ELSE IF MET>3000 THEN PA_NEW=3;

DROP walk moderate vigorous; 

RUN; 


/* Family history */ 
/*'20107-0.0'n '20107-0.1'n '20107-0.2'n '20107-0.3'n '20107-0.4'n '20107-0.5'n '20107-0.6'n '20107-0.7'n '20107-0.8'n '20107-0.9'n 
'20107-1.0'n '20107-1.1'n '20107-1.2'n '20107-1.3'n '20107-1.4'n '20107-1.5'n '20107-1.6'n '20107-1.7'n '20107-1.8'n '20107-1.9'n 
'20107-2.0'n '20107-2.1'n '20107-2.2'n '20107-2.3'n '20107-2.4'n '20107-2.5'n '20107-2.6'n '20107-2.7'n '20107-2.8'n '20107-2.9'n 
'20107-3.0'n '20107-3.1'n '20107-3.2'n '20107-3.3'n '20107-3.4'n '20107-3.5'n '20107-3.6'n '20107-3.7'n '20107-3.8'n '20107-3.9'n  Illnesses of father */ 
/*'20110-0.0'n '20110-0.1'n '20110-0.2'n '20110-0.3'n '20110-0.4'n '20110-0.5'n '20110-0.6'n '20110-0.7'n '20110-0.8'n '20110-0.9'n '20110-0.10'n
'20110-1.0'n '20110-1.1'n '20110-1.2'n '20110-1.3'n '20110-1.4'n '20110-1.5'n '20110-1.6'n '20110-1.7'n '20110-1.8'n '20110-1.9'n '20110-1.10'n
'20110-2.0'n '20110-2.1'n '20110-2.2'n '20110-2.3'n '20110-2.4'n '20110-2.5'n '20110-2.6'n '20110-2.7'n '20110-2.8'n '20110-2.9'n '20110-2.10'n
'20110-3.0'n '20110-3.1'n '20110-3.2'n '20110-3.3'n '20110-3.4'n '20110-3.5'n '20110-3.6'n '20110-3.7'n '20110-3.8'n '20110-3.9'n '20110-3.10'n  Illnesses of mother */;  

DATA zio.ukb_merged_1st_preprocessed; 
SET zio.ukb_merged_1st_preprocessed; 
* Father; 
IF '20107-0.0'n = 1 OR '20107-0.1'n = 1 OR '20107-0.2'n = 1 OR '20107-0.3'n = 1 OR '20107-0.4'n = 1 OR 
'20107-0.5'n = 1 OR '20107-0.6'n = 1 OR '20107-0.7'n = 1 OR '20107-0.8'n = 1 OR '20107-0.9'n = 1 THEN FM_HISTORY_Heart_disease = 1;   /* FM_HISTORY_Heart_disease coded 1 */ 
IF '20107-0.0'n = 2 OR '20107-0.1'n = 2 OR '20107-0.2'n = 2 OR '20107-0.3'n = 2 OR '20107-0.4'n = 2 OR 
'20107-0.5'n = 2 OR '20107-0.6'n = 2 OR '20107-0.7'n = 2 OR '20107-0.8'n = 2 OR '20107-0.9'n = 2 THEN FM_HISTORY_Stroke = 1;   /* FM_HISTORY_Stroke coded 2 */ 
IF '20107-0.0'n = 8 OR '20107-0.1'n = 8 OR '20107-0.2'n = 8 OR '20107-0.3'n = 8 OR '20107-0.4'n = 8 OR 
'20107-0.5'n = 8 OR '20107-0.6'n = 8 OR '20107-0.7'n = 8 OR '20107-0.8'n = 8 OR '20107-0.9'n = 8 THEN FM_HISTORY_High_blood_pressure = 1;   /* FM_HISTORY_High_blood_pressure coded 8 */ 
IF '20107-0.0'n = 9 OR '20107-0.1'n = 9 OR '20107-0.2'n = 9 OR '20107-0.3'n = 9 OR '20107-0.4'n = 9 OR 
'20107-0.5'n = 9 OR '20107-0.6'n = 9 OR '20107-0.7'n = 9 OR '20107-0.8'n = 9 OR '20107-0.9'n = 9 THEN FM_HISTORY_Diabetes = 1;   /* FM_HISTORY_Diabetes coded 9 */ 

IF '20107-0.0'n = -17 OR '20107-0.1'n = -17 OR '20107-0.2'n = -17 OR '20107-0.3'n = -17 OR '20107-0.4'n = -17 OR 
'20107-0.5'n = -17 OR '20107-0.6'n = -17 OR '20107-0.7'n = -17 OR '20107-0.8'n = -17 OR '20107-0.9'n = -17 THEN FM_HISTORY_Heart_disease = 0;  /* if coded -17, none of above */ 
IF '20107-0.0'n = -17 OR '20107-0.1'n = -17 OR '20107-0.2'n = -17 OR '20107-0.3'n = -17 OR '20107-0.4'n = -17 OR 
'20107-0.5'n = -17 OR '20107-0.6'n = -17 OR '20107-0.7'n = -17 OR '20107-0.8'n = -17 OR '20107-0.9'n = -17 THEN FM_HISTORY_Stroke = 0;  /* if coded -17, none of above */ 
IF '20107-0.0'n = -17 OR '20107-0.1'n = -17 OR '20107-0.2'n = -17 OR '20107-0.3'n = -17 OR '20107-0.4'n = -17 OR 
'20107-0.5'n = -17 OR '20107-0.6'n = -17 OR '20107-0.7'n = -17 OR '20107-0.8'n = -17 OR '20107-0.9'n = -17 THEN FM_HISTORY_High_blood_pressure = 0;  /* if coded -17, none of above */ 
IF '20107-0.0'n = -17 OR '20107-0.1'n = -17 OR '20107-0.2'n = -17 OR '20107-0.3'n = -17 OR '20107-0.4'n = -17 OR 
'20107-0.5'n = -17 OR '20107-0.6'n = -17 OR '20107-0.7'n = -17 OR '20107-0.8'n = -17 OR '20107-0.9'n = -17 THEN FM_HISTORY_Diabetes = 0;  /* if coded -17, none of above */ 

IF '20107-0.0'n = -27 OR '20107-0.1'n = -27 OR '20107-0.2'n = -27 OR '20107-0.3'n = -27 OR '20107-0.4'n = -27 OR 
'20107-0.5'n = -27 OR '20107-0.6'n = -27 OR '20107-0.7'n = -27 OR '20107-0.8'n = -27 OR '20107-0.9'n = -27 THEN FM_HISTORY_Heart_disease = 0;  /* if coded -27, none of above */ 
IF '20107-0.0'n = -27 OR '20107-0.1'n = -27 OR '20107-0.2'n = -27 OR '20107-0.3'n = -27 OR '20107-0.4'n = -27 OR 
'20107-0.5'n = -27 OR '20107-0.6'n = -27 OR '20107-0.7'n = -27 OR '20107-0.8'n = -27 OR '20107-0.9'n = -27 THEN FM_HISTORY_Stroke = 0;  /* if coded -27, none of above */ 
IF '20107-0.0'n = -27 OR '20107-0.1'n = -27 OR '20107-0.2'n = -27 OR '20107-0.3'n = -27 OR '20107-0.4'n = -27 OR 
'20107-0.5'n = -27 OR '20107-0.6'n = -27 OR '20107-0.7'n = -27 OR '20107-0.8'n = -27 OR '20107-0.9'n = -27 THEN FM_HISTORY_High_blood_pressure = 0;  /* if coded -27, none of above */ 
IF '20107-0.0'n = -27 OR '20107-0.1'n = -27 OR '20107-0.2'n = -27 OR '20107-0.3'n = -27 OR '20107-0.4'n = -27 OR 
'20107-0.5'n = -27 OR '20107-0.6'n = -27 OR '20107-0.7'n = -27 OR '20107-0.8'n = -27 OR '20107-0.9'n = -27 THEN FM_HISTORY_Diabetes = 0;  /* if coded -27, none of above */ 

* Mother; 
IF '20110-0.0'n = 1 OR '20110-0.1'n = 1 OR '20110-0.2'n = 1 OR '20110-0.3'n = 1 OR '20110-0.4'n = 1 OR 
'20110-0.5'n = 1 OR '20110-0.6'n = 1 OR '20110-0.7'n = 1 OR '20110-0.8'n = 1 OR '20110-0.9'n = 1 OR '20110-0.10'n = 1 THEN FM_HISTORY_Heart_disease = 1;   /* FM_HISTORY_Heart_disease coded 1 */ 
IF '20110-0.0'n = 2 OR '20110-0.1'n = 2 OR '20110-0.2'n = 2 OR '20110-0.3'n = 2 OR '20110-0.4'n = 2 OR 
'20110-0.5'n = 2 OR '20110-0.6'n = 2 OR '20110-0.7'n = 2 OR '20110-0.8'n = 2 OR '20110-0.9'n = 2 OR '20110-0.10'n = 2 THEN FM_HISTORY_Stroke = 1;   /* FM_HISTORY_Stroke coded 2 */ 
IF '20110-0.0'n = 8 OR '20110-0.1'n = 8 OR '20110-0.2'n = 8 OR '20110-0.3'n = 8 OR '20110-0.4'n = 8 OR 
'20110-0.5'n = 8 OR '20110-0.6'n = 8 OR '20110-0.7'n = 8 OR '20110-0.8'n = 8 OR '20110-0.9'n = 8 OR '20110-0.10'n = 8 THEN FM_HISTORY_High_blood_pressure = 1;   /* FM_HISTORY_High_blood_pressure coded 8 */ 
IF '20110-0.0'n = 9 OR '20110-0.1'n = 9 OR '20110-0.2'n = 9 OR '20110-0.3'n = 9 OR '20110-0.4'n = 9 OR 
'20110-0.5'n = 9 OR '20110-0.6'n = 9 OR '20110-0.7'n = 9 OR '20110-0.8'n = 9 OR '20110-0.9'n = 9 OR '20110-0.10'n = 9 THEN FM_HISTORY_Diabetes = 1;   /* FM_HISTORY_Diabetes coded 9 */

IF '20110-0.0'n = -17 OR '20110-0.1'n = -17 OR '20110-0.2'n = -17 OR '20110-0.3'n = -17 OR '20110-0.4'n = -17 OR 
'20110-0.5'n = -17 OR '20110-0.6'n = -17 OR '20110-0.7'n = -17 OR '20110-0.8'n = -17 OR '20110-0.9'n = -17 OR '20110-0.10'n = -17 THEN FM_HISTORY_Heart_disease = 0;   /* if coded -17, none of above */ 
IF '20110-0.0'n = -17 OR '20110-0.1'n = -17 OR '20110-0.2'n = -17 OR '20110-0.3'n = -17 OR '20110-0.4'n = -17 OR 
'20110-0.5'n = -17 OR '20110-0.6'n = -17 OR '20110-0.7'n = -17 OR '20110-0.8'n = -17 OR '20110-0.9'n = -17 OR '20110-0.10'n = -17 THEN FM_HISTORY_Stroke = 0;   /* if coded -17, none of above */ 
IF '20110-0.0'n = -17 OR '20110-0.1'n = -17 OR '20110-0.2'n = -17 OR '20110-0.3'n = -17 OR '20110-0.4'n = -17 OR 
'20110-0.5'n = -17 OR '20110-0.6'n = -17 OR '20110-0.7'n = -17 OR '20110-0.8'n = -17 OR '20110-0.9'n = -17 OR '20110-0.10'n = -17 THEN FM_HISTORY_High_blood_pressure = 0;   /* if coded -17, none of above */ 
IF '20110-0.0'n = -17 OR '20110-0.1'n = -17 OR '20110-0.2'n = -17 OR '20110-0.3'n = -17 OR '20110-0.4'n = -17 OR 
'20110-0.5'n = -17 OR '20110-0.6'n = -17 OR '20110-0.7'n = -17 OR '20110-0.8'n = -17 OR '20110-0.9'n = -17 OR '20110-0.10'n = -17 THEN FM_HISTORY_Diabetes = 0;   /* if coded -17, none of above */ 

IF '20110-0.0'n = -27 OR '20110-0.1'n = -27 OR '20110-0.2'n = -27 OR '20110-0.3'n = -27 OR '20110-0.4'n = -27 OR 
'20110-0.5'n = -27 OR '20110-0.6'n = -27 OR '20110-0.7'n = -27 OR '20110-0.8'n = -27 OR '20110-0.9'n = -27 OR '20110-0.10'n = -27 THEN FM_HISTORY_Heart_disease = 0;   /* if coded -27, none of above */ 
IF '20110-0.0'n = -27 OR '20110-0.1'n = -27 OR '20110-0.2'n = -27 OR '20110-0.3'n = -27 OR '20110-0.4'n = -27 OR 
'20110-0.5'n = -27 OR '20110-0.6'n = -27 OR '20110-0.7'n = -27 OR '20110-0.8'n = -27 OR '20110-0.9'n = -27 OR '20110-0.10'n = -27 THEN FM_HISTORY_Stroke = 0;   /* if coded -27, none of above */ 
IF '20110-0.0'n = -27 OR '20110-0.1'n = -27 OR '20110-0.2'n = -27 OR '20110-0.3'n = -27 OR '20110-0.4'n = -27 OR 
'20110-0.5'n = -27 OR '20110-0.6'n = -27 OR '20110-0.7'n = -27 OR '20110-0.8'n = -27 OR '20110-0.9'n = -27 OR '20110-0.10'n = -27 THEN FM_HISTORY_High_blood_pressure = 0;   /* if coded -27, none of above */ 
IF '20110-0.0'n = -27 OR '20110-0.1'n = -27 OR '20110-0.2'n = -27 OR '20110-0.3'n = -27 OR '20110-0.4'n = -27 OR 
'20110-0.5'n = -27 OR '20110-0.6'n = -27 OR '20110-0.7'n = -27 OR '20110-0.8'n = -27 OR '20110-0.9'n = -27 OR '20110-0.10'n = -27 THEN FM_HISTORY_Diabetes = 0;   /* if coded -27, none of above */ 

RUN; 


/* 알아볼 수 있게 열 이름 바꾸기 */ 
DATA zio.ukb_merged_1st_preprocessed; 
SET zio.ukb_merged_1st_preprocessed; 
RENAME '21003-0.0'n /* Age when attended assessment centre */ 
'53-0.0'n  /* Date of attending assessment centre */ 
'31-0.0'n /* sex */ 
'50-0.0'n /* standing height */ 
'21002-0.0'n /* weight */ 
'21001-0.0'n  /* BMI */ 
'4080-0.0'n '4080-0.1'n /* 	Systolic blood pressure, automated reading */ 
'4079-0.0'n '4079-0.1'n /* 	Diastolic blood pressure, automated reading */ 
'48-0.0'n  /* Waist circumference */ 
'4056-0.0'n '4056-1.0'n '4056-2.0'n '4056-3.0'n /* Age stroke diagnosed */ 
'3894-0.0'n '3894-1.0'n '3894-2.0'n '3894-3.0'n /* Age heart attack diagnosed */ 
'3627-0.0'n '3627-1.0'n '3627-2.0'n '3627-3.0'n /* Age angina diagnosed */ 
'2966-0.0'n '2966-1.0'n '2966-2.0'n '2966-3.0'n /* Age high blood pressure diagnosed */ 
'2976-0.0'n '2976-1.0'n '2976-2.0'n '2976-3.0'n /* Age diabetes diagnosed */ 
'6153-0.0'n '6153-0.1'n '6153-0.2'n '6153-0.3'n  /* Medication for cholesterol, blood pressure, diabetes, or take exogenous hormones */ 
'6177-0.0'n '6177-0.1'n '6177-0.2'n  /* Medication for cholesterol, blood pressure or diabetes */ 
'20414-0.0'n /* Frequency of drinking alcohol - 새로운 변수 받아와서 바꿔야 함! */ 
'874-0.0'n /* Duration of walks */ 
'894-0.0'n /* Duration of moderate activity */ 
'914-0.0'n /* Duration of vigorous activity */ 
'20107-0.0'n '20107-0.1'n '20107-0.2'n '20107-0.3'n '20107-0.4'n '20107-0.5'n '20107-0.6'n '20107-0.7'n '20107-0.8'n '20107-0.9'n  /* Illnesses of father */ 
'20110-0.0'n '20110-0.1'n '20110-0.2'n '20110-0.3'n '20110-0.4'n '20110-0.5'n '20110-0.6'n '20110-0.7'n '20110-0.8'n '20110-0.9'n '20110-0.10'n /* Illnesses of mother */
'30730-0.0'n /* Gamma glutamyltransferase */ 
'30650-0.0'n /* Aspartate aminotransferase AST */ 
'30620-0.0'n /* Alanine aminotransferase ALT */ 
'30690-0.0'n /* Cholesterol */ 
'30760-0.0'n /* HDL cholesterol */ 
'30780-0.0'n /* LDL direct */ 
'30870-0.0'n /* Triglycerides */ 
'30700-0.0'n /* Creatinine */; 




















 



