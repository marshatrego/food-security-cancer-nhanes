%let path=/folders/myfolders/NHANES; 
libname Nhanes "&path";				
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

					/* To access the xpt file for the health insurance 
					data for 2013-2014. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/HIQ_H.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;
					/* To access the xpt file for the health status 
					data for 2013-2014. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/HSQ_H.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;
					/* To access the xpt file for the consumer behavior 
					data for 2013-2014. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/CBQ_H.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;

					/* To access the xpt file for the consumer behavior 
					data for 2013-2014. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/DBQ_H.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;

		/***************************************************************************/
		/*Doing the same thing as above ^^^^ for 2011-2012 demo, medq, fsq, and hiq*/
		/***************************************************************************/		
			
			
			
				/* To access the xpt file for the med questionnaire 
					data for 2011-2012. I found it on the sas help site. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/MCQ_G.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;
					/* To access the xpt file for the food security  
					data for 2011-2012.*/
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/FSQ_G.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;
					/* To access the xpt file for the demographic 
					data for 2011-2012. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/DEMO_G.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;

					/* To access the xpt file for the health insurance 
					data for 2011-2012. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/HIQ_G.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;
					/* To access the xpt file for the health status 
					data for 2011-2012. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/HSQ_G.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;
					/* To access the xpt file for the consumer behavior 
					data for 2011-2012. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/CBQ_G.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;
					/* To access the xpt file for the consumer behavior 
					data for 2011-2012. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/DBQ_G.XPT' access=readonly;
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
proc sort data=sasfile.hiq_h;
	by seqn;
proc sort data=sasfile.hsq_h;
	by seqn;
proc sort data=sasfile.cbq_h;
	by seqn;
proc sort data=sasfile.dbq_h;
	by seqn;
	
proc sort data=sasfile.mcq_g;
	by seqn;
proc sort data=sasfile.fsq_g;
	by seqn;
proc sort data=sasfile.demo_g;
	by seqn;
proc sort data=sasfile.hiq_g;
	by seqn;
proc sort data=sasfile.hsq_g;
	by seqn;
proc sort data=sasfile.cbq_g;
	by seqn;
proc sort data=sasfile.dbq_g;
	by seqn;
run; 
					
					/*Use the data step to name the new dataset that 
					will contain the merged files.
					Use the merge statement to merge the data
					based on the unique identifier (seqn).*/
data sasfile.medq_fsq_4yr;
	merge   sasfile.fsq_h
			sasfile.mcq_h
			sasfile.demo_h
			sasfile.hiq_h
			sasfile.fsq_g
			sasfile.mcq_g
			sasfile.demo_g
			sasfile.hiq_g
			sasfile.hsq_h
			sasfile.hsq_g
			sasfile.cbq_g
			sasfile.cbq_h
			sasfile.dbq_g
			sasfile.dbq_h;
	by seqn;
run;