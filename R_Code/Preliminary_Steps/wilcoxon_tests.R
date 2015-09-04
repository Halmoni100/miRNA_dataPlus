# wilcoxin tests 
# load the following...
# data_proc
# sample_factors

# Factors are:
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline Symptomatic - bl_s
# Basline Asymptomatic - bl_as
# Bacteria - bc

# subset viral, bacterial, baseline, asymptomatic/symptomatic miRNA expression
subset_data = function(data, factor_names, factor_vec) {
  subset = data[, match(factor_names, factor_vec)]
}

# subset data to list
# Subsets are:
# 1. All viral
# 2. All baseline
# 3. Bacterial
# 4. Viral symptomatic
# 5. Viral asymptomatic
# 6. Bacterial and all baseline
# 7. Bacterial and all viral
# 8. Baseline and all viral
subsets = vector("list", 8)
subsets[[1]] = subset_data(data_proc, c("v_s", "v_as"), sample_factors)
subsets[[2]] = subset_data(data_proc, c("bl_s", "bl_as"), sample_factors)
subsets[[3]] = subset_data(data_proc, "bc", sample_factors)
subsets[[4]] = subset_data(data_proc, "v_s", sample_factors)
subsets[[5]] = subset_data(data_proc, "v_as", sample_factors)
subsets[[6]] = subset_data(data_proc, c("bc", "bl_s", "bl_as"), sample_factors)
subsets[[7]] = subset_data(data_proc, c("bc", "v_s", "v_as"), sample_factors)
subsets[[8]] = subset_data(data_proc, c("bl_s","bl_as", "v_s", "v_as"), sample_factors)


# wilcoxon function
do_wilcoxon = function(s1, s2, is_paired) {
	result = wilcox.test(s1, s2, alternative="two.sided", paired=is_paired)
	return(result$p.value)
}

# wilcoxon comparisons are:
# 1. All viral vs. bacterial (1, 3)
# 2. All viral vs. all baseline (1, 2)
# 3. Viral symptomatic vs. viral asymptomatic (4, 5)
# 4. All baseline vs. bacterial (2, 3)
# 5. Bacterial vs. viral symptomatic (3, 4)
# 6. Bacterial vs. viral asymptomatic (3, 5)
# 7. All baseline vs. viral symptomatic (2, 4)
# 8. All baseline vs. viral asymptomatic (2, 5)
# 9. All viral vs. bacterial and all baseline (1, 6) 
# 10. All baseline vs. bacterial and all viral (2, 7)
# 11. Bacterial vs. all baseline and all viral (3, 8)
comparisons = list(list(1,3,T), list(1,2,F), list(4,5,T), list(2,3,T), list(3,4,T), 
                   list(3,5,T), list(2,4,T), list(2,5,T), list(1,6,T), list(2,7,T),
                   list(3,8,T))
num_comparisons = length(comparisons)
# make an output matrix for the pvalues of all the tests
wilcoxon_p_vals = matrix(, nrow=nrow(data_proc), ncol=num_comparisons)

# conduct wilcoxon comparisons for each miRNA
for (i in 1:nrow(data_proc)) {
	output_vector = vector(length=11)
	for (j in 1:num_comparisons) {
	  comparison = comparisons[j]
	  subset_1 = subsets[[ comparison[[1]] ]]
	  subset_2 = subsets[[ comparison[[2]] ]]
	  is_paried = comparison[[3]]
	  output_vector[j] = do_wilcoxon(subset_1, subset_2, is_paired)
	}
	woutput_vector[1] = do_wilcoxon(allviral[k,], bacterial[k,], TRUE)
	wilcoxon_p_vals[i,] = output_vector
}

# save wilcoxon_p_vals matrix
save(wilcoxon_p_vals, file="Data_out/saved_wilcoxon_p_vals.r")

# run a correlation test between p_vals and wp_vals to compare the t-test and wilcoxon test results (convert to vectors first)
vector_ttest_matrix = c(p_vals)
vector_wilcox_matrix = c(wp_vals)
correlation_output = cor.test(vector_ttest_matrix, vector_wilcox_matrix)

# plot the relationship
qqplot(vector_ttest_matrix, vector_wilcox_matrix, plot.it=TRUE)



