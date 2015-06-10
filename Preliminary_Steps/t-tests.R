# load normalized data set using "Normalization" R script


# subset viral, bacterial, baseline, asymptomatic/symptomatic miRNA expression
allviral <- quantile_norm_data[,1:21]
baseline <- quantile_norm_data[,22:42]
bacterial <- quantile_norm_data[,43:52]
viral_symptomatic <- quantile_norm_data[,c(1,2,5,9,11,13,15,16,17,18,19,20,21)]
viral_asymptomatic <- quantile_norm_data[,c(3,4,6,7,8,10,12,14)]
combined_bacterial_baseline <- quantile_norm_data[,22:52]
combined_bacterial_allviral <- quantile_norm_data[,c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,43,44,45,46,47,48,49,50,51,52)]
combined_baseline_allviral <- quantile_norm_data[,1:42]




# conducting a Welch Two Sample t-test on every variable (not assuming equal standard deviation) using a for loop
for (k in 1:nrow(quantile_norm_data)) {
output_vector <- vector()
# make an output matrix for the pvalues of all the tests
ttestmatrix <- matrix(, ncol=11, nrow=k)
output_vector[1] <- t.test(allviral[,k],bacterial[,k],alternative="two.sided")
output_vector[2] <- t.test(allviral[,k],baseline[,k],alternative="two.sided", paired=TRUE)
# test2 is a paired t-test 
output_vector[3] <- t.test(viral_symptomatic[,k], viral_asymptomatic[,k],alternative="two.sided")
output_vector[4] <- t.test(bacterial[,k],baseline[,k],alternative="two.sided")
output_vector[5] <- t.test(bacterial[,k],viral_symptomatic[,k],alternative="two.sided")
output_vector[6] <- t.test(bacterial[,k],viral_asymptomatic[,k],alternative="two.sided")
output_vector[7] <- t.test(baseline[,k], viral_symptomatic[,k], alternative="two.sided")
output_vector[8] <- t.test(baseline[,k], viral_asymptomatic[,k], alternative="two.sided")
output_vector[9] <- t.test(combined_bacterial_baseline[,k],allviral[,k],alternative="two.sided")
output_vector[10] <- t.test(combined_bacterial_allviral[,k],baseline[,k],alternative="two.sided")
output_vector[11] <- t.test(combined_baseline_allviral[,k],bacterial[,k],alternative="two.sided")

ttestmatrix[k,] <- output_vector
}



print(ttestmatrix)











