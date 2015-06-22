# Load the following...
# 	quantile_norm_data
#	sample_factors

# For reference:
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline Symptomatic - bl_s
# Basline Asymptomatic - bl_as
# Bacteria - bc

# subset viral, bacterial, baseline, asymptomatic/symptomatic miRNA expression
v_s_bool_vec <- sample_factors == "v_s"
v_as_bool_vec <- sample_factors == "v_as"
bl_s_bool_vec <- sample_factors == "bl_s"
bl_as_bool_vec <- sample_factors == "bl_as"
bc_bool_vec <- sample_factors == "bc"

viral_symptomatic <- quantile_norm_data[, v_s_bool_vec]
viral_asymptomatic <- quantile_norm_data[, v_as_bool_vec]
baseline_symptomatic <- quantile_norm_data[, bl_s_bool_vec]
baseline_asymptomatic <- quantile_norm_data[, bl_as_bool_vec]
bacterial <- quantile_norm_data[, bc_bool_vec]
allviral <- quantile_norm_data[, v_s_bool_vec | v_as_bool_vec]
baseline <- quantile_norm_data[, bl_s_bool_vec | bl_as_bool_vec]
allviral_and_bacterial <- quantile_norm_data[, v_s_bool_vec | v_as_bool_vec | bc_bool_vec]

v_s_ordered <- quantile_norm_data[,c(1,2,5,9,11,13,15,16,17,18,19,20,21)]
v_as_ordered <- quantile_norm_data[,c(3,4,6,7,8,10,12,14)]
b_s_ordered <- quantile_norm_data[,c(22,41,24,31,27,42,29,26,28,23,37,33,34)]
b_as_ordered <- quantile_norm_data[,c(40,25,39,38,36,30,35,32)]

# t-test function
do_t_test <- function(s1, s2, is_paired) {
	result <- t.test(s1, s2, alternative="two.sided", paired=is_paired)
	return(result$p.value)
}

# make an output matrix for the pvalues of all the tests
p_vals <- matrix(, nrow=nrow(quantile_norm_data), ncol=7)

# conducting a Welch Two Sample t-test on every variable (not assuming equal standard deviation) using a for loop
for (k in 1:nrow(quantile_norm_data)) {
	output_vector <- vector(length=7)
	output_vector[1] <- do_t_test(v_s_ordered[k,], b_s_ordered[k,], TRUE)
	output_vector[2] <- do_t_test(v_as_ordered[k,], b_as_ordered[k,], TRUE)
	output_vector[3] <- do_t_test(viral_symptomatic[k,], viral_asymptomatic[k,], FALSE)
	output_vector[4] <- do_t_test(viral_symptomatic[k,], bacterial[k,], FALSE)
	output_vector[5] <- do_t_test(baseline_symptomatic[k,], baseline_asymptomatic[k,], FALSE)
	output_vector[6] <- do_t_test(bacterial[k,], baseline[k,], FALSE)
	output_vector[7] <- do_t_test(allviral_and_bacterial[k,], baseline[k,], FALSE)
	p_vals[k,] <- output_vector
}

# save p_vals matrix
save(p_vals, file="Data_out/saved_p_vals.r")