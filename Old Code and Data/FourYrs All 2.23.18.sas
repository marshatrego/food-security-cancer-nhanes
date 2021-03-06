data work.medq_fsq_4yr;
	set sasfile.medq_fsq_4yr;
	where 19<ridageyr ;
	
	wtint4yr=1/2*wtint2yr;
	
	if mcq220=1 then Cancer='Yes';
		else if mcq220=2 then Cancer='No';
 
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
	 	*else Gender='Missing';
	 					
	 					/*Creates Age variable with decade categories.*/
	 if 20<=ridageyr<40 then Age='20-39 years';
	 else if 40<=ridageyr<65 then Age='40-64 years';
	
	 else if ridageyr>=65 then Age='>=65 years';
	 
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
	or indfmin2=15 then IncomeGroup='Over $20,000';
	
						/*Creates Income Variable (Increments)*/
	if indfmin2=1 or 
		indfmin2=2 or
		indfmin2=3 or
		indfmin2=4 or
		indfmin2=13 then Income='$0-$19,999       ';
	else if indfmin2=5 or
		indfmin2=6 or
		indfmin2=7 or
		indfmin2=8 then Income='$20,000-$54,999';
	else if indfmin2=9 or
		indfmin2=10 or
		indfmin2=14 then Income='$55,000-$99,999';
	else if indfmin2=15 then Income='$100,000 and Over';
	else if Indfmin2=12 then Income='$20,000 and Over';
	

								/*Compares Cancer+LowIncome NoCancer+LowIncome*/
	if mcq220=1 and income='Under $20,000' then CancInc=1;
	*if mcq220=1 and income='Over $20,000' then CancInc=2;
	if mcq220=2 and income='Under $20,000' then CancInc=3;
	*if mcq220=2 and income='Over $20,000' then CancInc=4;
	
	if hiq011=1 then Insurance='yes';
	else if hiq011=2 then Insurance='no';
	
							/*Creates Education Variable*/
	if dmdeduc2=1 or dmdeduc2=2 then Education='Less than High School';
	else if dmdeduc2=3 then Education='High School';
	else if dmdeduc2=4 then Education='Some College or AA';
	else if dmdeduc2=5 then Education='College or Above';
	
								/*Creates Time_Diag Variable for time
							since diagnosis by subtracting age when 
							first cancer first diagnosed (mcq240a) from age at
							time of interview (ridageyr)*/
	
	
	Age_Diag=sum(mcq240a,mcq240aa,mcq240b,mcq240bb,mcq240c,mcq240cc,mcq240d,mcq240dd,mcq240dk,
	mcq240e,mcq240f,mcq240g,mcq240h,mcq240i,mcq240j,mcq240k,mcq240l,mcq240m,
	mcq240n,mcq240o,mcq240p,mcq240q,mcq240r,mcq240s,mcq240t,mcq240u,mcq240v,
	mcq240w,mcq240x,mcq240y,mcq240z);
	Time_Diag=(ridageyr-Age_Diag);
	
	
	if 10<=Time_Diag<20 then Time_Diag1='10-19 Years';
	else if 0<=Time_Diag<5 then Time_Diag1='<5 Years';
	else if 5<=Time_Diag<10 then Time_Diag1='5-9 Years';
	else if 20<=Time_Diag then Time_Diag1='>=20 Years';
	 					
	if 0<=Time_Diag<5 then Time_Diag2='<5 Years ';
	else if 5<=Time_Diag then Time_Diag2='>=5 Years';
					
run; 

Title Color=depk '4 Year (2011-14) Weighted Frequencies';
Title2 Color=lightpink 'All people >19yrs';
proc surveyfreq data=work.medq_fsq_4yr;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	tables 
			fi_bin
			fsdad
			age*fi_bin
			cancer*fi_bin
			age*cancer*fi_bin
			cancer*age*fi_bin
			cancer*fsdad
			age*cancer*fsdad
			cancer*ethnicity*fi_bin
			ethnicity*cancer*fi_bin
			
			/ row chisq1;
			
run;
Title Color=depk '4 Year (2011-14) Unweighted Frequencies';
Title2 Color=lightpink 'All people >19yrs';
proc freq data=work.medq_fsq_4yr;
	
	tables 
			cancer*fi_bin
			age*cancer*fi_bin
			cancer*fsdad
			age*cancer*fsdad
			/  chisq;
			
run;
		