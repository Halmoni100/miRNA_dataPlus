# wilcoxin tests 
# load processed_data...


# subset viral, bacterial, baseline, asymptomatic/symptomatic miRNA expression
allviral <- processed_data[,1:21]
baseline <- processed_data[,22:42]
bacterial <- processed_data[,43:52]
viral_symptomatic <- processed_data[,c(1,2,5,9,11,13,15,16,17,18,19,20,21)]
viral_asymptomatic <- processed_data[,c(3,4,6,7,8,10,12,14)]
combined_bacterial_baseline <- processed_data[,22:52]
combined_bacterial_allviral <- processed_data[,c(1:21,43:52)]
combined_baseline_allviral <- processed_data[,1:42]


# wilcoxon function
do_wilcoxon <- function(s1, s2, is_paired) {
	result <- wilcox.test(s1, s2, alternative="two.sided")
	return(result$p.value)
}


# make an output matrix for the pvalues of all the tests
wp_vals <- matrix(, nrow=nrow(processed_data), ncol=11)


# conducting a wilcoxon test using a for loop
for (k in 1:nrow(processed_data)) {
	woutput_vector <- vector(length=11)
	woutput_vector[1] <- do_wilcoxon(allviral[k,], bacterial[k,])
	woutput_vector[2] <- do_wilcoxon(allviral[k,], baseline[k,])
	woutput_vector[3] <- do_wilcoxon(viral_symptomatic[k,], viral_asymptomatic[k,])
	woutput_vector[4] <- do_wilcoxon(bacterial[k,], baseline[k,])
	woutput_vector[5] <- do_wilcoxon(bacterial[k,], viral_symptomatic[k,])
	woutput_vector[6] <- do_wilcoxon(bacterial[k,], viral_asymptomatic[k,])
	woutput_vector[7] <- do_wilcoxon(baseline[k,], viral_symptomatic[k,])
	woutput_vector[8] <- do_wilcoxon(baseline[k,], viral_asymptomatic[k,])
	woutput_vector[9] <- do_wilcoxon(combined_bacterial_baseline[k,], allviral[k,])
	woutput_vector[10] <- do_wilcoxon(combined_bacterial_allviral[k,], baseline[k,])
	woutput_vector[11] <- do_wilcoxon(combined_baseline_allviral[k,], bacterial[k,])
	wp_vals[k,] <- woutput_vector
}


# save wp_vals matrix
save(wp_vals, file="R_Data_temp/saved_wp_vals")