x1 = c(.09, .19, .2, .25, .3, .4)
y1 = c(.09, .43, .3, .1, .4, .25)
x2 = c(.68, .7, .82, .66, .91, 1.02)
y2 = c(.6, 1, .9, .7, 1, .85)

plot(x1, y1, xlim=range(c(x1,x2)), ylim=range(c(y1,y2)), col="blue", xlab="x", ylab="y", xaxt="n", yaxt="n")
points(x2, y2, pch=4, col="red")

set.seed(1)
rand_indices = sample(1:12)
x = c(x1,x2)
y = c(y1,y2)
xr1 = vector(length=6)
xr2 = vector(length=6) 
yr1 = vector(length=6) 
yr2 = vector(length=6) 
for (i in 1:6) {
	xr1[i] <- x[rand_indices[i]]
	yr1[i] <- y[rand_indices[i]]
}
for (i in 1:6) {
	xr2[i] <- x[rand_indices[i+6]]
	yr2[i] <- y[rand_indices[i+6]]
}

quartz()
plot(xr1, yr1, xlim=range(c(xr1,xr2)), ylim=range(c(yr1,yr2)), col="blue", xlab="x", ylab="y", xaxt="n", yaxt="n")
points(xr2, yr2, pch=4, col="red")
