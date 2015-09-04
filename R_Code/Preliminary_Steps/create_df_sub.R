create_df_sub = function(df, factor_vec, factors, factor_names) {
# Create df_sub based on data and factors
# df is mxn data frame, m describes samples, n describes miRNAs
# factors is list that describes the two groups to specify based on factor_vec
# factor_names describe the name to assign the two groups of factors
# - must be vector where first element is failure (0), other element is success (1)
# factor_vec provides labels
	
	# extract only samples specified in factors list
	factor_1_bool_vec = factor_vec == factors[[1]];
	factor_2_bool_vec = factor_vec == factors[[2]];
	df_sub = df[factor_1_bool_vec | factor_2_bool_vec, ];
	
	
	# create factor name vector
	y = vector(mode="character", length=nrow(df_sub))
	# j is current number to fill in y
	j = 1
	for (i in 1:nrow(df)) {
		if (factor_1_bool_vec[i]) {
			y[j] = factor_names[1]
			j = j + 1
		}
		else if (factor_2_bool_vec[i]) {
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