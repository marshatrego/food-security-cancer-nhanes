data work.medq_fsq;
	set sasfile.medq_fsq;
	where 19<ridageyr and mcq220=1 and mcq230b=. and fsdad ne .;
							
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
		/********************************
		 * ***********************************************
		 ***************************************************
		 ***************************************************
		 * ***************************************************
		 ***************************************************
		 * ***************************************************
		 ***************************************************
		 * ***************************************************
		 ***************************************************
		 * ***************************************************
		 ***************************************************
		 * ***************************************************
		 ***************************************************
		 */
		
data work.medq_fsq1;
	set sasfile.medq_fsq;
	where 19<ridageyr and mcq220=1 and mcq230b=. and fsdad ne . and mcq230a ne 20
		and mcq230a ne 23 and mcq230a ne 99;

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
	
	
							/*Creates Education Variable*/
	if dmdeduc2=1 or dmdeduc2=2 then Education='Less than High School';
	else if dmdeduc2=3 then Education='High School';
	else if dmdeduc2=4 then Education='Some College or AA';
	else if dmdeduc2=5 then Education='College or Above';
	
					
run; 
		/********************************
		 * *****************22222******************************
		 ***************************************************
		 ***************************************************
		 * ***************************************************
		 ***************************************************
		 * ***************************************************
		 ***************************************************
		 * ***************************************************
		 ***************************************************
		 * ***************************************************
		 ***************************************************
		 * ***************************************************
		 ***************************************************
		 */
data work.medq_fsq2;
	set sasfile.medq_fsq;
	where 19<ridageyr and mcq220=1 and mcq230b=. and fsdad ne . and mcq230a ne 20
		and mcq230a ne 23 and mcq230a ne 99
		and mcq230a ne 15 and mcq230a ne 28 and mcq230a ne 38;

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
	/*else if mcq230a=15 or 
	 mcq230a=28 or 
	 mcq230a=38 then CancerType='FRep';
	*/
						/*CancerType=Breast (Breast)*/
	else if mcq230a=14 then CancerType='Breast';
		
					
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
	
	
							/*Creates Education Variable*/
	if dmdeduc2=1 or dmdeduc2=2 then Education='Less than High School';
	else if dmdeduc2=3 then Education='High School';
	else if dmdeduc2=4 then Education='Some College or AA';
	else if dmdeduc2=5 then Education='College or Above';
	
					
run; 

Title Color=depk '4 Year (2011-14) Weighted Frequencies';
Title2 Color=lightpink 'All people with 1 type of cancer >19yrs, Unknown cancer excluded';
proc surveyfreq data=work.medq_fsq_4yr;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	tables 
			cancertype*time_diag1
			time_diag1*fi_bin
			cancertype*time_diag1*fi_bin
			time_diag1*fsdad
			cancertype*time_diag1*fi_bin
			time_diag2*fi_bin
			cancertype*time_diag2*fi_bin
			time_diag2*fsdad
			cancertype*time_diag2*fsdad
			
			cancertype*fi_bin
			cancertype*fsdad
			
			age*cancertype*fi_bin
			age*cancertype*fsdad
			
			
			
			digestcanc*fi_bin
			digestcanc*fsdad
			gender*mrepcanc*fi_bin
			gender*mrepcanc*fsdad
			gender*frepcanc*fi_bin
			gender*frepcanc*fsdad
			gender*breastcanc*fi_bin
			gender*breastcanc*fsdad
			respcanc*fi_bin
			respcanc*fsdad
			urincanc*fi_bin
			urincanc*fsdad
			othercanc*fi_bin
			othercanc*fsdad
			skincanc*fi_bin
			skincanc*fsdad
			
			gender*fi_bin
			gender*fsdad
			age*fi_bin
			age*fsdad
			ethnicity*fi_bin
			ethnicity*fsdad
			incomegroup*fi_bin
			incomegroup*fsdad
			income*fi_bin
			income*fsdad
			Insurance*fi_bin
			Insurance*fsdad
			education*fi_bin
			education*fsdad
			/ row chisq;
			
run;

Title color=cadetblue '4 Year (2011-14) Unweighted Frequencies';
Title2 color=coral 'All people with 1 type of cancer >19yrs';
proc freq data=work.medq_fsq;
	tables 
			cancertype*time_diag1
			time_diag1*fi_bin
			cancertype*time_diag1*fi_bin
			time_diag1*fsdad
			cancertype*time_diag1*fi_bin
			time_diag2*fi_bin
			cancertype*time_diag2*fi_bin
			time_diag2*fsdad
			cancertype*time_diag2*fsdad
			
			cancertype*fi_bin
			cancertype*fsdad
			
			age*cancertype*fi_bin
			age*cancertype*fsdad
			
			
			
			digestcanc*fi_bin
			digestcanc*fsdad
			gender*mrepcanc*fi_bin
			gender*mrepcanc*fsdad
			gender*frepcanc*fi_bin
			gender*frepcanc*fsdad
			gender*breastcanc*fi_bin
			gender*breastcanc*fsdad
			respcanc*fi_bin
			respcanc*fsdad
			urincanc*fi_bin
			urincanc*fsdad
			othercanc*fi_bin
			othercanc*fsdad
			skincanc*fi_bin
			skincanc*fsdad
			
			gender*fi_bin
			gender*fsdad
			age*fi_bin
			age*fsdad
			ethnicity*fi_bin
			ethnicity*fsdad
			incomegroup*fi_bin
			incomegroup*fsdad
			income*fi_bin
			income*fsdad
			Insurance*fi_bin
			Insurance*fsdad
			education*fi_bin
			education*fsdad/ chisq;
			
run;

title 'Weighted Frequency for all people with 1 type of cancer >19yrs w/o Resp or Unknown Cancer';
proc surveyfreq data=work.medq_fsq1;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint2yr;
	tables cancertype*fi_bin cancertype*fsdad/ row chisq;
run;

title 'Weighted Frequency for all people with 1 type of cancer >19yrs w/o Resp or Unknown Cancer or FRep cancer';
proc surveyfreq data=work.medq_fsq2;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint2yr;
	tables cancertype*fi_bin cancertype*fsdad/ row chisq;
run;
