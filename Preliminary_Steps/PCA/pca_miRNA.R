# Retrieve Data
# logged_data retrieved
load("R_data/saved_logged_data")

# Read content table w/ sequence data
#seq_df <- read.delim("Preliminary_Steps/sequence_content/content_table.txt")
#head(seq_df)

# Create list for gc proportion
#gc_prop_list <- seq_df$gc_prop
#names(gc_prop_list) <- seq_df$miRNA
#head(gc_prop_list)

# Do PCA Analysis
#pca_analysis <- dget("Preliminary_Steps/PCA/analyze_PCs_miRNA.r")
#pca_analysis(logged_data, 25)