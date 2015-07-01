# Load the following...
# df (from data_frames.r)
# sample_factors
load("Data_in/data_frames.r")
load("Data_in/saved_sample_factors.r")

# For reference:
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline Symptomatic - bl_s
# Basline Asymptomatic - bl_as
# Bacteria - bc

# Load create_df_sub function
create_df_sub = dget("R_Code/Classifiers/create_df_sub.r")
# Load do_log_reg function
do_log_reg = dget("R_Code/Classifiers/do_log_reg.r")

# create main directory
dir.create("Data_out/logistic_regression_out")
main_dir = "Data_out/logistic_regression_out/"

#######################
# Viral Symptomatic vs Baseline Symptomatic
#######################
# create factors and factor_names
grp1 = "v_s"
grp2 = "bl_s"
factors = list(grp1, grp2)
factor_names = c("Viral Symptomatic", "Baseline Symptomatic")
# get df_sub
df_sub = create_df_sub(df, sample_factors, factors, factor_names)
# create directory
dir.create(paste(main_dir, "viral_symp_vs_baseline_symp", sep=""))
# perform logistic regression
do_log_reg(df_sub, 1, paste(main_dir, "viral_symp_vs_baseline_symp/", sep=""))

#######################
# Viral Asymptomatic vs Baseline Asymptomatic
#######################
# create factors and factor_names
grp1 = "v_as"
grp2 = "bl_as"
factors = list(grp1, grp2)
factor_names = c("Viral Asymptomatic", "Baseline Asymptomatic")
# get df_sub
df_sub = create_df_sub(df, sample_factors, factors, factor_names)
# create directory
dir.create(paste(main_dir, "viral_asymp_vs_baseline_asymp", sep=""))
# perform logistic regression
do_log_reg(df_sub, 1, paste(main_dir, "viral_asymp_vs_baseline_asymp/", sep=""))

#######################
# Viral Symptomatic vs Bacteria
#######################
# create factors and factor_names
grp1 = "v_s"
grp2 = "bc"
factors = list(grp1, grp2)
factor_names = c("Viral Symptomatic", "Bacteria")
# get df_sub
df_sub = create_df_sub(df, sample_factors, factors, factor_names)
# create directory
dir.create(paste(main_dir, "viral_symp_vs_bacteria", sep=""))
# perform logistic regression
do_log_reg(df_sub, 1, paste(main_dir, "viral_symp_vs_bacteria/", sep=""))

#######################
# Baseline Symptomatic vs Baseline Asymptomatic
#######################
# create factors and factor_names
grp1 = "bl_s"
grp2 = "bl_as"
factors = list(grp1, grp2)
factor_names = c("Baseline Symptomatic", "Baseline Asymptomatic")
# get df_sub
df_sub = create_df_sub(df, sample_factors, factors, factor_names)
# create directory
dir.create(paste(main_dir, "baseline_symp_vs_baseline_asymp", sep=""))
# perform logistic regression
do_log_reg(df_sub, 1, paste(main_dir, "baseline_symp_vs_baseline_asymp/", sep=""))

#######################
# Bacteria vs Baseline
#######################
# create factors and factor_names
grp1 = "bc"
grp2 = c("bl_s", "bl_as")
factors = list(grp1, grp2)
factor_names = c("Bacteria", "Baseline")
# get df_sub
df_sub = create_df_sub(df, sample_factors, factors, factor_names)
# create directory
dir.create(paste(main_dir, "bacteria_vs_baseline", sep=""))
# perform logistic regression
do_log_reg(df_sub, 1, paste(main_dir, "bacteria_vs_baseline/", sep=""))

#######################
# Sick vs Baseline
#######################
# create factors and factor_names
grp1 = c("bc", "v_s", "v_as")
grp2 = c("bl_s", "bl_as")
factors = list(grp1, grp2)
factor_names = c("Sick", "Baseline")
# get df_sub
df_sub = create_df_sub(df, sample_factors, factors, factor_names)
# create directory
dir.create(paste(main_dir, "sick_vs_baseline", sep=""))
# perform logistic regression
do_log_reg(df_sub, 1, paste(main_dir, "sick_vs_baseline/", sep=""))