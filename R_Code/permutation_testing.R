# Load the following...
# sample_factors
# quantile_norm_data

# For reference, factors are
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline - bl
# Bacteria - bc


create_truth_vec <- function(class) {
	# Assume that group 1 is class in consideration, group 2 is everything else
	truth_vec <- rep.int(2, nrow(quantile_norm_data))
	truth_table <- sample_factors == class
	for (i in 1:length(truth_vec)) {
		if (truth_table[i]) {
			truth_vec[i] <- 1
		}
	}
}

v_s_truth_vec <- create_truth_vec("v_s")
v_as_truth_vec <- create_truth_vec("v_as")
bl_truth_vec <- create_truth_vec("bl")
bc_truth_vec <- create_truth_vec("bc")





