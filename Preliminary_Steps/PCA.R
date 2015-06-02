function(data, n) {

# PCA analysis
pca_df = prcomp(t(data), scale. = TRUE)

# Get first n PCs, store in lists
pca_result <- pca_df$x
pcs_all = vector(mode="list", length=n)
pcs_viral = vector(mode="list", length=n)
pcs_baseline = vector(mode="list", length=n)
pcs_bacteria = vector(mode="list", length=n)
for (i in 1:n) {
	pcs_all[[i]] = pca_result[,i]
	pcs_viral[[i]] = pca_result[1:21,i]
	pcs_baseline[[i]] = pca_result[22:42,i]
	pcs_bacteria[[i]] = pca_result[43:52,i]
}

# Plot all combinations of PCs, store in files
# red=viral, green=baseline, blue=bacteria
from_i <- 1
to_i <- n - 1
to_j <- n
for (i in from_i:to_i) {
	from_j <- i + 1
	for (j in from_j:to_j) {
		plot_name <- paste(i,"vs",j)
		dir_name <- paste("Plots/PCA", plot_name, ".jpeg", collapse="")
		jpeg(dir_name)
		plot(pcs_viral[[i]], pcs_viral[[j]], col="red",
				xlim=c(min(pcs_all[[i]]), max(pcs_all[[i]])),
				ylim=c(min(pcs_all[[j]]), max(pcs_all[[j]])))
		points(pcs_baseline[[i]], pcs_baseline[[j]], col="green")
		points(pcs_bacteria[[i]], pcs_bacteria[[j]], col="blue")
		dev.off()
	}
}

}
