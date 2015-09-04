# Load the following...
# sample_factors
# quantile_norm_data

# For reference, factors are
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline - bl
# Bacteria - bc

# Load permtest package
library(permtest)

create_truth_vec_one_vs_all <- function(class) {
	# Assume that group 1 is class in consideration, group 2 is everything else
	truth_vec <- rep.int(2, ncol(quantile_norm_data))
	truth_table <- sample_factors == class
	for (i in 1:length(truth_vec)) {
		if (truth_table[i]) {
			truth_vec[i] <- 1
		}
	}
	return(truth_vec)
}

# Assign 1s and 2s based on group
v_s_vs_all <- create_truth_vec_one_vs_all("v_s")
v_as_vs_all <- create_truth_vec_one_vs_all("v_as")
bl_vs_all <- create_truth_vec_one_vs_all("bl")
bc_vs_all <- create_truth_vec_one_vs_all("bc")

# Assign names for data matrix for input into permtest
column_names <- 1:ncol(quantile_norm_data)
colnames(quantile_norm_data) <- column_names

# Create designmatrices
v_s_dm <- cbind(column_names, v_s_vec)
v_as_dm <- cbind(column_names, v_as_vec)
bl_dm <- cbind(column_names, bl_vec)
bc_dm <- cbind(column_names, bc_vec)

# Do permutation tests
v_s_vs_all <- permtest(quantile_norm_data, v_s_dm, distance="euclid", nperms=100000, designtype="random")
v_as_vs_all <- permtest(quantile_norm_data, v_as_dm, distance="euclid", nperms=100000, designtype="random")
bl_vs_all <- permtest(quantile_norm_data, bl_dm, distance="euclid", nperms=100000, designtype="random")
bc_vs_all <- permtest(quantile_norm_data, bc_dm, distance="euclid", nperms=100000, designtype="random")

# Write out summaries to txt files
write.table(v_s_result, "R_Data_temp/permutation_test_summary/viral_symptomatic.txt", sep="\t", quote=FALSE)
write.table(v_as_result, "R_Data_temp/permutation_test_summary/viral_asymptomatic.txt", sep="\t", quote=FALSE)
write.table(bl_result, "R_Data_temp/permutation_test_summary/baseline.txt", sep="\t", quote=FALSE)
write.table(bc_result, "R_Data_temp/permutation_test_summary/bacteria.txt", sep="\t", quote=FALSE)



