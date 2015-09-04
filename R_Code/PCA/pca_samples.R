load("R_Data/data_frames.r")
load("R_Data/saved_sample_factors.r")

# Do PCA Analysis
pca_analysis <- dget("miRNA_dataPlus_GitHub/R_Code/PCA/analyze_PCs_samples.r")
pca_analysis(df, sample_factors, 10)