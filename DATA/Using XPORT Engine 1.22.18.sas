/* To access the xpt file for the questionnaire data. I found it on the sas help site. */
libname sasfile '/folders/myfolders/NHANES/DATA';
libname xptfile xport '/folders/myfolders/NHANES/TEMP/MCQ_H.XPT' access=readonly;
proc copy inlib=xptfile outlib=sasfile;
run;



