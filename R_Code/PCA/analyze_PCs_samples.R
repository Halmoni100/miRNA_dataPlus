function(data, factors, num) {
	
	# Load package
	library(FactoMineR)

	# PCA analysis, samples are data points, miRNAs are features
	# In data, rows are samples, columns are miRNA features
	pca_df = PCA(data, ncp=num, graph=FALSE)

	# Find proportion of variance, etc.
	prop_of_var <- pca_df$eig[1:num,]
	dir.create("Results/PCA")
	write.table(prop_of_var, "Results/PCA/prop_of_vars_samples.txt", sep="\t", quote=FALSE)
	# Plot cumulative proportion of variance
	cum_var <- prop_of_var[ , 3]
	postscript(file="Results/PCA/cum_var.eps", width=5, height=5)
	plot(1:length(cum_var), cum_var, main="Cumulative Percentage of Variance", xlab="PCs", ylab="Cum. % of Var.", ylim=c(0,100))
	lines(1:length(cum_var), cum_var)
	dev.off()
	
	# Get correlations b/w variables and PCs
	corr <- pca_df$var$coord
	save(corr, file="Results/PCA/saved_corr_samples.r")
	write.table(corr, "Results/PCA/correlation_samples.txt", sep="\t", quote=FALSE)


	# Get first n PCs, store in lists
	pca_result <- pca_df$ind$coord

	pcs_all <- vector(mode="list", length=num)
	pcs_viral_symp <- vector(mode="list", length=num)
	pcs_viral_asymp <- vector(mode="list", length=num)
	pcs_baseline <- vector(mode="list", length=num)
	pcs_bacteria <- vector(mode="list", length=num)
	for (i in 1:num) {
		pcs_all[[i]] <- pca_result[,i]
		pcs_viral_symp[[i]] <- pca_result[sample_factors == "v_s",i]
		pcs_viral_asymp[[i]] <- pca_result[sample_factors == "v_as",i]
		all_baseline_bool <- sample_factors == "bl_s" | sample_factors == "bl_as"
		pcs_baseline[[i]] <- pca_result[all_baseline_bool,i]
		pcs_bacteria[[i]] = pca_result[43:52,i]
	}

	# create plots folder
	dir.create("Results/PCA/plots")
	
	# Plot all combinations of PCs, store in files
	# red = viral symp, orange = viral asymp, blue = baseline, green = bacteria
	from_i <- 1
	to_i <- num - 1
	to_j <- num
	for (i in from_i:to_i) {
		from_j <- i + 1
		for (j in from_j:to_j) {
			plot_name <- paste(i,"vs",j, sep="_")
			dir_name <- paste("Results/PCA/plots/",
					plot_name, ".jpeg", sep="")
			jpeg(dir_name, width=15, height=15, units="cm", res=300)
			plot(pcs_viral_symp[[i]], pcs_viral_symp[[j]], col="red", pch=16,
					xlab=paste("PC", i), ylab=paste("PC", j),
					xlim=c(min(pcs_all[[i]]), max(pcs_all[[i]])),
					ylim=c(min(pcs_all[[j]]), max(pcs_all[[j]])))
			points(pcs_viral_asymp[[i]], pcs_viral_asymp[[j]], col="orange", pch=16)
			points(pcs_baseline[[i]], pcs_baseline[[j]], col="blue", pch=16)
			points(pcs_bacteria[[i]], pcs_bacteria[[j]], col="green", pch=16)
			dev.off()
		}
	}

}
