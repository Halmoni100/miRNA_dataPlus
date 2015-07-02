# Load the following...
#	p_vals
#	conf_ints
load("Data_in/saved_p_vals.r")
load("Data_in/saved_conf_ints_p_vals.r")

# create list of data frames
significant_miRNAs <- list()
# compute Bonferroni p-values
# returns data frame of index, p value, and confidence interval
bonferroni_adjust <- function(test_num) {
	p_val_vec <- p_vals[, test_num]
	adjusted_p_val_vec <- p.adjust(p_val_vec, method = "bonferroni")
	significant_mat <- matrix(, nrow=0, ncol=3)
	for (i in 1:length(adjusted_p_val_vec)) {
		val <- adjusted_p_val_vec[i]
		if (val <= .05) {
			conf_int <- conf_ints[i, test_num]
			entry <- c(i, val, conf_int)
			significant_mat <- rbind(significant_mat, entry)
		}
	}
	significant <- as.data.frame(significant_mat)
	colnames(significant) <- c("index", "p_val", "conf_int")
	significant_ordered <- significant[order(significant$p_val), ]
	return(significant_ordered)
}
# get # cols
n <- ncol(p_vals)
# perform function for each column
# save to txt file
file_names <- 
for (i in 1:n) {
	significant_miRNAs[[i]] <- bonferroni_adjust(i)
	
}


# compute false discovery rates (less conservative method than the bonferroni correction)
fdr_significant_miRNAs <- list()
# compute FDR p-values, order them in data frame
fdr_adjust <- function(test_num) {
	p_val_vec <- p_vals[, test_num]
	adjusted_p_val_vec <- p.adjust(p_val_vec, method = "fdr")
	significant_mat <- matrix(, nrow=0, ncol=3)
	for (i in 1:length(adjusted_p_val_vec)) {
		val <- adjusted_p_val_vec[i]
		if (val <= .05) {
			conf_int <- conf_ints[i, test_num]
			entry <- c(i, val, conf_int)
			significant_mat <- rbind(significant_mat, entry)
		}
	}
	significant <- as.data.frame(significant_mat)
	colnames(significant) <- c("index", "p_val", "conf_int")
	significant_ordered <- significant[order(significant$p_val), ]
	return(significant_ordered)
}

# perform function for each column
for (i in 1:7) {
	fdr_significant_miRNAs[[i]] <- fdr_adjust(i)
}

head(fdr_significant_miRNAs[[i]]$p_val)
# extract data frame out of the list
for (i in 1:7) {
	new_frame <- fdr_significant_miRNAs[[i]]
	if (nrow(new_frame) > 0) {
		adjusted_fdr_pvals <- new_frame$p_val
		quartz()
		plot_name <- paste("Test #", i)
		hist(adjusted_fdr_pvals, main = plot_name)
	}
}



