# miRNA_dataPlus
Data+ Program

Make sure to set working directory to Data_Plus

Setup variables:
1. Run retrieve_and_process_data.R to get:
	- data_frames.r (contains df and feat_df)
	- saved_data_proc.r
	- saved_uqnorm_data.r
2. Run make_factors to get saved_sample_factors.r and sample_factors.txt
3. Run create_bin_comp_df.r to get saved_bin_comp_dfs.r
4. Run create_bin_comp_names.r to get saved_bin_comp_names.r


To run t-tests:
1. Run t_tests.R to get saved_p_vals.r and saved_conf_ints_p_vals.r
2. Rn p_val_correction.R to get saved_significant_miRNAs.r
BUG: ordering of p-values in significant_miRNAs will not work if p value is in scientific notation form (ex. 1.759e-5)
