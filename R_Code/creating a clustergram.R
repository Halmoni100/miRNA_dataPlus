# creating a clustergram
clustergram <- hclust(dist(b_matrix), "complete")
plot(clustergram)


# making a qqplot
