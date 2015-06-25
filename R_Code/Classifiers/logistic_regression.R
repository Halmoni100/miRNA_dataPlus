# Load the following...
# df (from data_frames.r)
# sample_factors

# For reference:
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline Symptomatic - bl_s
# Basline Asymptomatic - bl_as
# Bacteria - bc

# Load create_df_sub function
create_df_sub <- dget("R_Code/Classifiers/create_df_sub.r")

# test...
# try on viral symptomatic vs bacteria
# create factors and factor_names
grp1 <- "v_s"
grp2 <- "bc"
factors <- list(grp1, grp2)
factor_names <- c("Viral_Symp", "Bacteria")
# get df_sub
df_sub <- create_df_sub(df, sample_factors, factors, factor_names)s


