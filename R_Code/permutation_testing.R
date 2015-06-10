# Load the following...
# sample_factors
# quantile_norm_data

# For reference, factors are
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline - bl
# Bacteria - bc

# Assume that group 1 is class in consideration, group 2 is everything else
groups <- rep.int(2, nrow(quantile_norm_data))

