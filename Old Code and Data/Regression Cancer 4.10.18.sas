proc format;
	value raceth 1='Mexican American'
				2='Other Hispanic'
				3='A NH White'
				4='NH Black'
				5='Other/multi';
	value gender 1='Male'
				2='Female';
	value cancer 1='Cancer History'
				2='No Cancer';
run;
data work.medq_fsq_4yr;
	set sasfile.medq_fsq_4yr;
	where 19<ridageyr and fsdad ne . and mcq220=1;
	
	wtint4yr=1/2*wtint2yr;
	
	
	
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
				then CancerType='A Skin';
	
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
	if fsdad=3 or fsdad=4 then FI_Bin='Food Insecure';
	if fsdad=1 or fsdad=2 then FI_Bin='Food Secure';
	 
	 
	 					/*Creates Gender variable.*/
	 /*if riagendr=2 then Gender='Female';
	 if riagendr=1 then Gender='Male';
	 */
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
					
									/*Creates Time_Diag Variable for time
							since diagnosis by subtracting age when 
							first cancer first diagnosed (mcq240a) from age at
							time of interview (ridageyr)*/

	If mcq240a <500 and mcq240aa <500 and mcq240b <500 and mcq240bb <500 and mcq240c <500 and mcq240cc <500 and mcq240d <500 and mcq240dd <500 and mcq240dk <500 and 
	mcq240e  <500 and mcq240f <500 and mcq240g <500 and mcq240h <500 and mcq240i <500 and mcq240j <500 and mcq240k <500 and mcq240l <500 and mcq240m <500 and 
	mcq240n <500 and mcq240o <500 and mcq240p <500 and mcq240q <500 and mcq240r <500 and mcq240s <500 and mcq240t <500 and mcq240u <500 and mcq240v <500 and 
	mcq240w <500 and mcq240x <500 and mcq240y <500 and mcq240z <500 then 
	
	
		Age_Diag=sum(mcq240a,mcq240aa,mcq240b,mcq240bb,mcq240c,mcq240cc,mcq240d,mcq240dd,mcq240dk,
	mcq240e,mcq240f,mcq240g,mcq240h,mcq240i,mcq240j,mcq240k,mcq240l,mcq240m,
	mcq240n,mcq240o,mcq240p,mcq240q,mcq240r,mcq240s,mcq240t,mcq240u,mcq240v,
	mcq240w,mcq240x,mcq240y,mcq240z);
	
	Time_Diag=(ridageyr-Age_Diag);
	 					
	if 0<=Time_Diag<5 then Time_Diag2='<5 Years ';
	else if 5<=Time_Diag then Time_Diag2='>=5 Years';
	
run; 


	
proc surveylogistic data=work.medq_fsq_4yr;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	class cancertype (param=ref ref=first) riagendr (param=ref ref=first) ridreth1 (param=ref ref=first) incomegroup insurance education ;
	format ridreth1 raceth. riagendr gender. mcq220 cancer.;
	model fi_bin (event='Food Insecure')= cancertype 
										  riagendr  
										  ridageyr 
										  ridreth1 
										  indfmpir 
										  insurance 
										  education /expb rsquare parmlabel 
		/*/ clparm clodds corrb covb expb parmlabel rsquare stb*/;
	units ridageyr=10 ;
	
run;

		/*for a one unit change in the predictor variable, the odds ratio for a positive outcome 
		is expected to change by the respective coefficient, given the other variables in the 
		model are held constant.*/
