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
# set up a vector for each test(column)
fdr_vector_test1 <- p_vals[,1]
fdr_vector_test2 <- c(p_vals[,2])
fdr_vector_test3 <- c(p_vals[,3])
fdr_vector_test4 <- c(p_vals[,4])
fdr_vector_test5 <- c(p_vals[,5])
fdr_vector_test6 <- c(p_vals[,6])
fdr_vector_test7 <- c(p_vals[,7])
fdr_vector_test8 <- c(p_vals[,8])
fdr_vector_test9 <- c(p_vals[,9])
fdr_vector_test10 <- c(p_vals[,10])
fdr_vector_test11 <- c(p_vals[,11])

# Run fdr_adjustment on each vector
fdr_adjustment1 <- p.adjust(fdr_vector_test1, method = "fdr")
fdr_adjustment2 <- p.adjust(fdr_vector_test2, method = "fdr")
fdr_adjustment3 <- p.adjust(fdr_vector_test3, method = "fdr")
fdr_adjustment4 <- p.adjust(fdr_vector_test4, method = "fdr")
fdr_adjustment5 <- p.adjust(fdr_vector_test5, method = "fdr")
fdr_adjustment6 <- p.adjust(fdr_vector_test6, method = "fdr")
fdr_adjustment7 <- p.adjust(fdr_vector_test7, method = "fdr")
fdr_adjustment8 <- p.adjust(fdr_vector_test8, method = "fdr")
fdr_adjustment9 <- p.adjust(fdr_vector_test9, method = "fdr")
fdr_adjustment10 <- p.adjust(fdr_vector_test10, method = "fdr")
fdr_adjustment11 <- p.adjust(fdr_vector_test11, method = "fdr")

# combine the adjustment vectors and create a new pvalue matrix
fdr_combined <- c(fdr_adjustment1, fdr_adjustment2, fdr_adjustment3, fdr_adjustment4, fdr_adjustment5, fdr_adjustment6, fdr_adjustment7, fdr_adjustment8, fdr_adjustment9, fdr_adjustment10, fdr_adjustment11)
fdr_matrix <- matrix(fdr_combined, nrow=333, ncol=11)

#assign all significant p-values as TRUE after FDR
significant_fdr_p_vals <- fdr_matrix <= .05
