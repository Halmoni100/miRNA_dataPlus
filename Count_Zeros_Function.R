count_zeros <- function(v) {
	len <- length(v)
	zero_bool <- v==0
	zero_count <- length(which(zero_bool == "TRUE"))
	nonzero_count <- len - zero_count
	props <- c(0,0)
	props[1] <- zero_count / len
	props[2] <- nonzero_count / len
	return(props)
}