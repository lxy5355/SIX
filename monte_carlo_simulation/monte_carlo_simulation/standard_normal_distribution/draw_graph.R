beta_ich_n_50=read.csv("beta_ich_mc_n_50.csv",header=TRUE)
beta_ks_n_50=read.csv("beta_ks_mc_n_50.csv",header=TRUE)
beta_ich_n_150=read.csv("beta_ich_mc_n_150.csv",header=TRUE)
beta_ks_n_150=read.csv("beta_ks_mc_n_150.csv",header=TRUE)
beta_ich_n_250=read.csv("beta_ich_mc_n_250.csv",header=TRUE)
beta_ks_n_250=read.csv("beta_ks_mc_n_250.csv",header=TRUE)

#########################################################################
beta_hat_ich_n_50 <- beta_ich_n_50$x
beta_hat_ks_n_50 <- beta_ks_n_50$x
beta_hat_ich_n_150 <- beta_ich_n_150$x
beta_hat_ks_n_150 <- beta_ks_n_150$x
beta_hat_ich_n_250 <- beta_ich_n_250$x
beta_hat_ks_n_250 <- beta_ks_n_250$x


par(mfrow=c(3,2))
hist(beta_hat_ich_n_50,breaks = 50, main="Ichimura:n=50",xlim = range(c(-4,0)))
hist(beta_hat_ks_n_50,breaks = 50, main="Klein and Spady:n=50",xlim = range(c(-4,0)))
hist(beta_hat_ich_n_150,breaks = 50, main="Ichimura:n=150",xlim = range(c(-4,0)))
hist(beta_hat_ks_n_150,breaks = 50, main="Klein and Spady:n=150",xlim = range(c(-4,0)))
hist(beta_hat_ich_n_250,breaks = 50, main="Ichimura:n=250",xlim = range(c(-4,0)))
hist(beta_hat_ks_n_250,breaks = 50, main="Klein and Spady:n=250",xlim = range(c(-4,0)))

#boxplot(beta_ich_standard$x, main="beta_ich_standard")
#boxplot(beta_ks_standard$x, main="beta_ks_standard")

#stats_ich_standard <- boxplot.stats(beta_ich_standard$x, coef = 1.5)$stats
#stats_ks_standard <- boxplot.stats(beta_ks_standard$x, coef = 1.5)$stats