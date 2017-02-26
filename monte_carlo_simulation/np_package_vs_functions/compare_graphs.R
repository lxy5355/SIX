beta_ich_fun=read.csv("mc_beta_ich_fun.csv",header=TRUE)
beta_ks_fun=read.csv("mc_beta_ks_fun.csv",header=TRUE)
beta_ich_np=read.csv("mc_beta_ich_np.csv",header=TRUE)
beta_ks_np=read.csv("mc_beta_ks_np.csv",header=TRUE)


#########################################################################
beta_hat_ich_self <- beta_ich_fun$x
beta_hat_ich_np <- beta_ich_np$x
beta_hat_ks_self <- beta_ks_fun$x
beta_hat_ks_np <- beta_ks_np$x

par(mfrow=c(2,2))
hist(beta_hat_ich_self,breaks = 50, main="Ichimura:self-implementation",xlim = range(c(-4,-1)))
hist(beta_hat_ks_self,breaks = 50, main="Klein and Spady:self-implementation",xlim = range(c(-4,-1)))
hist(beta_hat_ich_np,breaks =60, main="Ichimura:np-package", xlim = range(c(-4,-1)))
hist(beta_hat_ks_np,breaks = 60, main="Klein and Spady:np-package", xlim = range(c(-4,-1)))

boxplot(beta_ich_fun$x, main="beta_ich_fun")
boxplot(beta_ich_np$x, main="beta_ich_np")
boxplot(beta_ks_fun$x, main="beta_ks_fun")
boxplot(beta_ks_np$x, main="beta_ks_np")

stats_ich_fun <- boxplot.stats(beta_ich_fun$x, coef = 1.5)$stats
stats_ich_np <- boxplot.stats(beta_ich_np$x, coef = 1.5)$stats
stats_ks_fun <- boxplot.stats(beta_ks_fun$x, coef = 1.5)$stats
stats_ks_np <- boxplot.stats(beta_ks_np$x, coef = 1.5)$stats