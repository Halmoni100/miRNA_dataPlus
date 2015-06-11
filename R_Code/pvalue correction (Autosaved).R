
# compute Bonferroni p-values (currently not using)
b_vector <- c(p_vals)
b_adjustment <- p.adjust(p_vals, method = "bonferroni")
b_matrix <- matrix(b_adjustment, nrow=333, ncol=11)


# MY CODE FOR BONFERRONI
# new threshold (Ask about)
b_null <- .05/11
# assign all signifiant p-values as TRUE
significant_p_vals <- p_vals <= b_null




# compute false discovery rates (less conservative method than the bonferroni correction)
fdr_vector <- c(p_vals)
fdr_adjustment <- p.adjust(p_vals, method = "fdr")
fdr_matrix <- matrix(fdr_adjustment, nrow=333, ncol=11)


#another method for FDR
compute.FDR(p_vals, q)


# MY CODE FOR FDR
fdr_null <- (11*0.05)/2
