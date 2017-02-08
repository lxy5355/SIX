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
y <- ifelse(x1 + beta.true*x2 - rnorm(n) > 0, 1, 0)
X <- cbind(x1,x2)

##Impose a trimming function:
#new_data <- data.trim(X,y,h.ich)
#X <- new_data[,1:2]
#y <- new_data[,3]

a <- summary(glm(y ~ x1 + x2, family='binomial'))$coefficients
mc.beta.logit[j] <- a[3][1]/a[2][1]
}

MSE_logit_standard <- mean((mc.beta.logit - beta.true))^2

write.csv(mc.beta.logit, 'beta_logit_standard_mc.csv')
