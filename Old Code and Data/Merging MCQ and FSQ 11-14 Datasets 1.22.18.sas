		/* To access the xpt file for the med questionnaire 
		data for 2013-2014. I found it on the sas help site. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/MCQ_H.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;

		/* To access the xpt file for the med questionnaire 
		data for 2011-2012.*/
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/MCQ_G.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;

		/* To access the xpt file for the food security  
		data for 2013-2014.*/
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/FSQ_H.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;

		/* To access the xpt file for the food security  
		data for 2011-2012.*/
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/FSQ_G.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;

		/*use the data step to create a dataset
		for your 4 years of med questionnaire data.
		The dataset is now called sasfile.mcq_4yr 
		and is saved in my permanent nhanes data library.
		Contains 19,134 observations*/
data sasfile.mcq_4yr;
	set sasfile.mcq_g (keep=seqn mcq220 mcq240e)
	    sasfile.mcq_h (keep=seqn mcq220 mcq240e);
run; 

		/*use the data step to create a dataset
		for your 4 years of med questionnaire data.
		The dataset is now called sasfile.mcq_4yr 
		and is saved in my permanent nhanes data library.
		Contains 19,134 observations*/
data sasfile.fsq_4yr;
	set sasfile.fsq_g (keep=seqn FSD071)
	    sasfile.fsq_h (keep=seqn FSD071);
run; 


		/*First step in merging data is to sort each of the 
		data files by sequence number.*/
proc sort data=sasfile.mcq_4yr;
	by seqn;
proc sort data=sasfile.fsq_4yr;
	by seqn;
run; 

		/*Use the data step to name the new dataset that 
		will contain the merged files.
		Use the merge statement to merge the data
		based on the unique identifier (seqn).*/
data sasfile.medq_fsq;
	merge sasfile.fsq_4yr
			sasfile.mcq_4yr;
	by seqn;
run;
proc contents data=sasfile.medq_fsq;
run;

		/***************************
		 * Done with merging above.
		 * Now looking into the data 
		 * with proc print.
		 *************************/

proc print data=sasfile.medq_fsq split=' ';
	var mcq220 seqn MCQ240E FSD071; 
	*where 1<mcq220<3;
	label mcq220='Told had cancer' 
			seqn='Sequence Number' 
			mcq240e='Age when Breast Cancer Diagnosed'
			FSD071='Hungry Didnt Eat';
	sum mcq220 mcq240e;
	*where 1<=mcq240e<=100;
run;

		/*proc means gives you descriptive statistics. 
		where 1<=mcq240e<=100 eliminates the . and the 
		99999 from the calculation*/
/*proc means data=sasfile.mcq_h; 
	var mcq240e; 
	where 1<=mcq240e<=100;
run;*/