
# compute Bonferroni p-values
# set up a vector for each test(column)
b_vector_test1 <- c(p_vals[,1])
b_vector_test2 <- c(p_vals[,2])
b_vector_test3 <- c(p_vals[,3])
b_vector_test4 <- c(p_vals[,4])
b_vector_test5 <- c(p_vals[,5])
b_vector_test6 <- c(p_vals[,6])
b_vector_test7 <- c(p_vals[,7])


# run the bonferroni adjustment code on each vector
b_adjustment1 <- p.adjust(b_vector_test1, method = "bonferroni")
b_adjustment2 <- p.adjust(b_vector_test2, method = "bonferroni")
b_adjustment3 <- p.adjust(b_vector_test3, method = "bonferroni")
b_adjustment4 <- p.adjust(b_vector_test4, method = "bonferroni")
b_adjustment5 <- p.adjust(b_vector_test5, method = "bonferroni")
b_adjustment6 <- p.adjust(b_vector_test6, method = "bonferroni")
b_adjustment7 <- p.adjust(b_vector_test7, method = "bonferroni")


# combine the vector and put it back into a matrix
b_combined <- c(b_adjustment1, b_adjustment2, b_adjustment3, b_adjustment4, b_adjustment5, b_adjustment6, b_adjustment7)
b_matrix <- matrix(b_combined, nrow=333, ncol=7)

# assign all signifiant p-values as TRUE after Bonferroni
significant_b_p_vals <- b_matrix <= .05

# pulling out significant miRNAs expressed
# create a function to choose only the TRUE values (significant pvalues)
takingout <- function(significant_b_p_vals) {
	takeout <- which(significant_b_p_vals == TRUE)
	return(takeout)
}

# use the applyg function to create a list of significant miRNAs
list_significant_miRNA <- apply(significant_b_p_vals, 2, takingout)








#EXTRA
# pulling out significant miRNAs expressed
# create a function to choose only the TRUE values (significant pvalues)
takingout <- function(b_matrix) {
	takeout <- which(b_matrix <= .05)
	takeout_p_vals <- b_matrix[takeout]
	sorted_vals <- sort(takeout_p_vals, decreasing=FALSE)
	return(sorted_vals)
}
# use the apply function to create a list of significant miRNAs
list_significant_miRNA <- apply(b_matrix, 2, takingout)








# compute false discovery rates (less conservative method than the bonferroni correction)
# set up a vector for each test(column)
fdr_vector_test1 <- c(p_vals[,1])
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
