# Factors are:
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline Symptomatic - bl_s
# Basline Asymptomatic - bl_as
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

# Write factors for baseline symptomatic & asymptomatic
baseline_symp_indices <- c(22,23,24,26,27,28,29,31,33,34,37,41,42)
baseline_asymp_indices <- c(25,30,32,35,36,38,39,40)
baseline <- vector(length=21)
for (i in baseline_symp_indices) {
	j <- i-21
	baseline[j] <- "bl_s"
}
for (i in baseline_asymp_indices) {
	j <- i-21
	baseline[j] <- "bl_as"
}


# Write factors for bacteria
bacteria <- rep_len("bc", 10)

# Get one big factor vector
category_vector <- c(viral, baseline, bacteria)
sample_factors <- factor(category_vector)

# Save factor vector
save(sample_factors, file="R_Data/saved_sample_factors.r")
write.table(sample_factors, "Misc/misc_data/sample_factors.txt", row.names=FALSE, col.names=FALSE, sep="\t", quote=FALSE)
