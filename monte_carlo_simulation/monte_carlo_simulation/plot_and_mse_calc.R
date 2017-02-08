beta_ich_joint=read.csv("beta_ich_joint_mc.csv",header=TRUE)
beta_ks_joint=read.csv("beta_ks_joint_mc.csv",header=TRUE)
beta_ich_standard=read.csv("beta_ich_mc.csv",header=TRUE)
beta_ks_standard=read.csv("beta_ks_mc.csv",header=TRUE)
beta_logit_standard=read.csv("beta_logit_standard_mc.csv",header=TRUE)
beta_logit_joint=read.csv("beta_logit_joint_mc.csv",header=TRUE)


#########################################################################
par(mfrow=c(3,2))
hist(beta_ich_standard$x,breaks = 80, main="beta_ich_standard",xlim = range(c(-4,-1)))
hist(beta_ich_joint$x,breaks = 80, main="beta_ich_joint",xlim = range(c(-4,-1)))

hist(beta_ks_standard$x,breaks = 80, main="beta_ks_standard",xlim = range(c(-4,-1)))
hist(beta_ks_joint$x,breaks = 80, main="beta_ks_joint",xlim = range(c(-4,-1)))

hist(beta_logit_standard$x,breaks = 60, main="beta_logit_standard",xlim = range(c(-4,-1)))
hist(beta_logit_joint$x,breaks = 60, main="beta_logit_joint",xlim = range(c(-4,-1)))

#boxplot(beta_ich_joint$x, main="beta_ich_joint")
#boxplot(beta_ks_joint$x, main="beta_ks_joint")

#stats_ich_joint <- boxplot.stats(beta_ich_joint$x, coef = 1.5)$stats
#stats_ks_joint <- boxplot.stats(beta_ks_joint$x, coef = 1.5)$stats

##########################################################################
beta.true <- -2
MSE_ich_standard <- mean((beta_ich_standard$x - beta.true))^2
MSE_ks_standard <- mean((beta_ks_standard$x - beta.true))^2
MSE_logit_standard <- mean((beta_logit_standard$x - beta.true))^2
MSE_ich_joint <- mean((beta_ich_joint$x - beta.true))^2
MSE_ks_joint <- mean((beta_ks_joint$x - beta.true))^2
MSE_logit_joint <- mean((beta_logit_joint$x - beta.true))^2

RMSE_ich_standard <- sqrt(MSE_ich_standard)
RMSE_ks_standard <- sqrt(MSE_ks_standard)
RMSE_logit_standard <- sqrt(MSE_logit_standard)
RMSE_ich_joint <- sqrt(MSE_ich_joint)
RMSE_ks_joint <- sqrt(MSE_ks_joint)
RMSE_logit_joint <- sqrt(MSE_logit_joint)