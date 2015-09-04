create_df_sub = function(df, factor_vec, factors, factor_names) {
# Create df_sub based on data and factors
# df is mxn data frame, m describes samples, n describes miRNAs
# factors is list that describes the two groups to specify based on factor_vec
# factor_names describe the name to assign the two groups of factors
# - must be vector where first element is failure (0), other element is success (1)
# factor_vec provides labels
	
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
  df_sub <- df[truth_table_all, ]
	
	# create factor name vector
	y = vector(mode="character", length=nrow(df_sub))
	# j is current number to fill in y
	j = 1
	for (i in 1:nrow(df)) {
		if (truth_table_1[i]) {
			y[j] = factor_names[1]
			j = j + 1
		}
		else if (truth_table_2[i]) {
			y[j] = factor_names[2]
			j = j + 1
		}
	}
	if (j != nrow(df_sub) + 1) {
		stop("Error: Not all of y covered")
	}
	
	y = factor(y, order=TRUE, levels=factor_names)
	
	# incorporate y into df_sub
	df_sub = cbind.data.frame(df_sub, y)
	
	# return df_sub
	return(df_sub)
}