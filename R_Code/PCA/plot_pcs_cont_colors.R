function(pcs_all, z_data, num, root_dir) {
	
	# Load package
	library(ggplot2)
	
	max_z = max(abs(z_data))
	# Plot all combinations of PCs, store in files
	# color is continuous based on z_data
	from_i = 1
	to_i = num - 1
	to_j = num
	for (i in from_i:to_i) {
		from_j = i + 1
		for (j in from_j:to_j) {
			plot_name = paste(i,"vs",j, sep="_")
			dir_name = paste(root_dir, plot_name, ".jpeg", sep="")
			plot_df = data.frame(xval=pcs_all[[i]], yval=pcs_all[[j]],
					zval=z_data)
			plot = ggplot(plot_df, aes(x=xval, y=yval, color=zval)) +
					geom_point() + 
					scale_colour_gradientn(colours=rainbow(5))
			ggsave(dir_name, plot)
		}
	}

}