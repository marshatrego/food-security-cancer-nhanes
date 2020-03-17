proc sort data=work.medq_fsq_4yr_all;
	by indfmpir cancer;
run;
proc surveymeans data=work.medq_fsq_4yr_all;
	stratum sdmvstra;
	cluster sdmvpsu;
	weight wtint4yr;
	
	var indfmpir;
	domain cancer/ diff;
run;