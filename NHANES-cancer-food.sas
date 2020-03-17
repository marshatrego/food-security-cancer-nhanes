
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
	where 19<ridageyr and fsdad ne .  and mcq220 ne .;
	length fi_bin $13;
	
	label ridreth1='Race/Ethnicity'
		  riagendr='Gender';
	
	
	wtint4yr=1/2*wtint2yr;
	
	
	if mcq220=1 then Cancer='Yes';
	else if mcq220=2 or mcq220=7 or mcq220=9 then Cancer='No';
	
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
	
				
				/*CancerType=Other (10=bladder, 19=kidney, 20=larynx, 23=lung, 11=Blood, 12=Bone, 13=Brain, 21=Leukemia,
						24=Lymphoma/Hodgins, 26=Mouth/tongue/lip, 27=Nervous
						System, 34=Soft Tissue, 37=Thyroid, 39=Other, 99=Unknown)*/
				
	 if mcq230a=20 and mcq230b=. or
	mcq230a=23 and mcq230b=. or				
	  mcq230a=10 and mcq230b=. or
	mcq230a=19 and mcq230b=. or
	mcq230a=24 and mcq230b=. or
	 mcq230a=37 and mcq230b=. or
	 mcq230a=21 and mcq230b=. or
	 mcq230a=26 and mcq230b=. or
	mcq230a=13 and mcq230b=. or
	mcq230a=27 and mcq230b=. or
	mcq230a=11 and mcq230b=. or 
	 mcq230a=12 and mcq230b=. or
	 mcq230a=34 and mcq230b=. or

	 mcq230a=39 and mcq230b=. or 
	 mcq230a=99 and mcq230b=. then CancerType='Other';
	 
	 
	
						/*CancerType=Skin (25=Melanoma, 32=Skin nonmelanoma, 
						33=Skin dont know)*/
	else if mcq230a=25 and mcq230b=. then CancerType='Melanoma';
	
	else if mcq230a=32 and mcq230b=. or 
			mcq230a=33 and mcq230b=.
				then CancerType='NMSkin';
	
	else if mcq230b ne . then CancerType='Mult';

	 /*************************************************************************************************/
	 
	  if mcq230a=16 and mcq230b=. or 
	 	mcq230a=17 and mcq230b=. or 
	 	mcq230a=18 and mcq230b=. or 
	 	mcq230a=22 and mcq230b=. or 
	 	mcq230a=29 and mcq230b=. or  
	 	mcq230a=31 and mcq230b=. or 
	 	mcq230a=35 and mcq230b=. then DigestCanc='Yes';	
	 	else digestcanc='No';
	  if mcq230a=30 and mcq230b=. or 
	 		mcq230a=36 and mcq230b=. then mrepcanc='Yes';
	 	else mrepcanc='No';
	 if mcq230a=15 and mcq230b=. or 
		 	mcq230a=28 and mcq230b=. or 
	 		mcq230a=38 and mcq230b=. then frepcanc='Yes';
	 	else frepcanc='No';
	 if mcq230a=14 and mcq230b=. then Breastcanc='Yes';
	Else breastcanc='No';
	if mcq230a=20 and mcq230b=. or
	mcq230a=23 and mcq230b=. or				
	  mcq230a=10 and mcq230b=. or
	mcq230a=19 and mcq230b=. or
	mcq230a=24 and mcq230b=. or
	 mcq230a=37 and mcq230b=. or
	 mcq230a=21 and mcq230b=. or
	 mcq230a=26 and mcq230b=. or
	mcq230a=13 and mcq230b=. or
	mcq230a=27 and mcq230b=. or
	mcq230a=11 and mcq230b=. or 
	 mcq230a=12 and mcq230b=. or
	 mcq230a=34 and mcq230b=. or

	 mcq230a=39 and mcq230b=. or 
	 mcq230a=99 and mcq230b=. then OtherCanc='Yes';
	 else othercanc='No';
	 if mcq230a=25 and mcq230b=. then Melanoma='Yes';
	else melanoma='No';
	if mcq230a=32 and mcq230b=. or 
			mcq230a=33 and mcq230b=.
				then NMSkin='Yes';
	else NMSkin='No';
	if mcq230b ne . then MultCanc='Yes';
	 else multcanc='No';
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
	 
	  if 20<=ridageyr<40 then Age='2. 20-39 years';
	  else if ridageyr<20 then Age='1. <20 years';
	else if 40<=ridageyr<50 then Age='3. 40-49 years';
	else if 50<=ridageyr<60 then Age='4. 50-59 years';
	else if 60<=ridageyr<70 then Age='5. 60-69 years';
	/*else if 70<=ridageyr<80 then Age='70-79 years'; */
	 else if ridageyr>=70 then Age='6. >=70 years';
	 
	
	
	if hiq011=1 then Insurance='yes';
	else if hiq011=2 then Insurance='no';
	
	if hsd010=1 or hsd010=2 then Health='1. Excellent/very good';
	*else if hsd010=2 then Health='2. Very Good';
	else if hsd010=3 then Health='3. Good';
	else if hsd010=4 then Health='4. Fair';
	else if hsd010=5 then Health='5. Poor';
	
	if dbq700=1 then Diet='1. Excellent';
	else if dbq700=2 then Diet='2. Very Good';
	else if dbq700=3 then Diet='3. Good';
	else if dbq700=4 then Diet='4. Fair';
	else if dbq700=5 then Diet='5. Poor';
	
	/*CBD070=Money spent at supermarket/grocery store*/
	
	
							/*Creates Education Variable*/
	if dmdeduc2=1 or dmdeduc2=2 then Education='**Less than High School';
	else if dmdeduc2=3 then Education='High School';
	else if dmdeduc2=4 then Education='Some College/Associate';
	else if dmdeduc2=5 then Education='College or Above';
	
									/*Creates Education1 Variable*/
	if dmdeduc2=1 or dmdeduc2=2 or dmdeduc2=3 then Education1='High School or Less';
	else if dmdeduc2=4 or dmdeduc2=5 then Education1='Some College or above';
	
					/*Creates Categorical Income to Poverty Ratio Var*/
	if indfmpir<1 then PIR='1. <1    *';
	else if 1<=indfmpir<=1.32 then PIR='2. 1-1.32';
	else if 1.33<=indfmpir<=1.49 then PIR='3. 1.33-1.49';
	else if 1.50<=indfmpir<=1.84 then PIR='4. 1.50-1.84';
	else if 1.85<=indfmpir then PIR='5. >1.85';
	
	
	
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
							(77777) or don't know (99999)
							5 people with 99999 are excluded. Below, if-then excludes
							unknown and min accounts for multiple types*/

	if sum(mcq240a,mcq240aa,mcq240b,mcq240bb,mcq240c,mcq240cc,mcq240d,mcq240dd,mcq240dk,
	mcq240e,mcq240f,mcq240g,mcq240h,mcq240i,mcq240j,mcq240k,mcq240l,mcq240m,
	mcq240n,mcq240o,mcq240p,mcq240q,mcq240r,mcq240s,mcq240t,mcq240u,mcq240v,
	mcq240w,mcq240x,mcq240y,mcq240z)<500 then 
	Age_diag=min(mcq240a, mcq240aa, mcq240b, mcq240bb, mcq240c, mcq240cc, mcq240d, mcq240dd, mcq240dk, 
	mcq240e, mcq240f, mcq240g, mcq240h, mcq240i, mcq240j, mcq240k, mcq240l, mcq240m, 
	mcq240n, mcq240o, mcq240p, mcq240q, mcq240r, mcq240s, mcq240t, mcq240u, mcq240v, 
	mcq240w, mcq240x, mcq240y, mcq240z);
	
	if 0<age_diag<20 then Age_Diag1='0 to 19 years old';
	else if 20<=age_diag<30 then Age_diag1='20-29 years old';
	else if 30<=age_diag<40 then age_diag1='30-39 years ld';
	else if 40<=age_diag<50 then Age_diag1='40-49 years old';
	else if 50<=age_diag<60 then Age_diag1='50-59 years old';
	else if 60<=age_diag<70 then Age_diag1='60-69 years old';
	else if 70<=age_diag<80 then Age_diag1='70-79 years old';
	else if 80<=age_diag then Age_diag1='80 years or older';
	
	if 0<age_diag<20 then Pediatric_cancer='Yes';
	else if 20<=age_diag then Pediatric_cancer='No';
	
	Time_Diag=(ridageyr-Age_diag);
	if Time_Diag<1 then Time_Diag2='1. <1 years ';
	else if 1<=Time_Diag<4 then Time_Diag2='2. 1-3 years ';
	else if 4<=Time_Diag<9 then Time_Diag2='3. 4-8 years ';
	else if 9<=Time_Diag<16 then Time_Diag2='4. 9-15 years';
	else if 15<Time_Diag then Time_Diag2='5. >15 years';
	
	
	
run; 

							/*****************************************
							
							Above sets it up, below is running stats.
							
							******************************************/




/*Model 2 female reproductive*/
proc surveylogistic data=work.medq_fsq_4yr_all;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	class  age (param=ref ref=first) 
			frepcanc (param=ref ref=first) 
			ridreth1 (param=ref ref=first) 
			partner children insurance education (param=ref ref=first) 
			pir (param=ref ref=first) diet(param=ref ref=first) health (param=ref ref=first);
	
	format ridreth1 raceth. riagendr gender. mcq220 cancer.;
	model fi_bin (event='Food Insecure')= 
	
										  frepcanc
										  age
										  ridreth1 
										  PIR 
										  insurance 
										  education
										  partner
										  children
										  diet
										  health
										  /expb rsquare parmlabel ;
		
run;

