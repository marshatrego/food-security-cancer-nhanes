data work.medq_fsq;
	set sasfile.medq_fsq;
	where 19<ridageyr  ;
							/*Creates DigestCanc*/
	if mcq230a=16 or 
	 mcq230a=17 or 
	 mcq230a=18 or 
	 mcq230a=22 or 
	 mcq230a=29 or 
	 mcq230a=31 or 
	 mcq230a=35 then DigestCanc='yes';
	else DigestCanc='no';
	 		
	 					/*Creates MRepCanc (Prostate, Testes)*/
	 if mcq230a=30 or 
	 mcq230a=36 then MRepCanc='yes';
	else MRepCanc='no';

	 					/*Creates FRepCanc (Cervix, Ovary, Uterus)*/
	 if mcq230a=15 or 
	 mcq230a=28 or 
	 mcq230a=38 then FRepCanc='yes';
	else FRepCanc='no';
	
	
						/*Creates BreastCan (Breast)*/
	if mcq230a=14 then BreastCanc='yes';
		else BreastCanc='no';
	
						/*Creates RespCanc (Larynx, Lung)*/
	if mcq230a=20 or
		mcq230a=23 then RespCanc='yes';
	else RespCanc='no';
	
						/*Creates UrinCanc (Bladder, Kidney)*/
	if mcq230a=10 or
		mcq230a=19 then UrinCanc='yes';
	else UrinCanc='no';
	
						/*Creates OtherCanc (11=Blood, 12=Bone, 13=Brain, 21=Leukemia,
						24=Lymphoma/Hodgins, 26=Mouth/tongue/lip, 27=Nervous
						System, 34=Soft Tissue, 37=Thyroid, 39=Other)*/
	if mcq230a=11 or 
	 mcq230a=12 or 
	 mcq230a=13 or 
	 mcq230a=21 or 
	 mcq230a=24 or 
	 mcq230a=26 or 
	 mcq230a=27 or 
	 mcq230a=34 or 
	 mcq230a=37 or 
	 mcq230a=39 then OtherCanc='yes';
	else OtherCanc='no';
	
						/*Creates SkinCanc variable (25=Melanoma, 32=Skin nonmelanoma, 
						33=Skin dont know)*/
	if mcq230a=25 or
	 mcq230a=32 or 
	 mcq230a=33 then SkinCanc='yes';
	 else SkinCanc='no';
	 
	 /*
	  * 
	  * 
	  * 
	  * 
	  * 
	  * 
	  * 
	  * 
	  * 
	  */
	
	 					/*Creates CancerType variable to categorize all responses
	 					to mcq230a*/
	 				/*CancerType=Digest*/
	if mcq230a=16 or 
	 mcq230a=17 or 
	 mcq230a=18 or 
	 mcq230a=22 or 
	 mcq230a=29 or 
	 mcq230a=31 or 
	 mcq230a=35 then CancerType='Digest';
	 					/*CancerType=MRep (Prostate, Testes)*/
	else if mcq230a=30 or 
	 mcq230a=36 then CancerType='MRep';

	 					/*CancerType=FRep (Cervix, Ovary, Uterus)*/
	else if mcq230a=15 or 
	 mcq230a=28 or 
	 mcq230a=38 then CancerType='FRep';
	
						/*CancerType=Breast (Breast)*/
	else if mcq230a=14 then CancerType='Breast';
		
						/*CancerType=Resp (Larynx, Lung)*/
	else if mcq230a=20 or
		mcq230a=23 then CancerType='Resp';
	
						/*CancerType=Urin (Bladder, Kidney)*/
	else if mcq230a=10 or
		mcq230a=19 then CancerType='Urin';
	
						/*CancerType=Other (11=Blood, 12=Bone, 13=Brain, 21=Leukemia,
						24=Lymphoma/Hodgins, 26=Mouth/tongue/lip, 27=Nervous
						System, 34=Soft Tissue, 37=Thyroid, 39=Other)*/
	else if mcq230a=11 or 
	 mcq230a=12 or 
	 mcq230a=13 or 
	 mcq230a=21 or 
	 mcq230a=24 or 
	 mcq230a=26 or 
	 mcq230a=27 or 
	 mcq230a=34 or 
	 mcq230a=37 or 
	 mcq230a=39 then CancerType='Other';
	
						/*CancerType=Skin (25=Melanoma, 32=Skin nonmelanoma, 
						33=Skin dont know)*/
	else if mcq230a=25 or
	 mcq230a=32 or 
	 mcq230a=33 then CancerType='Skin';

	 else if mcq230a=99 then CancerType='Unknown';
	 
	 /*
	  * 
	  * 
	  * 
	  * 
	  * 
	  * 
	  * 
	  * 
	  */
	 /**************************************************************
	  * *************************************************************
	  * **************************Sociodemographic******************
	  * ************************************************************
	  */
	 					/*Creates a Binary Food Insecurity variable
	 					with FSDAD=1 or 2 (food secure or marginal) is 
	 					"No Food Insecurity" and FSDAD=3 or 4 (food security
	 					low or very low) is "Yes Food Insecurity".*/
	 if fsdad=1 or fsdad=2 then FI_Bin='no ';
	 if fsdad=3 or fsdad=4 then FI_Bin='yes';
	 
	 					/*Creates Gender variable.*/
	 if riagendr=1 then Gender='Male  ';
	 if riagendr=2 then Gender='Female';
	 	*else Gender='Missing';
	 					
	 					/*Creates Age variable with decade categories.*/
	 if 20<=ridageyr<40 then Age='20-39 years';
	 else if 40<=ridageyr<65 then Age='40-64 years';
	
	 else if ridageyr>=65 then Age='>=65 years';

						/*Creates Income Variable*/
	if indfmin2=1 or
	indfmin2=2 or
	indfmin2=3 or
	indfmin2=4 or 
	indfmin2=13 then Income='Under $20,000';
							
	else if indfmin2=5 or indfmin2=6 or indfmin2=7
	or indfmin2=8 or indfmin2=9 or indfmin2=10 or indfmin2=12 or indfmin2=14
	or indfmin2=15 then Income='Over $20,000';
	*else income='Ref or DK';
								/*Compares Cancer+LowIncome NoCancer+LowIncome*/
	if mcq220=1 and income='Under $20,000' then CancInc=1;
	*if mcq220=1 and income='Over $20,000' then CancInc=2;
	if mcq220=2 and income='Under $20,000' then CancInc=3;
	*if mcq220=2 and income='Over $20,000' then CancInc=4;
	
							/*Creates Health Insurance Variable*/
	if hiq031a=14 and hiq031b=15 then Insurance='Private+Medicare';
	else if hiq031a=14 then Insurance='Private';
	else if hiq031b=15 then insurance='Medicare';
	else if hiq031d=17 then Insurance='Medicaid'; 
	else if hiq031e=18 or hiq031f=19 or hiq031g=20 or hiq031h=21 
	or hiq031i=22 or hiq031j=23 then Insurance='Other';
	else Insurance='None';
	
							/*Creates Education Variable*/
	if dmdeduc2=1 or dmdeduc2=2 then Education='Less than High School';
	else if dmdeduc2=3 then Education='High School';
	else if dmdeduc2=4 then Education='Some College or AA';
	else if dmdeduc2=5 then Education='College or Above';
	
							/*Creates Time_Diag Variable for time
							since diagnosis by subtracting age when 
							first cancer first diagnosed (mcq240a) from age at
							time of interview (ridageyr)*/
	Time_Diag=(ridageyr-mcq240e);
	
	if 10<=Time_Diag<20 then Time_Diag1='10-19 Years';
	else if 0<=Time_Diag<5 then Time_Diag1='<5 Years';
	else if 5<=Time_Diag<10 then Time_Diag1='5-9 Years';
	else if 20<=Time_Diag<70 then Time_Diag1='>=20 Years';
	
	if mcq230b=. then MultType='no ';
	else if mcq230b ne . then MultType='yes';
run;
	
proc sort data=work.medq_fsq; 
	by multtype mcq230a mcq230b mcq230c cancertype age gender;
run;
title 'Cancertype by Binary Food Insecurity for people with a history of cancer over age 19. Resp and Unknown Cancer Excluded. Multtype excluded.';
proc surveyfreq data=work.medq_fsq;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint2yr;
	where cancertype ne 'Resp' and cancertype ne 'Unknow' and multtype='no';
	tables cancertype*fi_bin/ chisq1;
run;

	