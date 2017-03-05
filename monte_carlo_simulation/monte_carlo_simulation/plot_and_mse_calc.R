beta_ich_joint=read.csv("beta_ich_joint_mc.csv",header=TRUE)
beta_ks_joint=read.csv("beta_ks_joint_mc.csv",header=TRUE)
beta_ich_standard=read.csv("beta_ich_mc.csv",header=TRUE)
beta_ks_standard=read.csv("beta_ks_mc.csv",header=TRUE)
beta_logit_standard=read.csv("beta_logit_standard_mc.csv",header=TRUE)
beta_logit_joint=read.csv("beta_logit_joint_mc.csv",header=TRUE)

beta_hat_ich_standard <- beta_ich_standard$x
beta_hat_ich_joint <- beta_ich_joint$x
beta_hat_ks_standard <- beta_ks_standard$x
beta_hat_ks_joint <- beta_ks_joint$x
beta_hat_logit_standard <- beta_logit_standard$x
beta_hat_logit_joint <- beta_logit_joint$x
#########################################################################
par(mfrow=c(3,2))
hist(beta_hat_ich_standard,breaks = 80, main="Ichimura:standard normal",xlim = range(c(-4,-1)))
hist(beta_hat_ich_joint,breaks = 80, main="Ichimura:joint normal",xlim = range(c(-4,-1)))

hist(beta_hat_ks_standard,breaks = 80, main="Klein and Spady:standard normal",xlim = range(c(-4,-1)))
hist(beta_hat_ks_joint,breaks = 80, main="Klein and Spady:joint normal",xlim = range(c(-4,-1)))

hist(beta_hat_logit_standard,breaks = 60, main="Logit:standard normal",xlim = range(c(-4,-1)))
hist(beta_hat_logit_joint,breaks = 60, main="Logit:joint normal",xlim = range(c(-4,-1)))

#boxplot(beta_ich_joint$x, main="beta_ich_joint")
#boxplot(beta_ks_joint$x, main="beta_ks_joint")

#stats_ich_joint <- boxplot.stats(beta_ich_joint$x, coef = 1.5)$stats
#stats_ks_joint <- boxplot.stats(beta_ks_joint$x, coef = 1.5)$stats

##########################################################################
beta.true <- -2
MSE_ich_standard <- mean((beta_ich_standard$x - beta.true)^2)
MSE_ks_standard <- mean((beta_ks_standard$x - beta.true)^2)
MSE_logit_standard <- mean((beta_logit_standard$x - beta.true)^2)
MSE_ich_joint <- mean((beta_ich_joint$x - beta.true)^2)
MSE_ks_joint <- mean((beta_ks_joint$x - beta.true)^2)
MSE_logit_joint <- mean((beta_logit_joint$x - beta.true)^2)

RMSE_ich_standard <- sqrt(MSE_ich_standard)
RMSE_ks_standard <- sqrt(MSE_ks_standard)
RMSE_logit_standard <- sqrt(MSE_logit_standard)
RMSE_ich_joint <- sqrt(MSE_ich_joint)
RMSE_ks_joint <- sqrt(MSE_ks_joint)
RMSE_logit_joint <- sqrt(MSE_logit_joint)

bias_ich_standard <- mean(beta_ich_standard$x) - beta.true
bias_ich_joint <- mean(beta_ich_joint$x) - beta.true
bias_ks_standard <- mean(beta_ks_standard$x) - beta.true
bias_ks_joint <- mean(beta_ks_joint$x) - beta.true
bias_logit_standard <- mean(beta_logit_standard$x) - beta.true
bias_logit_joint <- mean(beta_logit_joint$x) - beta.true
