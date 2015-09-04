load("R_Data/saved_bin_comp_dfs.r")
load("R_Data/saved_bin_comp_names.r")

# Loading do_random_forest func
do_random_forest = dget("miRNA_dataPlus_GitHub/R_Code/Classifiers/do_random_forest.r")

# create main directory
dir.create("Results/random_forest")
main_dir = "Results/random_forest/"

# Do random forest for each binary comparison
for (i in 1:7) {
	# get df_sub
	df_sub = bin_comp_dfs[[i]]
	# create directory
	dir.create(paste(main_dir, bin_comp_names[i], sep=""))
	# perform random forest
	sub_dir = paste(bin_comp_names[i], "/", sep="")
	# perform random forest, 1000 trees
	do_random_forest(df_sub, 1000, 1, paste(main_dir, sub_dir, sep=""))
}
