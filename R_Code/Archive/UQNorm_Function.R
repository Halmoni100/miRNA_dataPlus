UQNorm <- function(v) {
	quartiles <- quantile(v)
	uq <- quartiles[4]
	v <- v / uq
	return(v)
}