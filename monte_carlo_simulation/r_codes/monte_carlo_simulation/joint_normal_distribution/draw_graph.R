beta_ich_joint=read.csv("beta_ich_joint_mc.csv",header=TRUE)
beta_ks_joint=read.csv("beta_ks_joint_mc.csv",header=TRUE)

#########################################################################
par(mfrow=c(1,2))
hist(beta_ich_joint$x,breaks = 50, main="beta_ich_joint",xlim = range(c(-4,-1)))
hist(beta_ks_joint$x,breaks = 50, main="beta_ks_joint",xlim = range(c(-4,-1)))

boxplot(beta_ich_joint$x, main="beta_ich_joint")
boxplot(beta_ks_joint$x, main="beta_ks_joint")

stats_ich_joint <- boxplot.stats(beta_ich_joint$x, coef = 1.5)$stats
stats_ks_joint <- boxplot.stats(beta_ks_joint$x, coef = 1.5)$stats