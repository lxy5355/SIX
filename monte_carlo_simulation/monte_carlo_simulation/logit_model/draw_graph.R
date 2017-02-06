beta_logit=read.csv("beta_logit_mc.csv",header=TRUE)

#########################################################################
#par(mfrow=c(1,2))
hist(beta_logit$x,breaks = 50, main="beta_logit",xlim = range(c(-4,-1)))


boxplot(beta_logit$x, main="beta_logit")

stats_logit <- boxplot.stats(beta_logit$x, coef = 1.5)$stats