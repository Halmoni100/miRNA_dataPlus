
# compute Bonferroni p-values (currently not using)
badjustment <- p.adjust(p_vals, method = "bonferroni")

# new threshold (Ask about)
new_null <- .05/11

# assign all signifiant p-values as TRUE
significant_p_vals <- p_vals <= new_null




# compute false discovery rates 
fdradjustment <- p.adjust(p_vals, method = "fdr")