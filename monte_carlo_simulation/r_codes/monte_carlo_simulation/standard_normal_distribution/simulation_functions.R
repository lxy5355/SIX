source("ichimura_functions.R") 
source("KS_functions.R") 
source("trimming_function.R")

set.seed(12345)
M <- 1000
beta.true <- -2
mc.beta.ich.fun <- rep(NA,M)
mc.beta.KS.fun <- rep(NA,M)

##load the mean bandwidth calculated through a 1000-mc simulation using np package
h.ich <- mean(unlist(read.csv("bw_ich.csv")[2]))
h.ks <- mean(unlist(read.csv("bw_KS.csv")[2]))

##data generation
for(j in 1:M){
n <- 250
x1<-rnorm(n)
x2<-rnorm(n)
y <- ifelse(x1 + beta.true*x2 - rnorm(n) > 0, 1, 0)
X <- cbind(x1,x2)

##impose a trimming function
new_data <- data.trim(X,y,h.ich)
X <- new_data[,1:2]
y <- new_data[,3]

mc.beta.ich.fun[j] <- ichimura_calc (X,y,h.ich)$beta.hat[2]
mc.beta.KS.fun[j] <- KS_calc (X,y,h.ks)$beta.hat[2]
}

##calculate the bias and mean-squared-error
bias_ich_standard <- mean(mc.beta.ich.fun) - beta.true
bias_ks_standard <- mean(mc.beta.KS.fun) - beta.true
MSE_ich_standard <- mean((mc.beta.ich.fun - beta.true))^2
MSE_ks_standard <- mean((mc.beta.KS.fun - beta.true))^2

##save the results of mc estimates
write.csv(mc.beta.ich.fun, 'beta_ich_mc_n_250.csv')
write.csv(mc.beta.KS.fun, 'beta_ks_mc_n_250.csv')
