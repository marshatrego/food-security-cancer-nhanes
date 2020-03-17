Title color=cadetblue '2 Year (2013-14) Unweighted Frequencies';
Title2 color=coral 'All people with 1 type of cancer >19yrs';
proc freq data=work.medq_fsq;
	tables 
			cancertype*time_diag1
			time_diag1*fi_bin
			cancertype*time_diag1*fi_bin
			time_diag1*fsdad
			cancertype*time_diag1*fi_bin
			time_diag2*fi_bin
			cancertype*time_diag2*fi_bin
			time_diag2*fsdad
			cancertype*time_diag2*fsdad
			
			cancertype*fi_bin
			cancertype*fsdad
			
			age*cancertype*fi_bin
			age*cancertype*fsdad
			
			
			
			digestcanc*fi_bin
			digestcanc*fsdad
			gender*mrepcanc*fi_bin
			gender*mrepcanc*fsdad
			gender*frepcanc*fi_bin
			gender*frepcanc*fsdad
			gender*breastcanc*fi_bin
			gender*breastcanc*fsdad
			respcanc*fi_bin
			respcanc*fsdad
			urincanc*fi_bin
			urincanc*fsdad
			othercanc*fi_bin
			othercanc*fsdad
			skincanc*fi_bin
			skincanc*fsdad
			
			gender*fi_bin
			gender*fsdad
			age*fi_bin
			age*fsdad
			ethnicity*fi_bin
			ethnicity*fsdad
			incomegroup*fi_bin
			incomegroup*fsdad
			income*fi_bin
			income*fsdad
			Insurance*fi_bin
			Insurance*fsdad
			education*fi_bin
			education*fsdad/ chisq;
			
run;
