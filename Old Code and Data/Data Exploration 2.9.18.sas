
data work.medq_fsq;
	set sasfile.medq_fsq; 
	where mcq220=1;
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
run;

				/*Proc Format creates user-defined format for defining
				the cancer type code into an understandable character var.
				New format name is CancerType. Include CancerType format
				in Proc Print step.*/
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



proc sort data=work.medq_fsq;
	by DigestCanc MRepCanc FRepCanc BreastCanc RespCanc UrinCanc OtherCanc;
run;
		
proc print data=work.medq_fsq;
	format mcq230a mcq230b mcq230c CancerType.;
	var mcq220 mcq230a mcq230b mcq230c 
	DigestCanc MRepCanc FRepCanc BreastCanc 
	RespCanc UrinCanc OtherCanc fsdad;
run; 

proc surveyfreq data=work.medq_fsq;
	tables DigestCanc MRepCanc FRepCanc BreastCanc RespCanc UrinCanc OtherCanc;	
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint2yr;
run;

proc surveyfreq data=work.medq_fsq; 
	tables MRepCanc*fsdad;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint2yr;
run;


