set.seed(12345)
M <- 1000
beta.true <- -2
mc.beta.logit <- rep(NA,M)
##load the mean bandwidth calculated through a 1000-mc simulation using np package.
#h.ich <- mean(unlist(read.csv("bw_ich.csv")[2]))
#h.ks <- mean(unlist(read.csv("bw_KS.csv")[2]))

##data generation
for(j in 1:M){
  n <- 250
  x1<-rnorm(n)
  x2<-rnorm(n)
  e<-0.75*rnorm(n,mean=-0.5,sd=1)+0.25*rnorm(n,mean=1.5,sd=2.5)
  y <- ifelse(x1 + beta.true*x2 - e > 0, 1, 0)
  X <- cbind(x1,x2)
  
  ##Impose a trimming function:
  #new_data <- data.trim(X,y,h.ich)
  #X <- new_data[,1:2]
  #y <- new_data[,3]
  
  a <- summary(glm(y ~ x1 + x2, family='binomial'))$coefficients
  mc.beta.logit[j] <- a[3][1]/a[2][1]
}

MSE_logit_joint <- mean((mc.beta.logit - beta.true))^2

write.csv(mc.beta.logit, 'beta_logit_joint_mc.csv')