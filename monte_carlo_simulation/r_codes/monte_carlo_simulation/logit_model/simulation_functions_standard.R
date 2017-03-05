set.seed(12345)
M <- 1000
beta.true <- -2
mc.beta.logit <- rep(NA,M)

##data generation
for(j in 1:M){
  n <- 50
  x1<-rnorm(n)
  x2<-rnorm(n)
  y <- ifelse(x1 + beta.true*x2 - rnorm(n) > 0, 1, 0)
  X <- cbind(x1,x2)
  #employ logistic distribution for estimation 
  a <- summary(glm(y ~ x1 + x2, family='binomial'))$coefficients
  mc.beta.logit[j] <- a[3][1]/a[2][1]
}

##calculate the bias and mean-squared-error
bias_logit_standard <- mean(mc.beta.logit) - beta.true
MSE_logit_standard <- mean((mc.beta.logit - beta.true))^2

##save the results of mc estimates
write.csv(mc.beta.logit, 'beta_logit_standard_mc_n_50.csv')
