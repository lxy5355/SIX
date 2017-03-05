#install.packages('np')
library('np')
#help('npindex')
set.seed(12345)
M <- 1000
beta.true <- -2
mc.beta.ich.np <- rep(NA,M)
mc.bw.ich.np <- rep(NA,M)
mc.beta.KS.np <- rep(NA,M)
mc.bw.KS.np <- rep(NA,M)

##data generation
for(j in 1:M){
n <- 250
x1<-rnorm(n)
x2<-rnorm(n)
y <- ifelse(x1 + beta.true*x2 - rnorm(n) > 0, 1, 0)
X <- cbind(x1,x2)

##method:ichimura
bw_ich <- npindexbw(xdat=X, ydat=y)
#summary(bw_ich)
model_ich <- npindex(bws=bw_ich, gradients=TRUE)
#summary(model_ich)

##method:klein and spady
bw_ks <- npindexbw(xdat=X, ydat=y, method="kleinspady")
#summary(bw_ks)
model_ks <- npindex(bws=bw_ks, gradients=TRUE)
#summary(model_ks)

mc.bw.ich.np[j] <- bw_ich$bw
mc.bw.KS.np[j] <- bw_ks$bw
mc.beta.ich.np[j] <- model_ich$beta[2]
mc.beta.KS.np[j] <- model_ks$beta[2]
}

MSE_ich_np <- mean((mc.beta.ich.np - beta.true))^2
MSE_ks_np <- mean((mc.beta.KS.np - beta.true))^2

##save the optimal bandwidth and results of mc estimates
write.csv(mc.bw.ich.np, file = "bw_ich.csv")
write.csv(mc.bw.KS.np, file = "bw_KS.csv")
write.csv(mc.beta.ich.np, 'mc_beta_ich_np.csv')
write.csv(mc.beta.KS.np, 'mc_beta_ks_np.csv')