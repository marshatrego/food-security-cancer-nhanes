					/* To access the xpt file for the med questionnaire 
					data for 2013-2014. I found it on the sas help site. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/MCQ_H.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;
					/* To access the xpt file for the food security  
					data for 2013-2014.*/
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/FSQ_H.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;
					/* To access the xpt file for the demographic 
					data for 2013-2014. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/DEMO_H.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;

	
*proc contents data=sasfile.demo_h;
*run;

   /*********************************************************************\
   /*********************************************************************\
					/*First step in merging data is to sort each of the 
					data files by sequence number.*/
proc sort data=sasfile.mcq_h;
	by seqn;
proc sort data=sasfile.fsq_h;
	by seqn;
proc sort data=sasfile.demo_h;
	by seqn;
run; 
					/*Use the data step to name the new dataset that 
					will contain the merged files.
					Use the merge statement to merge the data
					based on the unique identifier (seqn).*/
data sasfile.medq_fsq;
	merge sasfile.fsq_h
			sasfile.mcq_h
			sasfile.demo_h;
	by seqn;
run;



					/***************************************************************
					 * The Following creates a new variable for digestive system cancer
					 * of the colon, esophagus, gallbladder, liver, pancreas, rectum, 
					 * and stomach. DigestCanc=Yes/No. A frequency table is created 
					 * for DigestCancXFSDAD.  
					 ****************************************************************/
data work.medq_fsq;
	set sasfile.medq_fsq; 
	*where mcq220=1;
	
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
run;
proc sort data=work.medq_fsq;
	by mcq220;
run;
		
*proc print data=work.medq_fsq;
*	var mcq220 mcq230a mcq230b mcq230c DigestCanc fsdad;
*run; 
		

*proc surveyfreq data=work.medq_fsq; 
*	tables DigestCanc*fsdad;
*	stratum sdmvstra;
*	cluster sdmvpsu;
*	weight wtint2yr;
*run;

proc print data=work.medq_fsq;
	var mcq220;
run;

proc surveyfreq data=sasfile.medq_fsq; 
	tables mcq220*fsdad;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint2yr;
run; 


*proc contents data=sasfile.medq_fsq;
*run;

  /*********************************************************************\
					/***************************
					 * Done with merging above.
					 * Now looking into the data 
					 * with proc print.
					 *************************/





	/*
proc print data=sasfile.medq_fsq split=' ' noobs;
	var seqn mcq220 FSDAD; 
	*where mcq220<2;
	label seqn='Sequence Number'
		  mcq220='Told had cancer'  
		  FSDAD='Level of Food Security';
	sum mcq220 mcq240e;
	*where 1<=mcq240e<=100;	
run;
	*/
	
*proc surveyfreq data=sasfile.medq_fsq; 
*	tables mcq220*fsdad;
*	stratum sdmvstra;
*	cluster sdmvpsu;
*	weight wtint2yr;
*run; 

	/*
proc freq data=sasfile.medq_fsq; 
	tables mcq220*fsdad/norow nocol;
run;
	/*

		/*proc means gives you descriptive statistics. 
		where 1<=mcq240e<=100 eliminates the . and the 
		99999 from the calculation*/
/*proc means data=sasfile.mcq_h; 
	var mcq240e; 
	where 1<=mcq240e<=100;
run;*/