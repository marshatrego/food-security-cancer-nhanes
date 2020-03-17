*All people over age 19 with and without cancer;
data work.medq_fsq_4yr_all;
	set sasfile.medq_fsq_4yr;
	where 19<ridageyr;
	
	wtint4yr=1/2*wtint2yr;
	
	if mcq220=1 and mcq230b=. and fsdad ne . then Cancer='Yes';
		else if mcq220=2 and fsdad ne . then Cancer='No';
	
	
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
	else if mcq230a=25 then CancerType='Skin';

	 else if mcq230a=99 then CancerType='Unknown';
	 
							 /*Creates a variable for one type of 
	 						multiple types of cancer*/
	if mcq230b=. then MultType='no ';
	else if mcq230b ne . then MultType='yes';
	 
	 /*
	  * 
	  * 
	  * 
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
	 					
	 					/*Creates Age variable with decade categories.*/
	 if 20<=ridageyr<40 then Age='20-39 years';
	 else if 40<=ridageyr<65 then Age='40-64 years';
	
	 else if ridageyr>=65 then Age='>=65 years';
	 
	 	 					/*Creates Age1 variable Divided by Average Age of Diagnosis =52.*/
	 if 20<=ridageyr<52 then Age1='20-51 years';
	 else if 52<=ridageyr<65 then Age1='52-64 years';
	
	 else if ridageyr>=65 then Age1='>=65 years';
	 
	 					/*Creates Ethnicity Variable*/
	 if ridreth3=1 
	 	or ridreth3=2 then Ethnicity='Hispanic/Mex';
	 else if ridreth3=3 then Ethnicity='NH White';
	 else if ridreth3=4 then Ethnicity='NH Black';
	 else if ridreth3=6 then Ethnicity='NH Asian';
	 else if ridreth3=7 then Ethnicity='Other/Multi';

						/*Creates IncomeGroup Variable (< or > $20,000)*/
	if indfmin2=1 or
	indfmin2=2 or
	indfmin2=3 or
	indfmin2=4 or 
	indfmin2=13 then IncomeGroup='Under $20,000';
							
	else if indfmin2=5 or indfmin2=6 or indfmin2=7
	or indfmin2=8 or indfmin2=9 or indfmin2=10 or indfmin2=12 or indfmin2=14
	or indfmin2=15 then IncomeGroup='$20,000 or Over';
	
	if hiq011=1 then Insurance='yes';
	else if hiq011=2 then Insurance='no';
	
							/*Creates Education Variable*/
	if dmdeduc2=1 or dmdeduc2=2 then Education='Less than High School';
	else if dmdeduc2=3 then Education='High School';
	else if dmdeduc2=4 then Education='Some College/Associate';
	else if dmdeduc2=5 then Education='College or Above';
	
									/*Creates Education1 Variable*/
	if dmdeduc2=1 or dmdeduc2=2 or dmdeduc2=3 then Education1='High School or Less';
	else if dmdeduc2=4 or dmdeduc2=5 then Education1='Some College or above';
					
run; 
			

proc surveyfreq data=work.medq_fsq_4yr_all;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	tables 

			cancer*education1
		/*	cancer*fi_bin
			cancer*fsdad
			cancer*age1
			/*
			age1*cancer*fi_bin
			gender*cancer*fi_bin
			ethnicity*cancer*fi_bin
			incomegroup*cancer*fi_bin
			insurance*cancer*fi_bin
			education*cancer*fi_bin
				*/
			/ row chisq1;
			
run;
			 /*
title 'Sociodemographic Info All People >19 Years';
proc surveyfreq data=work.medq_fsq_4yr_all;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	tables 
			
			gender
			age1
			ethnicity
			incomegroup
			insurance
			education 
			cancer
			cancer*fi_bin
			cancer*gender
			cancer*age1
			cancer*ethnicity
			cancer*incomegroup
			cancer*insurance
			cancer*education
			/ row chisq1;
			
run;
		
proc sort data=work.medq_fsq_4yr_all;
	by ridageyr cancer;
run;

		
proc surveymeans data=work.medq_fsq_4yr_all;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	
	var ridageyr;
	domain cancer/ diff;
run;
		*/