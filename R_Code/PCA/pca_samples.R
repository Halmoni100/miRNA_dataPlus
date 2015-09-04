# Load the following...
# df (from data_frames.r)
# sample_factors

# Do PCA Analysis
pca_analysis <- dget("R_Code/PCA/analyze_PCs_samples.r")
pca_analysis(df, sample_factors, 10)