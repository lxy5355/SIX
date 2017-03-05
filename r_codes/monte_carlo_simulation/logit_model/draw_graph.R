beta_logit_standard=read.csv("beta_logit_standard_mc_n_150.csv",header=TRUE)
beta_logit_joint=read.csv("beta_logit_joint_mc.csv",header=TRUE)

#########################################################################
par(mfrow=c(1,2))
hist(beta_logit_standard$x,breaks = 60, main="beta_logit_standard",xlim = range(c(-4,-1)))
hist(beta_logit_joint$x,breaks = 60, main="beta_logit_joint",xlim = range(c(-4,-1)))

#boxplot(beta_logit$x, main="beta_logit")

#stats_logit <- boxplot.stats(beta_logit$x, coef = 1.5)$stats