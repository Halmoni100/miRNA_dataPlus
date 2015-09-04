# Load the following...
#	p_vals
load("Data_in/saved_p_vals.r")

# get # cols
n <- ncol(p_vals)

# compute false discovery rates (less conservative method than the bonferroni correction)
fdr_significant_miRNAs <- list()
# compute FDR p-values, order them in data frame
fdr_adjust <- function(test_num) {
	p_val_vec <- p_vals[, test_num]
	adjusted_p_val_vec <- p.adjust(p_val_vec, method = "fdr")
	significant_mat <- matrix(, nrow=0, ncol=2)
	for (i in 1:length(adjusted_p_val_vec)) {
		val <- adjusted_p_val_vec[i]
		entry <- c(i, val)
		significant_mat <- rbind(significant_mat, entry)
	}
	significant <- as.data.frame(significant_mat)
	colnames(significant) <- c("index", "p_val")
	significant_ordered <- significant[order(significant$p_val), ]
	return(significant_ordered)
}

# perform function for each column
for (i in 1:7) {
	fdr_significant_miRNAs[[i]] <- fdr_adjust(i)
}

head(fdr_significant_miRNAs[[i]]$p_val)
# extract data frame out of the list
# get save directory

for (i in 1:7) {
	new_frame <- fdr_significant_miRNAs[[i]]
	adjusted_fdr_pvals <- new_frame$p_val
	plot_name <- paste("Test_num_", i, sep="")
	dir_name <- paste("Data_out/", plot_name, ".jpeg", sep="")
	jpeg(filename=dir_name)
	hist(adjusted_fdr_pvals, main = plot_name)
	dev.off()
	
}



