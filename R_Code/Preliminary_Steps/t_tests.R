load("R_Data/data_frames.r")
load("R_Data/saved_sample_factors.r")

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

viral_symptomatic <- df[v_s_bool_vec, ]
viral_asymptomatic <- df[v_as_bool_vec, ]
baseline_symptomatic <- df[bl_s_bool_vec, ]
baseline_asymptomatic <- df[bl_as_bool_vec, ]
bacterial <- df[bc_bool_vec, ]
allviral <- df[v_s_bool_vec | v_as_bool_vec, ]
baseline <- df[bl_s_bool_vec | bl_as_bool_vec, ]
allviral_and_bacterial <- df[v_s_bool_vec | v_as_bool_vec | bc_bool_vec, ]

# order samples by index for t-tests (make sure individuals correspond to e/o)
v_s_ordered <- df[c(1,2,5,9,11,13,15,16,17,18,19,20,21), ]
v_as_ordered <- df[c(3,4,6,7,8,10,12,14), ]
b_s_ordered <- df[c(22,41,24,31,27,42,29,26,28,23,37,33,34), ]
b_as_ordered <- df[c(40,25,39,38,36,30,35,32), ]

# t-test function
do_t_test <- function(s1, s2, is_paired) {
	result <- t.test(s1, s2, alternative="two.sided", paired=is_paired)
	out = list()
	out[[1]] <- result$p.value
	out[[2]] <- result$conf.int
	return(out)
}

# make an output matrix for the p values of all the tests
p_vals <- matrix( , nrow=7, ncol=ncol(df))
# make an output matrix for the standard errors of all the p values
conf_ints <- matrix( , nrow=7, ncol=ncol(df))

# conducting a Welch Two Sample t-test on every variable (not assuming equal standard deviation) using a for loop
for (k in 1:ncol(df)) {
	p_val_vec <- vector(length=7)
	conf_int_vec <- vector(length=7)
	result_1 <- do_t_test(v_s_ordered[,k], b_s_ordered[,k], TRUE)
	p_val_vec[1] <- result_1[[1]]
	conf_int_vec[1] <- result_1[[2]]
	result_2 <- do_t_test(v_as_ordered[,k], b_as_ordered[,k], TRUE)
	p_val_vec[2] <- result_2[[1]]
	conf_int_vec[2] <- result_2[[2]]
	result_3 <- do_t_test(viral_symptomatic[,k], viral_asymptomatic[,k], FALSE)
	p_val_vec[3] <- result_3[[1]]
	conf_int_vec[3] <- result_3[[2]]
	result_4 <- do_t_test(viral_symptomatic[,k], bacterial[,k], FALSE)
	p_val_vec[4] <- result_4[[1]]
	conf_int_vec[4] <- result_4[[2]]
	result_5 <- do_t_test(baseline_symptomatic[,k], baseline_asymptomatic[,k], FALSE)
	p_val_vec[5] <- result_5[[1]]
	conf_int_vec[5] <- result_5[[2]]
	result_6 <- do_t_test(bacterial[,k], baseline[,k], FALSE)
	p_val_vec[6] <- result_6[[1]]
	conf_int_vec[6] <- result_6[[2]]
	result_7 <- do_t_test(allviral_and_bacterial[,k], baseline[,k], FALSE)
	p_val_vec[7] <- result_7[[1]]
	conf_int_vec[7] <- result_7[[2]]
	
	p_vals[,k] <- p_val_vec
	conf_ints[,k] <- conf_int_vec
}

# save p_vals matrix
save(p_vals, file="R_Data/saved_p_vals.r")
# save conf_ints matrix
save(conf_ints, file="R_Data/saved_conf_ints_p_vals.r")
