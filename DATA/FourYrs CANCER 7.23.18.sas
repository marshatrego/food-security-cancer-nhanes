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
	value cancertype 25='Melanoma' 32='Nonmelanoma' 33='SkinDK' 14='Breast' 15='Cervix' 28='Ovarian' 38='Uterus'
	16='Colon' 17='Esophagus' 18='Gallbladder' 
	22='Liver' 29='Pancreas' 31='Rectum' 35='Stomach'
	30='Prostate' 36='Testis' 20='Larynx' 23='Lung'
	10='Bladder' 19='Kidney' 11='Blood' 12='Bone'
	13='Brain' 21='Leukemia' 24='Lymphoma' 26='Mouth/tongue/lip'
	27='Nervous' 34='Soft tissue' 37='Thyroid' 39='Other';
run;
data work.medq_fsq_4yr_all;
	set sasfile.medq_fsq_4yr;
	where 19<ridageyr and fsdad ne . and mcq220=1;
	length fi_bin $13;
	
	label ridreth1='Race/Ethnicity'
		  riagendr='Gender';
	
	
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
			
	else if mcq230a=24 and mcq230b=. then CancerType="Lymphoma";
	
	else if mcq230a=37 and mcq230b=. then CancerType='Endocrine';
	
	else if mcq230a=21 and mcq230b=. then CancerType='Leukemia';
	else if mcq230a=26 and mcq230b=. then CancerType='Oral';
	else if mcq230a=13 and mcq230b=. or
		mcq230a=27 and mcq230b=. then CancerType='Nervous';
	else if mcq230a=11 and mcq230b=. or 
		 mcq230a=12 and mcq230b=. then CancerType='Blood/bone';
	else if  mcq230a=34 and mcq230b=. then CancerType='SoftTis';
	
						/*CancerType=Other (x11=Blood, x12=Bone, x13=Brain, x21=Leukemia,
						x24=Lymphoma/Hodgins, x26=Mouth/tongue/lip, x27=Nervous
						System, x34=Soft Tissue, x37=Thyroid, 39=Other, 99=Unknown)*/
	else if  
	 mcq230a=39 and mcq230b=. or 
	 mcq230a=99 and mcq230b=. then CancerType='OtherUK';
	
						/*CancerType=Skin (25=Melanoma, 32=Skin nonmelanoma, 
						33=Skin dont know)*/
	else if mcq230a=25 and mcq230b=. then CancerType='Skin';
	else if mcq230a=32 and mcq230b=. or 
			mcq230a=33 and mcq230b=.
				then CancerType='NMSkin';
	
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
	 if 20<=ridageyr<30 then Age='20-29 years';
	 else if 30<=ridageyr<40 then Age='30-39 years';
	else if 40<=ridageyr<50 then Age='40-49 years';
	else if 50<=ridageyr<60 then Age='50-59 years';
	else if 60<=ridageyr<70 then Age='60-69 years';
	else if 70<=ridageyr<80 then Age='70-79 years';
	 else if ridageyr>=80 then Age='>=80 years';
	 
	
	
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
	
					/*Creates Categorical Income to Poverty Ratio Var*/
	if indfmpir<1 then IPR='Less than 1';
	else if 1<=indfmpir<2 then IPR='1-1.999';
	else if 2<=indfmpir<3 then IPR='2-2.999';
	else if 3<=indfmpir<4 then IPR='3-3.999';
	else if 4<=indfmpir<5 then IPR='4-4.999';
	else if 5<=indfmpir then IPR='5 or greater';
	
					/*Creates Partner Status Var*/
	if dmdmartl=1 or dmdmartl=6 then Partner='Partner';
	else if dmdmartl=2 or dmdmartl=3 or dmdmartl=4 or dmdmartl=5 or dmdmartl=77 or dmdmartl=99 then Partner='NoPart';
	
					/*Creates Children Var*/
	if dmdhhsza=0 and dmdhhszb=0 then Children='NO Child';
	else if dmdhhsza ne 0 or dmdhhszb ne 0 then Children='Y Child';
	
							/*Creates Time_Diag Variable for time
							since diagnosis by subtracting age when 
							first cancer first diagnosed (mcq240a) from age at
							time of interview (ridageyr)
							The <500 part is to eliminate responses of refused 
							(77777) or don't know (99999)*/

	If mcq240a <500 and mcq240aa <500 and mcq240b <500 and mcq240bb <500 and mcq240c <500 and mcq240cc <500 and mcq240d <500 and mcq240dd <500 and mcq240dk <500 and 
	mcq240e  <500 and mcq240f <500 and mcq240g <500 and mcq240h <500 and mcq240i <500 and mcq240j <500 and mcq240k <500 and mcq240l <500 and mcq240m <500 and 
	mcq240n <500 and mcq240o <500 and mcq240p <500 and mcq240q <500 and mcq240r <500 and mcq240s <500 and mcq240t <500 and mcq240u <500 and mcq240v <500 and 
	mcq240w <500 and mcq240x <500 and mcq240y <500 and mcq240z <500 then 
	
	
		Age_Diag=sum(mcq240a,mcq240aa,mcq240b,mcq240bb,mcq240c,mcq240cc,mcq240d,mcq240dd,mcq240dk,
	mcq240e,mcq240f,mcq240g,mcq240h,mcq240i,mcq240j,mcq240k,mcq240l,mcq240m,
	mcq240n,mcq240o,mcq240p,mcq240q,mcq240r,mcq240s,mcq240t,mcq240u,mcq240v,
	mcq240w,mcq240x,mcq240y,mcq240z);
	
	if 0<age_diag<20 then Age_Diag1='0 to 20 years old';
	else if 20<=age_diag<30 then Age_diag1='20 to 29 years old';
	else if 30<=age_diag<40 then Age_diag1='30 to 39 years old';
	else if 40<=age_diag<50 then Age_diag1='40 to 49 years old';
	else if 50<=age_diag<60 then Age_diag1='50 to 59 years old';
	else if 60<=age_diag<70 then Age_diag1='60 to 69 years old';
	else if 70<=age_diag<80 then Age_diag1='70 to 79 years old';
	else if 80<=age_diag then Age_diag1='80 years or older';
	
	Time_Diag=(ridageyr-Age_Diag);
	 if 0<=Time_Diag<1 then Time_Diag2='<1 Years ';
	else if 1<=Time_Diag<5 then Time_Diag2='1-5 Years ';
	else if 5<=Time_Diag then Time_Diag2='>=5 Years';
	
	if 0<=Time_Diag<5 then Time_Diag3='<5 Years ';
	else if 5<=Time_Diag then Time_Diag3='>=5 Years ';
	
run; 

proc surveyfreq data=work.medq_fsq_4yr_all;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	tables cancertype;
run;
proc freq data=work.medq_fsq_4yr_all;
	tables cancertype;
run;
	
proc surveyfreq data=work.medq_fsq_4yr_all;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	format ridreth1 raceth. riagendr gender. ;
	tables 
			
			gender*fi_bin
			age*fi_bin
			ridreth1*fi_bin
			IPR*fi_bin
			insurance*fi_bin
			education*fi_bin
			partner*fi_bin
			children*fi_bin
			
			/ row chisq1;
			
run;
				


