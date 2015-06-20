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

# Assign names for data matrix for input into permtest
column_names <- 1:ncol(quantile_norm_data)
colnames(quantile_norm_data) <- column_names

assign_truth_table <- function(class_list, num_samples) {
	# initialize truth_table to all false
	truth_table <- vector(mode="logical", length=num_samples)
	# do logical or to make all considered samples true
	for (class in class_list) {
		truth_vals <- sample_factors == class
		truth_table <- truth_table | truth_vals
	}
	return(truth_table)
}

create_two_grps <- function(class_list_1, class_list_2) {
# The output is a list... 
# 1. list of 1s and 2s for grp assignment
# 2. column numbers used
# 3. truth table for samples used
	num_samples <- ncol(quantile_norm_data)
	truth_table_1 <- assign_truth_table(class_list_1, num_samples)
	truth_table_2 <- assign_truth_table(class_list_2, num_samples)
	# get truth table for samples used in classes 1 & 2
	samples_used <- truth_table_1 | truth_table_2
	# find number of samples for both classes
	num_true_1 <- length(which(truth_table_1))
	num_true_2 <- length(which(truth_table_2))
	num_true <- num_true_1 + num_true_2
	# create vector of group category per sample
	grp_vec <- vector(length=num_true)
	# assign column names for design matrix
	col_name_vec <- vector(length=num_true)
	# j is current number to fill in truth_vec
	j <- 1
	for (i in 1:num_samples) {
		if (truth_table_1[i]) {
			grp_vec[j] <- 1
			col_name_vec[j] <- i
			j <- j + 1
		}
		else if (truth_table_2[i]) {
			grp_vec[j] <- 2
			col_name_vec[j] <- i
			j <- j + 1
		}
	}
	if (j != num_true + 1) {
		stop("Error: Not all of truth_vec covered")
	}
	
	out <- list()
	out[[1]] <- grp_vec
	out[[2]] <- col_name_vec
	out[[3]] <- samples_used
	return(out)
}

perform_permtest <- function(class_list_1, class_list_2) {
	out_two_grps <- create_two_grps(class_list_1, class_list_2)
	samples_used <- out_two_grps[[3]]
	# assign data matrix based on subset used for classes 1 & 2
	data_matrix <- quantile_norm_data[,samples_used]
	# create designmatrix
	dm <- cbind(out_two_grps[[2]], out_two_grps[[1]])
	# do permtest
	result <- permtest(data_matrix, dm, distance="euclid", nperms=100000, designtype="random")
	return(result)
}

# Do permutation tests
bc_vs_v_result <- perform_permtest("bc", c("v_s", "v_as"))
bc_vs_bl_result <- perform_permtest("bc", "bl")
v_vs_all_result <- perform_permtest(c("v_s", "v_as"), c("bc", "bl"))
v_vs_bl_result <- perform_permtest(c("v_s", "v_as"), c("bl"))

# Write out summaries to txt files
write.table(bc_vs_v_result, "Data_out/bacterial_vs_viral.txt", sep="\t", quote=FALSE)
write.table(bc_vs_bl_result, "Data_out/bacterial_vs_healthy.txt", sep="\t", quote=FALSE)
write.table(v_vs_all_result, "Data_out/viral_vs_all.txt", sep="\t", quote=FALSE)
write.table(v_vs_bl_result, "Data_out/viral_vs_healthy.txt", sep="\t", quote=FALSE)



