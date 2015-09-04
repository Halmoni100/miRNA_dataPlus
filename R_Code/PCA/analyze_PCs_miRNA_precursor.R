function(data, miRNA_lengths, miRNA_gc_content, 
		prec_lengths, prec_gc_content, num) {

	# Load package
	library(FactoMineR)
	
	# Make directories
	dir.create("Results/PCA")
	root_dir = "Results/PCA/PCA_Sequence_Data"
	dir.create(root_dir)
	miRNA_dir = paste(root_dir, "/plots_miRNA", sep="")
	precursor_dir = paste(root_dir, "/plots_precursor", sep="")
	dir.create(miRNA_dir)
	dir.create(precursor_dir)
	miRNA_length_dir = paste(miRNA_dir, "/length", sep="")
	miRNA_gc_dir = paste(miRNA_dir, "/gc_content", sep="")
	prec_length_dir = paste(precursor_dir, "/length", sep="")
	prec_gc_dir = paste(precursor_dir, "/gc_content", sep="")
	dir.create(miRNA_length_dir)
	dir.create(miRNA_gc_dir)
	dir.create(prec_length_dir)
	dir.create(prec_gc_dir)
	
	# PCA analysis, miRNAs are data points, samples are features
	pca_df = PCA(data, ncp=num, graph=FALSE)
	
	# Find proportion of variance, etc.
	prop_of_var <- pca_df$eig[1:num,]
	write.table(prop_of_var, "Results/PCA/PCA_Sequence_Data/prop_of_vars_miRNA.txt", sep="\t", quote=FALSE)
	
	# Get first n PCs, store in lists
	pca_result <- pca_df$ind$coord
	pcs_all = vector(mode="list", length=num)
	for(i in 1:num) {
		pcs_all[[i]] = pca_result[,i]
	}			
					
	# Retrieve plotting function
	plot_pcs <- dget("miRNA_dataPlus_GitHub/R_Code/PCA/plot_pcs_cont_colors.r")
	
	# Do miRNA lengths
	plot_pcs(pcs_all, miRNA_lengths, num, paste(miRNA_length_dir, "/", sep=""))
	# Do miRNA gc content
	plot_pcs(pcs_all, miRNA_gc_content, num, paste(miRNA_gc_dir, "/", sep=""))
	# Do precursor lengths
	plot_pcs(pcs_all, miRNA_lengths, num, paste(prec_length_dir, "/", sep=""))
	# Do precursor gc content
	plot_pcs(pcs_all, miRNA_gc_content, num, paste(prec_gc_dir, "/", sep=""))
}