
data work.medq_fsq_4yr;
	set sasfile.medq_fsq_4yr;
	where 19<ridageyr and mcq220=1 and fsdad ne .;
	
	wtint4yr=1/2*wtint2yr;

	
	
							/*Creates DigestCanc*/
	if mcq230a=16 and mcq230b=. or 
	 mcq230a=17 and mcq230b=. or 
	 mcq230a=18 and mcq230b=. or 
	 mcq230a=22 and mcq230b=. or 
	 mcq230a=29 and mcq230b=. or 
	 mcq230a=31 and mcq230b=. or 
	 mcq230a=35 and mcq230b=. then DigestCanc='yes';
	else DigestCanc='no';
	 		
	 					/*Creates MRepCanc (Prostate, Testes)*/
	 if mcq230a=30 and mcq230b=. or 
	 mcq230a=36 and mcq230b=. then MRepCanc='yes';
	else MRepCanc='no';

	 					/*Creates FRepCanc (Cervix, Ovary, Uterus)*/
	 if mcq230a=15 and mcq230b=. or 
	 mcq230a=28 and mcq230b=. or 
	 mcq230a=38 and mcq230b=. then FRepCanc='yes';
	else FRepCanc='no';
	
	
						/*Creates BreastCan (Breast)*/
	if mcq230a=14 then BreastCanc='yes';
		else BreastCanc='no';
	
						/*Creates RespCanc (Larynx, Lung)*/
	if mcq230a=20 and mcq230b=. or
		mcq230a=23 and mcq230b=. then RespCanc='yes';
	else RespCanc='no';
	
						/*Creates UrinCanc (Bladder, Kidney)*/
	if mcq230a=10 and mcq230b=. or
		mcq230a=19 and mcq230b=. then UrinCanc='yes';
	else UrinCanc='no';
	
						/*Creates OtherCanc (11=Blood, 12=Bone, 13=Brain, 21=Leukemia,
						24=Lymphoma/Hodgins, 26=Mouth/tongue/lip, 27=Nervous
						System, 34=Soft Tissue, 37=Thyroid, 39=Other)*/
	if mcq230a=11 and mcq230b=. or 
	 mcq230a=12 and mcq230b=. or 
	 mcq230a=13 and mcq230b=. or 
	 mcq230a=21 and mcq230b=. or 
	 mcq230a=24 and mcq230b=. or 
	 mcq230a=26 and mcq230b=. or 
	 mcq230a=27 and mcq230b=. or 
	 mcq230a=34 and mcq230b=. or 
	 mcq230a=37 and mcq230b=. or 
	 mcq230a=39 and mcq230b=. or
	 mcq230a=99 and mcq230b=. then OtherCanc='yes';
	else OtherCanc='no';
	
						/*Creates SkinCanc variable (25=Melanoma, 32=Skin nonmelanoma, 
						33=Skin dont know)*/
	if mcq230a=25 and mcq230b=. or
		mcq230a=32 and mcq230b=. or
		mcq230a=33 and mcq230b=. then SkinCanc='yes';
	 else SkinCanc='no';
	 
	if mcq230b ne . then MultCanc='yes';
	else MultCanc='no';
	 
	 
	 
	 					/*Creates CancerType variable to categorize all responses
	 					to mcq230a*/
	 				/*CancerType=Digest*/
	if mcq230a=16 and mcq230b=. then Cancertype='Colon     ';
	else if	mcq230a=17 and mcq230b=. then cancertype='Esophagus';
	else if	mcq230a=18 and mcq230b=. then cancertype='gallbladder';
 	else if mcq230a=22 and mcq230b=. then cancertype='Liver';
	else if	mcq230a=29 and mcq230b=. then cancertype='pancreas';
	else if	mcq230a=31 and mcq230b=. then cancertype='rectum';
	else if	mcq230a=35 and mcq230b=. then CancerType='stomach';
	 	
	 					/*CancerType=MRep (Prostate, Testes)*/
	else if mcq230a=30 and mcq230b=. then cancertype='prostate';
	else if	mcq230a=36 and mcq230b=. then CancerType='testis';

	 					/*CancerType=FRep (Cervix, Ovary, Uterus)*/
	else if mcq230a=15 and mcq230b=. then cancertype='Cervix';
	else if	mcq230a=28 and mcq230b=. then cancertype='Ovary';
	else if	mcq230a=38 and mcq230b=. then CancerType='Uterus';
	
						/*CancerType=Breast (Breast)*/
	else if mcq230a=14 and mcq230b=. then CancerType='Breast';
		
						/*CancerType=Resp (Larynx, Lung)*/
	else if mcq230a=20 and mcq230b=. then cancertype='larynx';
	else if	mcq230a=23 and mcq230b=. then CancerType='Lung';
	
						/*CancerType=Urin (Bladder, Kidney)*/
	else if mcq230a=10 and mcq230b=. then cancertype='bladder';
	else if	mcq230a=19 and mcq230b=. then CancerType='kidney';
	
						/*CancerType=Other (11=Blood, 12=Bone, 13=Brain, 21=Leukemia,
						24=Lymphoma/Hodgins, 26=Mouth/tongue/lip, 27=Nervous
						System, 34=Soft Tissue, 37=Thyroid, 39=Other, 99=Unknown)*/
	else if mcq230a=11 and mcq230b=. then cancertype='blood';
	else if	mcq230a=12 and mcq230b=. then cancertype='bone';
	else if	mcq230a=13 and mcq230b=. then cancertype='brain';
	else if	mcq230a=21 and mcq230b=. then cancertype='leukemia';
	else if	mcq230a=24 and mcq230b=. then cancertype='lymphoma';
	else if	mcq230a=26 and mcq230b=. then cancertype='mouth';
	else if	mcq230a=27 and mcq230b=. then cancertype='nervous';
	else if	mcq230a=34 and mcq230b=. then cancertype='soft tissue';
	else if	mcq230a=37 and mcq230b=. then cancertype='thyroid';
	else if	mcq230a=39 and mcq230b=. then cancertype='other';
	else if	mcq230a=99 and mcq230b=. then CancerType='unknown';
	
						/*CancerType=Skin (25=Melanoma, 32=Skin nonmelanoma, 
						33=Skin dont know)*/
	else if mcq230a=25 and mcq230b=. then cancertype='melanoma';  
	else if	mcq230a=32 and mcq230b=. then cancertype='nonmelanoma';
	else if	mcq230a=33 and mcq230b=. then cancertype='ukskin';
	
	else if mcq230b ne . then CancerType='Mult';
	

	 	 					/*Creates a Binary Food Insecurity variable
	 					with FSDAD=1 or 2 (food secure or marginal) is 
	 					"No Food Insecurity" and FSDAD=3 or 4 (food security
	 					low or very low) is "Yes Food Insecurity".*/
	 if fsdad=1 or fsdad=2 then FI_Bin='no ';
	 if fsdad=3 or fsdad=4 then FI_Bin='yes';

run;
proc surveyfreq data=work.medq_fsq_4yr;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	tables cancertype*fi_bin/ row chisq1;
run;