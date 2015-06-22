# load normalized data
# loading quantile_norm_data
load("R_Data/saved_quantile_norm_data")

# subset viral, bacterial, baseline, asymptomatic/symptomatic miRNA expression
allviral <- quantile_norm_data[,1:21]
baseline <- quantile_norm_data[,22:42]
bacterial <- quantile_norm_data[,43:52]
viral_symptomatic <- quantile_norm_data[,c(1,2,5,9,11,13,15,16,17,18,19,20,21)]
viral_asymptomatic <- quantile_norm_data[,c(3,4,6,7,8,10,12,14)]
baseline_symptomatic <- quantile_norm_data[,c(22,23,24,26,27,28,29,31,33,34,37,41,42)]
baseline_asymptomatic <- quantile_norm_data[,c(25,30,32,35,36,38,39,40)]


# t-test function
do_t_test <- function(s1, s2, is_paired) {
	result <- t.test(s1, s2, alternative="two.sided", paired=is_paired)
	return(result$p.value)
}

# make an output matrix for the pvalues of all the tests
p_vals <- matrix(, nrow=nrow(quantile_norm_data), ncol=11)

# conducting a Welch Two Sample t-test on every variable (not assuming equal standard deviation) using a for loop
for (k in 1:nrow(quantile_norm_data)) {
	output_vector <- vector(length=11)
	output_vector[1] <- do_t_test(viral_symptomatic[k,], baseline_symptomatic[k,], TRUE)
	output_vector[2] <- do_t_test(viral_asymptomatic[k,], baseline_asymptomatic[k,], TRUE)
	output_vector[3] <- do_t_test(viral_symptomatic[k,], viral_asymptomatic[k,], FALSE)
	output_vector[4] <- do_t_test(viral_symptomatic[k,], bacterial[k,], FALSE)
	output_vector[5] <- do_t_test(baseline_symptomatic[k,], baseline_asymptomatic[k,], FALSE)
	output_vector[6] <- do_t_test(bacterial[k,], baseline[k,], FALSE)
	p_vals[k,] <- output_vector
}

# save p_vals matrix
save(p_vals, file="R_Data_temp/saved_p_vals")