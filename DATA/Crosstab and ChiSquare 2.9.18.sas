data work.medq_fsq;
	set sasfile.medq_fsq; 
	
	where  19<ridageyr<80 ;
						/*Creates DigestCanc*/
	if mcq230a=16 or 
	 mcq230a=17 or 
	 mcq230a=18 or 
	 mcq230a=22 or 
	 mcq230a=29 or 
	 mcq230a=31 or 
	 mcq230a=35 then DigestCanc='yes';
	else DigestCanc='no';
	
	if mcq230b eq 16 or 
	 mcq230b eq 17 or 
	 mcq230b eq 18 or 
	 mcq230b eq 22 or 
	 mcq230b eq 29 or 
	 mcq230b eq 31 or 
	 mcq230b eq 35 then DigestCanc='yes'; 
	 
	 if mcq230c eq 16 or 
	 mcq230c eq 17 or 
	 mcq230c eq 18 or 
	 mcq230c eq 22 or 
	 mcq230c eq 29 or 
	 mcq230c eq 31 or 
	 mcq230c eq 35 then DigestCanc='yes';
	 		
	 					/*Creates MRepCanc (Prostate, Testes)*/
	 if mcq230a=30 or 
	 mcq230a=36 then MRepCanc='yes';
	else MRepCanc='no';
	
	 if mcq230b=30 or 
	 mcq230b=36 then MRepCanc='yes';
	 
	  if mcq230c=30 or 
	 mcq230c=36 then MRepCanc='yes';
	 					/*Creates FRepCanc (Cervix, Ovary, Uterus)*/
	 if mcq230a=15 or 
	 mcq230a=28 or 
	 mcq230a=38 then FRepCanc='yes';
	else FRepCanc='no';
	
	if mcq230b=15 or 
	 mcq230b=28 or 
	 mcq230b=38 then FRepCanc='yes';
	
	if mcq230c=15 or 
	 mcq230c=28 or 
	 mcq230c=38 then FRepCanc='yes';
	
						/*Creates BreastCan (Breast)*/
	if mcq230a=14 then BreastCanc='yes';
		else BreastCanc='no';
	if mcq230b=14 then BreastCanc='yes';
	if mcq230c=14 then BreastCanc='yes';
	
						/*Creates RespCanc (Larynx, Lung)*/
	if mcq230a=20 or
		mcq230a=23 then RespCanc='yes';
	else RespCanc='no';
	if mcq230b=20 or
		mcq230b=23 then RespCanc='yes';
	if mcq230c=20 or
		mcq230c=23 then RespCanc='yes';
	
						/*Creates UrinCanc (Bladder, Kidney)*/
	if mcq230a=10 or
		mcq230a=19 then UrinCanc='yes';
	else UrinCanc='no';
	if mcq230b=10 or
		mcq230b=19 then UrinCanc='yes';
	if mcq230c=10 or
		mcq230c=19 then UrinCanc='yes';
		
						/*Creates OtherCanc (Blood, Bone, Brain, Leukemia,
						Lymphoma/Hodgins, Melanoma, Mouth/tongue/lip, Nervous
						System, Skin(nm), Skin(dk), Soft Tissue, Thyroid, Other)*/
	if mcq230a=11 or 
	 mcq230a=12 or 
	 mcq230a=13 or 
	 mcq230a=21 or 
	 mcq230a=24 or 
	 mcq230a=25 or 
	 mcq230a=26 or 
	 mcq230a=27 or 
	 mcq230a=32 or 
	 mcq230a=33 or 
	 mcq230a=34 or 
	 mcq230a=37 or 
	 mcq230a=39 then OtherCanc='yes';
	else OtherCanc='no';
	
	if mcq230b=11 or 
	 mcq230b=12 or 
	 mcq230b=13 or 
	 mcq230b=21 or 
	 mcq230b=24 or 
	 mcq230b=25 or 
	 mcq230b=26 or 
	 mcq230b=27 or 
	 mcq230b=32 or 
	 mcq230b=33 or 
	 mcq230b=34 or 
	 mcq230b=37 or 
	 mcq230b=39 then OtherCanc='yes';
	 
	 if mcq230c=11 or 
	 mcq230c=12 or 
	 mcq230c=13 or 
	 mcq230c=21 or 
	 mcq230c=24 or 
	 mcq230c=25 or 
	 mcq230c=26 or 
	 mcq230c=27 or 
	 mcq230c=32 or 
	 mcq230c=33 or 
	 mcq230c=34 or 
	 mcq230c=37 or 
	 mcq230c=39 then OtherCanc='yes';
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
	 		
	
	 if 20<=ridageyr<50 then Age='20-49 years';
	 if 50<=ridageyr<80 then Age='50-79 years';

	
	
run;

proc format; 
	value CancerType 10='Bladder'
			11='Blood' 12='Bone' 13='Brain' 14='Breast'
			15='Cervix' 16='Colon' 17='Esophagus' 18='Gallbladder'
			19='Kidney' 20='Larynx' 21='Leukemia' 22='Liver'
			23='Lung' 24='Lymphoma/Hodg' 25='Melanoma' 26='Mouth/tongue/lip'
			27='Nervous' 28='Ovary' 29='Pancreas' 30='Prostate'
			31='Rectum' 32='Skin (nm)' 33='Skin (dk)' 34='Soft Tissue'
			35='Stomach' 36='Testis' 37='Thyroid' 38='Uterus' 39='Other';
run;

		/*
data work.gender_fsbin_test;
	set sasfile.medq_fsq;
		where 20<=ridageyr<=100;
	 if fsdad=1 or fsdad=2 then FI_Bin='no ';
	 if fsdad=3 or fsdad=4 then FI_Bin='yes';
	 
	 if riagendr=1 then Gender='Male  ';
	 if riagendr=2 then Gender='Female';
run;
			*/
proc sort data=work.medq_fsq;
	by indfmin2 cancertype fi_bin;
run;
proc print data=work.medq_fsq;
	var indfmin2 cancertype fi_bin;
run;

proc surveyfreq data=work.medq_fsq; 
	
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint2yr;
	tables digestcanc mrepcanc frepcanc breastcanc respcanc urincanc othercanc;
		/*
	*tables DigestCanc*fsdad;
	tables DigestCanc*FI_Bin/ chisq1 ;
		tables digestcanc*fsdad/ chisq1;
	tables MRepCanc*FI_Bin/ chisq1 ;
		tables mrepcanc*fsdad/ chisq1;
		
	tables FRepCanc*FI_Bin/ chisq1 ;
		tables frepcanc*fsdad/ chisq1;
		
	tables BreastCanc*FI_Bin/ chisq1 ;
		tables breastcanc*fsdad/ chisq1;
		/*
	tables RespCanc*FI_Bin/ chisq1 ;
		tables respcanc*fsdad/ chisq1;
	tables UrinCanc*FI_Bin/ chisq1 ;
		tables urincanc*fsdad/ chisq1;
	tables OtherCanc*FI_Bin/ chisq1 ;
		tables othercanc*fsdad/ chisq1;
		
	tables mcq220*fsdad/ chisq1; 
	tables mcq220*fi_bin/ chisq1;
		*/
run;
proc sort data=work.medq_fsq;
	by indfmpir;
run;
proc print data=work.medq_fsq;
	var indfmpir;
run;
