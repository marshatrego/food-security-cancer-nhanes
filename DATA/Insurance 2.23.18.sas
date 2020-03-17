							/*Creates Health Insurance Variable*/
	if hiq031a=14 and hiq031b=15 then Insurance='Private+Medicare';
	else if hiq031a=14 then Insurance='Private';
	else if hiq031b=15 then insurance='Medicare';
	else if hiq031d=17 then Insurance='Medicaid'; 
	else if hiq031e=18 or hiq031f=19 or hiq031g=20 or hiq031h=21 
	or hiq031i=22 or hiq031j=23 then Insurance='Other';
	else Insurance='None';

proc sort data=work.medq_fsq;
	by hiq011 hiq031a hiq031b hiq031c hiq031d hiq031e hiq031f hiq031g hiq031h hiq031i hiq031j;
run;
proc print data=work.medq_fsq;
	var hiq011 hiq031a hiq031b hiq031c hiq031d hiq031e hiq031f hiq031g hiq031h hiq031i hiq031j;
run;
