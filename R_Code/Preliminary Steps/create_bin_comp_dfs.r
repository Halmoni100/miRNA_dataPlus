# Create list of data frames describing binary comparisons

# Load the following...
# df
# sample_factors
# create_df_sub func
load("Data_in/data_frames.r")
load("Data_in/saved_sample_factors.r")
create_df_sub = dget("R_Code/Preliminary Steps/create_df_sub.r")

# For reference:
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline Symptomatic - bl_s
# Basline Asymptomatic - bl_as
# Bacteria - bc

# initialize data frame
bin_comp_dfs = list()

# create list of groups (group is also a list) describing binary comparisons
bin_comp_grps = list()
bin_comp_names_list = list()

# Viral Symptomatic vs Baseline Symptomatic
bin_comp_1 = list(grp1="v_s", grp2="bl_s")
bin_comp_grps[[1]] = bin_comp_1
bin_comp_names_list[[1]] = c("Viral Symptomatic", "Baseline Symptomatic")

# Viral Asymptomatic vs Baseline Asymptomatic
bin_comp_2 = list(grp1="v_as", grp2="bl_as")
bin_comp_grps[[2]] = bin_comp_2
bin_comp_names_list[[2]] = c("Viral Asymptomatic", "Baseline Asymptomatic")

# Viral Symptomatic vs Viral Asymptomatic
bin_comp_3 = list(grp1="v_s", grp2="v_as")
bin_comp_grps[[3]] = bin_comp_3
bin_comp_names_list[[3]] = c("Viral Symptomatic", "Viral Asymptomatic")

# Viral Symptomatic vs Bacteria
bin_comp_4 = list(grp1="v_s", grp2="bc")
bin_comp_grps[[4]] = bin_comp_4
bin_comp_names_list[[4]] = c("Viral Symptomatic", "Bacteria")

# Baseline Symptomatic vs Baseline Asymptomatic
bin_comp_5 = list(grp1="bl_s", grp2="bl_as")
bin_comp_grps[[5]] = bin_comp_5
bin_comp_names_list[[5]] = c("Baseline Symptomatic", "Baseline Asymptomatic")

# Bacteria vs Baseline
bin_comp_6 = list(grp1="bc", grp2=c("bl_s", "bl_as"))
bin_comp_grps[[6]] = bin_comp_6
bin_comp_names_list[[6]] = c("Bacteria", "Baseline")

# Sick vs Baseline
bin_comp_7 = list(grp1=c("bc", "v_s", "v_as"), grp2=c("bl_s", "bl_as"))
bin_comp_grps[[7]] = bin_comp_7
bin_comp_names_list[[7]] = c("Sick", "Baseline")

# create data frames
for (i in 1:7) {
	bin_comp_grp = bin_comp_grps[[i]]
	bin_comp_name = bin_comp_names_list[[i]]
	df_sub = create_df_sub(df, sample_factors, bin_comp_grp, bin_comp_name)
	bin_comp_dfs[[i]] = df_sub
}

save(bin_comp_dfs, file="Data_out/saved_bin_comp_dfs.r")