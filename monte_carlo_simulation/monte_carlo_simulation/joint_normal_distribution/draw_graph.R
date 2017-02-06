beta_ich_standard=read.csv("beta_ich_mc.csv",header=TRUE)
beta_ks_standard=read.csv("beta_ks_mc.csv",header=TRUE)

#########################################################################
par(mfrow=c(1,2))
hist(beta_ich_standard$x,breaks = 50, main="beta_ich_standard",xlim = range(c(-4,-1)))
hist(beta_ks_standard$x,breaks = 50, main="beta_ks_standard",xlim = range(c(-4,-1)))

boxplot(beta_ich_standard$x, main="beta_ich_standard")
boxplot(beta_ks_standard$x, main="beta_ks_standard")

stats_ich_standard <- boxplot.stats(beta_ich_standard$x, coef = 1.5)$stats
stats_ks_standard <- boxplot.stats(beta_ks_standard$x, coef = 1.5)$stats