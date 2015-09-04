load("R_Data/data_frames.r")

# Read content table w/ sequence data for miRNA & precursor
# Obtain these files by running Python script
miRNA_seq_df <- read.delim("sequence_content/content_table_miRNA.txt")
prec_seq_df <- read.delim("sequence_content/content_table_precursor.txt")

# Create lists for gc proportion and lengths for miRNA & precursor
miRNA_gc_prop <- miRNA_seq_df$gc_prop
prec_gc_prop <- prec_seq_df$gc_prop
miRNA_length <- miRNA_seq_df$length
prec_length <- prec_seq_df$length

# Do PCA Analysis for all variables
pca_analysis <- dget("miRNA_dataPlus_GitHub/R_Code/PCA/analyze_PCs_miRNA_precursor.r")
pca_analysis(t(df), miRNA_length, miRNA_gc_prop,
		prec_length, prec_gc_prop, 3)


