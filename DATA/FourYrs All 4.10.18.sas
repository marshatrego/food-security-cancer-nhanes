
data work.medq_fsq_4yr_all;
	set sasfile.medq_fsq_4yr;
	where 19<ridageyr and fsdad ne . ;
	length fi_bin $13;
	
	label ridreth1='Race/Ethnicity'
		  riagendr='Gender';
	
	
	wtint4yr=1/2*wtint2yr;
	
	if      mcq220=1  then Cancer='Yes';
	else if mcq220=2  then Cancer='No';
	
	
	 					/*Creates CancerType variable to categorize all responses
	 					to mcq230a*/
	 				/*CancerType=Digest*/
	if mcq230a=16 and mcq230b=. or 
	 	mcq230a=17 and mcq230b=. or 
	 	mcq230a=18 and mcq230b=. or 
	 	mcq230a=22 and mcq230b=. or 
	 	mcq230a=29 and mcq230b=. or  
	 	mcq230a=31 and mcq230b=. or 
	 	mcq230a=35 and mcq230b=. then CancerType='Digest';
	 					/*CancerType=MRep (Prostate, Testes)*/
	else if mcq230a=30 and mcq230b=. or 
	 		mcq230a=36 and mcq230b=. then CancerType='MRep';

	 					/*CancerType=FRep (Cervix, Ovary, Uterus)*/
	else if mcq230a=15 and mcq230b=. or 
		 	mcq230a=28 and mcq230b=. or 
	 		mcq230a=38 and mcq230b=. then CancerType='FRep';
	
						/*CancerType=Breast (Breast)*/
	else if mcq230a=14 and mcq230b=. then CancerType='Breast';
		
						/*CancerType=Resp (Larynx, Lung)*/
	else if mcq230a=20 and mcq230b=. or
			mcq230a=23 and mcq230b=. then CancerType='Resp';
	
						/*CancerType=Urin (Bladder, Kidney)*/
	else if mcq230a=10 and mcq230b=. or
			mcq230a=19 and mcq230b=. then CancerType='Urin';
	
						/*CancerType=Other (11=Blood, 12=Bone, 13=Brain, 21=Leukemia,
						24=Lymphoma/Hodgins, 26=Mouth/tongue/lip, 27=Nervous
						System, 34=Soft Tissue, 37=Thyroid, 39=Other, 99=Unknown)*/
	else if mcq230a=11 and mcq230b=. or 
	 mcq230a=12 and mcq230b=. or 
	 mcq230a=13 and mcq230b=. or 
	 mcq230a=21 and mcq230b=. or 
	 mcq230a=24 and mcq230b=. or 
	 mcq230a=26 and mcq230b=. or 
	 mcq230a=27 and mcq230b=. or 
	 mcq230a=34 and mcq230b=. or 
	 mcq230a=37 and mcq230b=. or 
	 mcq230a=39 and mcq230b=. or 
	 mcq230a=99 and mcq230b=. then CancerType='Other';
	
						/*CancerType=Skin (25=Melanoma, 32=Skin nonmelanoma, 
						33=Skin dont know)*/
	else if mcq230a=25 and mcq230b=. or 
			mcq230a=32 and mcq230b=. or 
			mcq230a=33 and mcq230b=.
				then CancerType='Skin';
	
	else if mcq230b ne . then CancerType='Mult';
	 

	 
	 /*
	  * 
	  * 
	  * 
	  */
	 	 					/*Creates a Binary Food Insecurity variable
	 					with FSDAD=1 or 2 (food secure or marginal) is 
	 					"No Food Insecurity" and FSDAD=3 or 4 (food security
	 					low or very low) is "Yes Food Insecurity".*/
	 if fsdad=1 or fsdad=2 then FI_Bin='Food Secure';
	 if fsdad=3 or fsdad=4 then FI_Bin='Food Insecure';
	 
	 
	 
	 					/*Creates Gender variable.*/
	 if riagendr=2 then Gender='Female';
	 if riagendr=1 then Gender='Male';
	 
	 					/*Creates Age variable with decade categories.*/
	 if 20<=ridageyr<40 then Age='20-39 years';
	 else if 40<=ridageyr<65 then Age='40-64 years';
	
	 else if ridageyr>=65 then Age='>=65 years';
	 
	 	 					/*Creates Age1 variable Divided by Average Age of Diagnosis =52.*/
	 if 20<=ridageyr<52 then Age1='20-51 years';
	 else if 52<=ridageyr<65 then Age1='52-64 years';
	
	 else if ridageyr>=65 then Age1='>=65 years';
	 
	 					/*Creates Ethnicity Variable*/
	 /*
	 if ridreth1=1 
	 	or ridreth1=2 then Ethnicity='Hispanic/Mex';
	 else if ridreth1=3 then Ethnicity='NH White';
	 else if ridreth1=4 then Ethnicity='NH Black';
	 else if ridreth1=6 then Ethnicity='NH Asian';
	 else if ridreth1=7 then Ethnicity='Other/Multi';
	 */

						/*Creates IncomeGroup Variable (< or > $20,000)*/
	if indfmin2=1 or
	indfmin2=2 or
	indfmin2=3 or
	indfmin2=4 or 
	indfmin2=13 then IncomeGroup='<$20,000 ';
							
	else if indfmin2=5 or indfmin2=6 or indfmin2=7
	or indfmin2=8 or indfmin2=9 or indfmin2=10 or indfmin2=12 or indfmin2=14
	or indfmin2=15 then IncomeGroup='>=$20,000';
	
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
			gender*cancer*fi_bin
			age1*cancer*fi_bin
			ridreth1*cancer*fi_bin
			incomegroup*cancer*fi_bin
			insurance*cancer*fi_bin
			education*cancer*fi_bin
			
			/*
			cancer*fi_bin
			cancer*fsdad
			cancer*age1
			
			age1*cancer*fi_bin
			gender*cancer*fi_bin
			ethnicity*cancer*fi_bin
			incomegroup*cancer*fi_bin
			insurance*cancer*fi_bin
			education*cancer*fi_bin
				*/
			/ row chisq1;
			
run;
				*/ 
				
title 'SD factors by food insecurity';
title2 'Total population';
proc surveyfreq data=work.medq_fsq_4yr_all;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	format ridreth1 raceth. riagendr gender. ;
	 
	tables 
			cancer*fi_bin
			riagendr*fi_bin
			age1*fi_bin
			ridreth1*fi_bin
			incomegroup*fi_bin
			insurance*fi_bin
			education *fi_bin
			
			/ row chisq1;
			
run;

	
proc sort data=work.medq_fsq_4yr_all;
	by indfmpir cancer ridageyr fi_bin;
run;
proc surveymeans data=work.medq_fsq_4yr_all;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	
	var ridageyr indfmpir ;
	domain cancer*fi_bin / diff;
run;
