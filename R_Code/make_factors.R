# Factors are:
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline - bl
# Bacteria - bc

# Write factors for viral symptomatic & asymptomatic
viral_symp_indices <- c(1,2,5,9,11,13,15,16,17,18,19,20,21)
viral_asymp_indices <- c(3,4,6,7,8,10,12,14)
viral <- vector(length=21)
for (i in viral_symp_indices) {
	viral[i] <- "v_s"
}
for (i in viral_asymp_indices) {
	viral[i] <- "v_as"
}

# Write factors for baseline
baseline <- rep_len("bl", 21)

# Write factors for bacteria
bacteria <- rep_len("bc", 10)

# Get one big factor vector
category_vector <- c(viral, baseline, bacteria)
sample_factors <- factor(category_vector)
sample_factors

# Save factor vector
save(sample_factors, file="Data_out/saved_sample_factors.r")
write.table(sample_factors, "Data_out/sample_factors.txt", row.names=FALSE, col.names=FALSE, sep="\t", quote=FALSE)
