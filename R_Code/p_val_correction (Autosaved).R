# Load the following...
#	p_vals

# create list of data frames
significant_miRNAs <- list()
# compute Bonferroni p-values, order them in a data frame
bonferroni_adjust <- function(v) {
	adjusted_v <- p.adjust(v, method = "bonferroni")
	significant_mat <- matrix(, nrow=0, ncol=2)
	for (i in 1:length(adjusted_v)) {
		val <- adjusted_v[i]
		if (val <= .05) {
			entry <- c(i, val)
			significant_mat <- rbind(significant_mat, entry)
		}
	}
	significant <- as.data.frame(significant_mat)
	colnames(significant) <- c("index", "p_val")
	significant_ordered <- significant[order(significant$p_val), ]
	return(significant_ordered)
}
significant_miRNA_dfs <- apply(p_vals, 2, bonferroni_adjust)




# compute false discovery rates (less conservative method than the bonferroni correction)
fdr_significant_miRNAs <- list()
# compute FDR p-values, order them in data frame
fdr_adjust <- function(v) {
	adjusted_v <- p.adjust(v, method = "fdr")
	significant_mat <- matrix(, nrow=0, ncol=2)
	for (i in 1:length(adjusted_v)) {
		val <- adjusted_v[i]
		if (val <= .05) {
			entry <- c(i, val)
			significant_mat <- rbind(significant_mat, entry)
		}
	}
	significant <- as.data.frame(significant_mat)
	colnames(significant) <- c("index", "p_val")
	significant_ordered <- significant[order(significant$p_val), ]
	return(significant_ordered)
}
significant_miRNA_dfs <- apply(p_vals, 2, fdr_adjust)
head(significant_miRNA_dfs[[i]]$p_val)
# extract data frame out of the list
for (i in 1:7) {
	new_frame <- significant_miRNA_dfs[[i]]
	p_vals <- new_frame$p_val
	quartz()
	plot_name <- paste("Test #", i)
	hist(p_vals, main = plot_name)
}



