# Load the following...
# bin_comp_dfs
# bin_comp_names
# do_log_reg func
load("Data_in/saved_bin_comp_dfs.r")
load("Data_in/saved_bin_comp_names.r")
do_log_reg = dget("R_Code/Classifiers/do_log_reg.r")

# create main directory
dir.create("Data_out/logistic_regression_out")
main_dir = "Data_out/logistic_regression_out/"

# Do logistic regression for each binary comparison
for (i in 1:7) {
	# get df_sub
	df_sub = bin_comp_dfs[[i]]
	# create directory
	dir.create(paste(main_dir, bin_comp_names[i], sep=""))
	# perform logistic regression
	sub_dir = paste(bin_comp_names[i], "/", sep="")
	do_log_reg(df_sub, 1, paste(main_dir, sub_dir, sep=""))
}