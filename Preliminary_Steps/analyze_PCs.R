function(data, num) {
# Load package
library(FactoMineR)

# PCA analysis
pca_df = PCA(t(data), ncp=num, graph=FALSE)

# Find proportion of variance, etc.
prop_of_var <- pca_df$eig[1:num,]
# save proportion of variance numbers
write.table(prop_of_var, "Preliminary_Steps/PCA/analysis/prop_of_vars.txt", sep="\t",
		quote=FALSE)

# Get first n PCs, store in lists
pca_result <- pca_df$ind$coord

pcs_all = vector(mode="list", length=num)
pcs_viral = vector(mode="list", length=num)
pcs_baseline = vector(mode="list", length=num)
pcs_bacteria = vector(mode="list", length=num)
for (i in 1:num) {
	pcs_all[[i]] = pca_result[,i]
	pcs_viral[[i]] = pca_result[1:21,i]
	pcs_baseline[[i]] = pca_result[22:42,i]
	pcs_bacteria[[i]] = pca_result[43:52,i]
}

# Plot all combinations of PCs, store in files
# red=viral, green=baseline, blue=bacteria
from_i <- 1
to_i <- num - 1
to_j <- num
for (i in from_i:to_i) {
	from_j <- i + 1
	for (j in from_j:to_j) {
		plot_name <- paste(i,"vs",j)
<<<<<<< HEAD:Preliminary_Steps/analyze_PCs.R
		dir_name <- paste("Preliminary_Steps/PCA/plots/", plot_name, ".jpeg", sep="")
=======
		dir_name <- paste("Plots/PCA/", plot_name, ".jpeg", collapse="")
>>>>>>> origin/master:Preliminary_Steps/PCA.R
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
