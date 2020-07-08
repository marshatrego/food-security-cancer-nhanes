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
data work.medq_fsq_4yr_all;
	set sasfile.medq_fsq_4yr;
	where 19<ridageyr and fsdad ne . ;
	length fi_bin $13;
	
	label ridreth1='Race/Ethnicity'
		  riagendr='Gender';

	
	wtint4yr=1/2*wtint2yr;
	
	if      mcq220=1  then Cancer='Yes';
	else if mcq220=2  then Cancer='No';
	
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
	 if 20<=ridageyr<40 then Age='***20-39 years';
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
	if indfmpir<2 then PIR='**Less than 2';
	else if 2<=indfmpir<3 then PIR='2-2.999';
	*else if 2<=indfmpir<3 then PIR='2-2.999';
	*else if 3<=indfmpir<4 then PIR='3-3.999';
	*else if 4<=indfmpir<5 then PIR='4-4.999';
	else if 3<=indfmpir then PIR='3 or greater';
	
					/*Creates Partner Status Var*/
	if dmdmartl=1 or dmdmartl=6 then Partner='Partner';
	else if dmdmartl=2 or dmdmartl=3 or dmdmartl=4 or dmdmartl=5 or dmdmartl=77 or dmdmartl=99 then Partner='NoPart';
	
					/*Creates Children Var*/
	if dmdhhsza=0 and dmdhhszb=0 then Children='NO Child';
	else if dmdhhsza ne 0 or dmdhhszb ne 0 then Children='Y Child';
		
run; 

proc surveyfreq data=work.medq_fsq_4yr_all;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	format ridreth1 raceth. riagendr gender. ;
	tables
			cancer*gender
			cancer*age
			cancer*ridreth1
			cancer*PIR
			cancer*insurance
			cancer*education
			cancer*partner
			cancer*children
			/ row chisq1;
			
run;
	/*
Gender
     Female
     Male
Age
     20-29 years
     30-39
     40-49
     50-59
     60-69 years
     70-79 years
     80 years and older
Ethnicity
     Mexican American
     Other Hispanic
     Non-Hispanic White
     Non-Hispanic Black
     Other/Multiracial
IPR
     0<2
     2<3
     ≥3
Insurance
     No Insurance Coverage
     Covered by Insurance
Education
     Less than High School
     High School
     Some College/Associates
     College or Above
Partner
      Partnered
      Not Partnered
Children
      ≥1 Child
      No Children
