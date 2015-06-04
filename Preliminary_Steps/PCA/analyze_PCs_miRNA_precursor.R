function(data, miRNA_lengths, miRNA_gc_content, 
		prec_lengths, prec_gc_content, num) {

	# Load package
	library(FactoMineR)
	
	# PCA analysis, miRNAs are data points, samples are features
	pca_df = PCA(data, ncp=num, graph=FALSE)
	
	# Find proportion of variance, etc.
	prop_of_var <- pca_df$eig[1:num,]
	write.table(prop_of_var, "Preliminary_Steps/PCA/analysis/prop_of_vars_miRNA.txt", sep="\t", quote=FALSE)
	
	# Get first n PCs, store in lists
	pca_result <- pca_df$ind$coord
	pcs_all = vector(mode="list", length=num)
	for(i in 1:num) {
		pcs_all[[i]] = pca_result[,i]
	}			
					
	# Retrieve plotting function
	plot_pcs <- dget("Preliminary_Steps/PCA/plot_pcs_cont_colors.r")
	
	# Do miRNA lengths
	dir <- "Preliminary_Steps/PCA/plots_miRNA/length/"
	plot_pcs(pcs_all, miRNA_lengths, num, dir)
	# Do miRNA gc content
	dir <- "Preliminary_Steps/PCA/plots_miRNA/gc_content/"
	plot_pcs(pcs_all, miRNA_gc_content, num, dir)
	# Do precursor lengths
	dir <- "Preliminary_Steps/PCA/plots_precursor/length/"
	plot_pcs(pcs_all, miRNA_lengths, num, dir)
	# Do precursor gc content
	dir <- "Preliminary_Steps/PCA/plots_precursor/gc_content/"
	plot_pcs(pcs_all, miRNA_gc_content, num, dir)
	
}