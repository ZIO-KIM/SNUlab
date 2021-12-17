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
3. Date 변수들 모아서 last follow up 열 만들기 - python 에서 진행중 - 전부 character로만 바꿔서 다시 sas로 가져오자 - python 에서 완료 - UKB_DATE_LASTFOLLOWUPDATE.sas7bdat
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
			FORMAT _character_;   /* 이게 해결책이었음 (변수 길이) */ 
            if change = ' ' then change = '1900-01-01';
        end;
 run ;  * null 값 다 채워지긴 한다, 이 파일을 파이썬으로 내보내서 nanmax 하자; * - 성공; 

/*PROC STDIZE DATA= zio.ukb_date_merged_DATETIME OUT=zio.ukb_date_merged_DATETIME2 REPONLY MISSING=0;*/
/*RUN; * 안됨; */

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

DROP '6153-0.0'n--'6153-0.3'n; 

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

DROP '6177-0.0'n--'6177-0.2'n; 

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

DROP walk moderate vigorous '874-0.0'n '894-0.0'n '914-0.0'n; 

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

DROP '20107-0.0'n '20107-0.1'n '20107-0.2'n '20107-0.3'n '20107-0.4'n '20107-0.5'n '20107-0.6'n '20107-0.7'n '20107-0.8'n '20107-0.9'n 
'20107-1.0'n '20107-1.1'n '20107-1.2'n '20107-1.3'n '20107-1.4'n '20107-1.5'n '20107-1.6'n '20107-1.7'n '20107-1.8'n '20107-1.9'n 
'20107-2.0'n '20107-2.1'n '20107-2.2'n '20107-2.3'n '20107-2.4'n '20107-2.5'n '20107-2.6'n '20107-2.7'n '20107-2.8'n '20107-2.9'n 
'20107-3.0'n '20107-3.1'n '20107-3.2'n '20107-3.3'n '20107-3.4'n '20107-3.5'n '20107-3.6'n '20107-3.7'n '20107-3.8'n '20107-3.9'n ; * Illnesses of father; 

DROP '20110-0.0'n '20110-0.1'n '20110-0.2'n '20110-0.3'n '20110-0.4'n '20110-0.5'n '20110-0.6'n '20110-0.7'n '20110-0.8'n '20110-0.9'n '20110-0.10'n
'20110-1.0'n '20110-1.1'n '20110-1.2'n '20110-1.3'n '20110-1.4'n '20110-1.5'n '20110-1.6'n '20110-1.7'n '20110-1.8'n '20110-1.9'n '20110-1.10'n
'20110-2.0'n '20110-2.1'n '20110-2.2'n '20110-2.3'n '20110-2.4'n '20110-2.5'n '20110-2.6'n '20110-2.7'n '20110-2.8'n '20110-2.9'n '20110-2.10'n
'20110-3.0'n '20110-3.1'n '20110-3.2'n '20110-3.3'n '20110-3.4'n '20110-3.5'n '20110-3.6'n '20110-3.7'n '20110-3.8'n '20110-3.9'n '20110-3.10'n; * Illnesses of mother; 

RUN; 

* 2021.12.10 FRI ~ 추가 기본 검진변수 전처리; 
* SBP, DBP; 
DATA zio.ukb_merged_1st_preprocessed; 
SET zio.ukb_merged_1st_preprocessed; 
* SBP; 
IF '4080-0.0'n = . AND '4080-0.1'n = . THEN SBP = . ; 
IF '4080-0.0'n ^= . AND '4080-0.1'n =. THEN SBP = '4080-0.0'n; 
IF '4080-0.0'n = . AND '4080-0.1'n ^=. THEN SBP = '4080-0.1'n; 
IF '4080-0.0'n ^= . AND '4080-0.1'n ^=. THEN SBP = MEAN('4080-0.0'n, '4080-0.1'n) ; 

* DBP; 
IF '4079-0.0'n = . AND '4079-0.1'n = . THEN DBP = . ; 
IF '4079-0.0'n ^= . AND '4079-0.1'n =. THEN DBP = '4079-0.0'n; 
IF '4079-0.0'n = . AND '4079-0.1'n ^=. THEN DBP = '4079-0.1'n; 
IF '4079-0.0'n ^= . AND '4079-0.1'n ^=. THEN DBP = MEAN('4079-0.0'n, '4079-0.1'n) ; 

DROP '4080-0.0'n '4080-0.1'n '4079-0.0'n '4079-0.1'n; 
RUN; 

* 과거 진단력 관련 변수들 하나로 합치기 (질환력, 약물복용력) ; 
DATA zio.ukb_merged_1st_preprocessed; 
SET zio.ukb_merged_1st_preprocessed; 
* Stroke; 
IF '4056-0.0'n ^= . THEN Stroke_diagnosed = 1; 
IF '4056-0.0'n = . THEN Stroke_diagnosed = 0; 
* Heart_disease; 
IF '3894-0.0'n ^= . OR '3627-0.0'n ^= . THEN Heart_disease_diagnosed = 1; *Heart attack, angina; 
IF '3894-0.0'n = . AND '3627-0.0'n = . THEN Heart_disease_diagnosed = 0; 
*High_Blood_Pressure; 
IF '2966-0.0'n ^= . OR Blood_pressure_medication = 1 THEN High_Blood_Pressure_diagnosed = 1; 
IF '2966-0.0'n = . OR Blood_pressure_medication = 0 THEN High_Blood_Pressure_diagnosed = 0; 
*Diabetes; 
IF '2976-0.0'n ^= . OR Insulin = 1 THEN Diabetes_diagnosed = 1; 
IF '2976-0.0'n = . OR Insulin = 0 THEN Diabetes_diagnosed = 0; 
*High_Cholesterol; 
IF Cholesterol_lowering_medication = 1 THEN High_Cholesterol_diagnosed = 1; 
IF Cholesterol_lowering_medication = 0 THEN High_Cholesterol_diagnosed = 0; 

* 약물변수 참고용 (실제 코드 위에 있음); 
/*IF '31-0.0'n = 0 AND ('6153-0.0'n = -7 OR '6153-0.1'n = -7 OR '6153-0.2'n = -7 OR '6153-0.3'n = -7) THEN Cholesterol_lowering_medication = 0;   /* if coded -7, none of above has been taken */ */
/*IF '31-0.0'n = 0 AND ('6153-0.0'n = -7 OR '6153-0.1'n = -7 OR '6153-0.2'n = -7 OR '6153-0.3'n = -7) THEN Blood_pressure_medication = 0;   /* if coded -7, none of above has been taken */ */
/*IF '31-0.0'n = 0 AND ('6153-0.0'n = -7 OR '6153-0.1'n = -7 OR '6153-0.2'n = -7 OR '6153-0.3'n = -7) THEN Insulin = 0;   /* if coded -7, none of above has been taken */

DROP '4056-0.0'n--'4056-3.0'n; 
DROP '3894-0.0'n--'3894-3.0'n; 
DROP '3627-0.0'n--'3627-3.0'n; 
DROP '2966-0.0'n--'2966-3.0'n; 
DROP '2976-0.0'n--'2976-3.0'n; 

RUN; 


* BMI, MET, Total cholesterol drop; 
DATA zio.ukb_merged_1st_preprocessed; 
SET zio.ukb_merged_1st_preprocessed; 
DROP '21001-0.0'n MET '30690-0.0'n; 
RUN; 

/* 검진변수 전처리 END */ 
/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 


/* 2021-12-10 FRI ~ 

- 최종 DF들 합쳐서 final df 만들기 (1~4) - ukb_1st_final.sas7bdat
	1. CKD 진단여부, CKD 진단날짜 - ukb46987_n18preprocessed.sas7bdat (icd9 처리까지 완료) 
	2. 약물변수들 전처리 완료 - ukb45783_drugpreprocessed.sas7bdat
		2-1. 2021-12-13 약물변수 기준 확대 - 약학정보원기준
		ukb45783_drugpreprocessed_약학정보원기준.csv == ukb45783_drugpreprocessed_2.sas7bdat
	3. Date 변수들 모아서 만든 last follow up date - UKB_DATE_LASTFOLLOWUPDATE.sas7bdat
	4. 기본 검진변수들 전처리 완료 - ukb_merged_1st_preprocessed.sas7bdat

- TIME 변수 생성
	IF N18 = 1 THEN TIME = N18_Date - ATTEND_DATE
	IF N18 = 0 THEN TIME = LastFollowUpDate - ATTEND_DATE

- CHECK Missing

*/ 

/* 알아볼 수 있게 열 이름 바꾸기 */ 
DATA zio.ukb_merged_1st_preprocessed; 
SET zio.ukb_merged_1st_preprocessed; 
RENAME '21003-0.0'n = AGE /* Age when attended assessment centre */
'53-0.0'n  = ATTEND_DATE /* Date of attending assessment centre */ 
'31-0.0'n = SEX /* sex */ 
'50-0.0'n = HGHT /* standing height */ 
'21002-0.0'n = WGHT /* weight */ 
/*'21001-0.0'n  = BMI /* BMI - DROP */ 
/*'4080-0.0'n '4080-0.1'n /* Systolic blood pressure, automated reading - SBP 열 새로 생성 */ 
/*'4079-0.0'n '4079-0.1'n /* 	Diastolic blood pressure, automated reading - DBP 열 새로 생성 */ 
'48-0.0'n  = WSTC /* Waist circumference */ 
/*'4056-0.0'n '4056-1.0'n '4056-2.0'n '4056-3.0'n /* Age stroke diagnosed */ 
/*'3894-0.0'n '3894-1.0'n '3894-2.0'n '3894-3.0'n /* Age heart attack diagnosed */ 
/*'3627-0.0'n '3627-1.0'n '3627-2.0'n '3627-3.0'n /* Age angina diagnosed */
/*'2966-0.0'n '2966-1.0'n '2966-2.0'n '2966-3.0'n /* Age high blood pressure diagnosed */ 
/*'2976-0.0'n '2976-1.0'n '2976-2.0'n '2976-3.0'n /* Age diabetes diagnosed */
/*'6153-0.0'n '6153-0.1'n '6153-0.2'n '6153-0.3'n  /* Medication for cholesterol, blood pressure, diabetes, or take exogenous hormones */ 
/*'6177-0.0'n '6177-0.1'n '6177-0.2'n  /* Medication for cholesterol, blood pressure or diabetes  - 약물력, 질환력 다 합쳤음 */ 
/*'20414-0.0'n /* Frequency of drinking alcohol - 새로운 변수 받아와서 바꿔야 함! - DROP */ 
/*'874-0.0'n /* Duration of walks */ 
/*'894-0.0'n /* Duration of moderate activity */ 
/*'914-0.0'n /* Duration of vigorous activity - 3개 합쳐서 PA_NEW로 대체 */ 
/*'20107-0.0'n '20107-0.1'n '20107-0.2'n '20107-0.3'n '20107-0.4'n '20107-0.5'n '20107-0.6'n '20107-0.7'n '20107-0.8'n '20107-0.9'n  /* Illnesses of father - 전처리 완료 */ 
/*'20110-0.0'n '20110-0.1'n '20110-0.2'n '20110-0.3'n '20110-0.4'n '20110-0.5'n '20110-0.6'n '20110-0.7'n '20110-0.8'n '20110-0.9'n '20110-0.10'n /* Illnesses of mother - 전처리 완료 */
'30730-0.0'n = GGT /* Gamma glutamyltransferase */ 
'30650-0.0'n = AST /* Aspartate aminotransferase AST */ 
'30620-0.0'n = ALT /* Alanine aminotransferase ALT */ 
/*'30690-0.0'n /* Cholesterol - high VIF, DROP */ 
'30760-0.0'n = HDL /* HDL cholesterol */ 
'30780-0.0'n = LDL /* LDL direct */ 
'30870-0.0'n = TG /* Triglycerides */ 
'30700-0.0'n = CREA /* Creatinine */; 
RUN; 

/* UKB45783_DRUGPREPROCESSED에서 eid, HTN_med만 남기기 */ 
/* 약학정보원 기준으로 만든 UKB45783_DRUGPREPROCESSED_2로 작업할 경우 실행 안해도 됨 */ 
DATA zio.UKB45783_DRUGPREPROCESSED; 
SET zio.UKB45783_DRUGPREPROCESSED; 
KEEP eid HTN_med; 
RUN; 

/* 1 + 2 eid로 join */ 
* 약물df 이름 약학정보원 기준, 공단 기준 달라질 때 바꾸는 거 잊지말기; 
PROC SQL; 
CREATE TABLE zio.UKB_1st_final AS 
SELECT *
FROM zio.ukb46987_n18preprocessed AS a INNER JOIN zio.ukb45783_drugpreprocessed_2 AS b 
ON a.eid = b.eid; 
QUIT; 

/* + 3 eid로 join */ 
PROC SQL; 
CREATE TABLE zio.UKB_1st_final AS 
SELECT *
FROM zio.UKB_1st_final AS a INNER JOIN zio.UKB_DATE_LASTFOLLOWUPDATE AS b 
ON a.eid = b.eid; 
QUIT; 

/* + 4 eid로 join */ 
PROC SQL; 
CREATE TABLE zio.UKB_1st_final AS 
SELECT *
FROM zio.ukb_merged_1st_preprocessed AS a INNER JOIN zio.UKB_1st_final AS b 
ON a.eid = b.eid; 
QUIT; 

/* create TIME */ 

* N18_Date - 0 to null; 
DATA zio.UKB_1st_final; 
SET zio.UKB_1st_final; 
IF N18_Date = 0 THEN N18_Date = ' '; 
RUN; 

* N18_Date - character to datetime; 
DATA zio.UKB_1st_final; 
SET zio.UKB_1st_final; 
N18_Date_new = input(put(N18_Date,10.),yymmdd10.);
format N18_Date_new yymmdd10.; 
RUN; 

* TIME; 
DATA zio.UKB_1st_final; 
SET zio.UKB_1st_final; 
	IF N18 = 1 THEN TIME = intck('day', ATTEND_DATE, N18_Date_new);
	IF N18 = 0 THEN TIME = intck('day', ATTEND_DATE, LastFollowUpDate); 
RUN; 


/* 자잘한 전처리들 */ 
* IF TIME < 0 THEN DROP; 
DATA zio.UKB_1ST_FINAL; 
SET zio.UKB_1ST_FINAL; 
IF TIME <0 THEN delete; 
RUN; 

* change some character variables to numeric; 
DATA zio.UKB_1ST_FINAL; 
SET zio.UKB_1ST_FINAL; 
ALT_num = INPUT(ALT, 8.); 
AST_num = INPUT(AST, 8.); 
CREA_num = INPUT(CREA, 8.); 
GGT_num = INPUT(GGT, 8.); 
HDL_num = INPUT(HDL, 8.); 
LDL_num = INPUT(LDL, 8.); 
TG_num = INPUT(TG, 8.); 

DROP ALT AST CREA GGT HDL LDL TG; 

RUN; 

* DROP unused variables; 
DATA zio.UKB_1ST_FINAL; 
SET zio.UKB_1ST_FINAL; 
DROP Cholesterol_lowering_medication Blood_pressure_medication Insulin N18_Date; 
RUN; 


/* CHECK Missing */ 
proc means data=zio.ukb_1st_final mean median min max n nmiss; 
run; 


/* DROP Missing */ 
DATA zio.UKB_1ST_FINAL; 
SET zio.UKB_1ST_FINAL; 
IF WSTC = . THEN delete; 
IF HGHT = . THEN delete; 
IF WGHT = . THEN delete; 
IF FM_HISTORY_Heart_disease = . THEN delete; 
IF FM_HISTORY_Stroke = . THEN delete; 
IF FM_HISTORY_High_blood_pressure = . THEN delete; 
IF FM_HISTORY_Diabetes = . THEN delete; 
IF SBP = . THEN delete; 
IF DBP = . THEN delete; 
IF High_Cholesterol_diagnosed = . THEN delete; 
IF ALT_num = . THEN delete; 
IF AST_num = . THEN delete; 
IF CREA_num = . THEN delete; 
IF GGT_num = . THEN delete; 
IF HDL_num = . THEN delete; 
IF LDL_num = . THEN delete; 
IF TG_num = . THEN delete; 
RUN; 

* 최종 데이터셋 총원 315,052; 

* Merge 후 전처리, HTN_med = 1인 사람은 High_Blood_Pressure_diagnosed = 1이어야 함; 
data zio.ukb_1st_final;
set zio.ukb_1st_final;
if HTN_med=1 then high_blood_pressure_diagnosed=1;
if SBP >130 or DBP>80 then high_blood_pressure_diagnosed=1;
run;

* ARB, ACEi 합치기; 
DATA zio.ukb_1st_final; 
SET zio.ukb_1st_final; 
IF ARB = 1 OR ACEi = 1 THEN ARB_ACEi = 1; 
RUN; 

* ARB_ACEi - null to 0; 
DATA zio.ukb_1st_final_HBP_med; 
SET zio.ukb_1st_final_HBP_med; 
IF ARB_ACEi = . THEN ARB_ACEi = 0; 
RUN; 

/* Count Outcome */ 
proc freq data=zio.ukb_1st_final_HBP_med; 
tables HTN_med*ARB_ACEi*Other_HTN_med; 
RUN; 

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 
/* UKB_1ST_FINAL.sas7bdat preprocessing DONE. */ 
/* Move to PSM program */ 

proc freq data=zio.ukb_1st_final; 
table N18; 
run; 

data zio.ukb_1st_final_new;
set zio.ukb_1st_final;
if high_blood_pressure_diagnosed=1;

if ARB_ACEI=1 then ARB_ACEI2=ARB_ACEI;

if HTN_MED=0 then ARB_ACEI2=0;

if ARB_ACEI2^=.;

run;

data zio.ukb_1st_final_new2;
set zio.ukb_1st_final;
if high_blood_pressure_diagnosed=1;

if HTN_MED=1 and ARB_ACEI=1 then delete;

run;

* ARB+ACEi, Other_HTN_med 둘 다 먹는 사람들 자르기; 
* 각 ARB+ACEi / Other HTN med 먹는 사람 기준으로 PSM - ARB_ACEI2; 
data zio.ukb_1st_final_dropdup; 
set zio.ukb_1st_final_HBP_med; 
if ARB_ACEI = 1 AND Other_HTN_med = 1 THEN delete; 
if ARB_ACEI=1 then ARB_ACEI2=ARB_ACEI;
if Other_HTN_med = 1 then ARB_ACEI2=0;
run; 

proc freq data=zio.ukb_1st_final_dropdup; 
table ARB_ACEI2; 


/* descriptive */ 

* all HTN patients; 
proc means data=zio.ukb_1st_final_HBP mean median min max n nmiss; 
run; 

* no med; 
PROC SQL;
CREATE TABLE work.ukb_nomed AS 
SELECT *
FROM zio.ukb_1st_final
WHERE HTN_med = 0 and High_Blood_Pressure_diagnosed = 1; 
QUIT; 

proc means data=work.ukb_nomed mean median min max n nmiss; 
run;

* ARB+ACEi; 
PROC SQL;
CREATE TABLE work.ukb_arb_acei AS 
SELECT *
FROM zio.ukb_1st_final
WHERE ARB_ACEI = 1 and High_Blood_Pressure_diagnosed = 1; 
QUIT; 

proc means data=work.ukb_arb_acei mean median min max n nmiss; 
run;

* Other HTN med; 
PROC SQL;
CREATE TABLE work.ukb_other_htn_med AS 
SELECT *
FROM zio.ukb_1st_final_HBP_med
WHERE Other_HTN_med = 1; 
QUIT; 

proc means data=work.ukb_other_htn_med mean median min max n nmiss; 
run;


proc export data=zio.ukb_1st_final
    outfile="D:\SNUlab\SAS\ukb_1st_final.csv"
    dbms=csv;
run;
