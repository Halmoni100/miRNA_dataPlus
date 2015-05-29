# Load packages
library("gplots", lib="R_packages")

# Retrieve Data
# raw_data retreived
load("R_Data/saved_raw_data")
# processed_data retreived
load("R_Data/saved_processed_data")


# log2 data
log2_data_raw <- log2(raw_data + 1)
log2_data_proc <- log2(processed_data + 1)

# make processed log2 heat map (R heatmap function)
heatmap(log2_data_raw) # not working for some reason...
quartz()
heatmap(log2_data_proc)

# make log2 heat map (gplots heatmap function)
quartz()
heatmap.2(log2_data, trace="none")