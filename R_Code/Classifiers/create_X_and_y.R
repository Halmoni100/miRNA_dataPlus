create_X_and_y <- function(data, factors, factor_names, factor_vec) {
# Create X and y based on data and factors
# Make sure data rows are labeled with names
# data is mxn matrix, m describes miRNAs, n describes samples
# factors is list that describes the two groups to specify in y
# factor_names describe the name to assign the two groups of factors
# - must be factor vector where first level is failure
# factor_vec provides labels

	# transpose data to mxn matrix where m describes samples, n describes miRNAs
	data_t <- t(data)
	m <- nrow(data_t)
	n <- ncol(data_t)
	
	assign_truth_table <- function(class_list, factor_vec) {
		# initialize truth_table to all false
		num_samples = length(factor_vec)
		truth_table <- vector(mode="logical", length=num_samples)
		# do logical or to make all considered samples true
		for (class in class_list) {
			truth_vals <- factor_vec == class
			truth_table <- truth_table | truth_vals
		}
		return(truth_table)
	}

	truth_table_1 <- assign_truth_table(factors[[1]], factor_vec)
	truth_table_2 <- assign_truth_table(factors[[2]], factor_vec)
	
	# extract only samples specified in factors
	truth_table_all <- truth_table_1 | truth_table_2
	X <- data_t[truth_table_all, ]
	
	# create factor name vector
	y <- vector(mode="character", length=nrow(X))
	# j is current number to fill in y
	j <- 1
	for (i in 1:m) {
		if (truth_table_1[i]) {
			y[j] <- factor_names[1]
			j <- j + 1
		}
		else if (truth_table_2[i]) {
			y[j] <- factor_names[2]
			j <- j + 1
		}
	}
	if (j != nrow(X) + 1) {
		stop("Error: Not all of y covered")
	}
	
	# return X and y
	out <- list(X, y)
	return(out)
}