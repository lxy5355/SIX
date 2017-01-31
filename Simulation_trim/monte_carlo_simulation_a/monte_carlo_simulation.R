source("ichimura_functions.R") 
source("KS_functions.R") 
source("trimming_function.R")
#########################################################################
#monte carlo simulation
#true parameters

M <- 1000 #number of monte carlo simulation
n <- 250    # Sample Size
beta.true<--2 #true beta
h.ichimura <- .42
h.KS <- .16

######################  1  #####################
mc.beta.ichimura_1 <- rep(NA,M)
mc.beta.KS_1 <- rep(NA,M)

for(j in 1:M){
##Generate x and y sample:
  n <- 250
  x1<-rnorm(n)
  x2<-rnorm(n)
  y <- ifelse(x1 + beta.true*x2 - rnorm(n) > 0, 1, 0)
  X <- cbind(x1,x2)
##Impose a trimming function:
  new_data <- data.trim(X,y)
  X <- new_data[,1:2]
  y <- new_data[,3]
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_1[j] <- ichimura_calc (X,y,h.ichimura)$beta.hat[2]
  mc.beta.KS_1[j] <- KS_calc (X,y,h.KS)$beta.hat[2]
}

write.csv(mc.beta.ichimura_1, file = "ichimura_1.csv")
write.csv(mc.beta.KS_1, file = "KS_1.csv")

######################  2  #####################
mc.beta.ichimura_2 <- rep(NA,M)
mc.beta.KS_2 <- rep(NA,M)

for(j in 1:M){
##Generate x and y sample:
  x_1<-rexp(n)
  x_2<-rexp(n)
  X<-cbind(x_1,x_2)
  e<-rnorm(n)
  m<- X %*% beta.true - e 
  y<-m>0
##Impose a trimming function:
  new_data <- data.trim(X,y)
  X <- new_data[,1:2]
  y <- new_data[,3]
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_2[j] <- ichimura_calc (X,y,h.ichimura)$beta.hat[2]
  mc.beta.KS_2[j] <- KS_calc (X,y,h.KS)$beta.hat[2]
}

write.csv(mc.beta.ichimura_2, file = "ichimura_2.csv")
write.csv(mc.beta.KS_2, file = "KS_2.csv")

######################  3  #####################
mc.beta.ichimura_3 <- rep(NA,M)
mc.beta.KS_3 <- rep(NA,M)

for(j in 1:M){
##Generate x and y sample:
  x_1<-rnorm(n)
  x_2<-rnorm(n)
  X<-cbind(x_1,x_2)
  e<-0.75*rnorm(n)+0.25*rnorm(n,mean=0,sd=0.25)
  m<- X %*% beta.true - e 
  y<-m>0
##Impose a trimming function:
  new_data <- data.trim(X,y)
  X <- new_data[,1:2]
  y <- new_data[,3]
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_3[j] <- ichimura_calc (X,y,h.ichimura)$beta.hat[2]
  mc.beta.KS_3[j] <- KS_calc (X,y,h.KS)$beta.hat[2]
}

write.csv(mc.beta.ichimura_3, file = "ichimura_3.csv")
write.csv(mc.beta.KS_3, file = "KS_3.csv")

######################  4  #####################
mc.beta.ichimura_4 <- rep(NA,M)
mc.beta.KS_4 <- rep(NA,M)

for(j in 1:M){
##Generate x and y sample:
  x_1<-rexp(n)
  x_2<-rexp(n)
  X<-cbind(x_1,x_2)
  e<-0.75*rnorm(n)+0.25*rnorm(n,mean=0,sd=0.25)
  m<- X %*% beta.true - e 
  y<-m>0
##Impose a trimming function:
  new_data <- data.trim(X,y)
  X <- new_data[,1:2]
  y <- new_data[,3]
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_4[j] <- ichimura_calc (X,y,h.ichimura)$beta.hat[2]
  mc.beta.KS_4[j] <- KS_calc (X,y,h.KS)$beta.hat[2]
}

write.csv(mc.beta.ichimura_4, file = "ichimura_4.csv")
write.csv(mc.beta.KS_4, file = "KS_4.csv")

######################  5  #####################
mc.beta.ichimura_5 <- rep(NA,M)
mc.beta.KS_5 <- rep(NA,M)

for(j in 1:M){
##Generate x and y sample:
  x_1<-rnorm(n)
  x_2<-rnorm(n)
  X<-cbind(x_1,x_2)
  e<-0.75*rnorm(n,mean=-0.5,sd=1)+0.25*rnorm(n,mean=1.5,sd=2.5)
  m<- X %*% beta.true - e 
  y<-m>0
##Impose a trimming function:
  new_data <- data.trim(X,y)
  X <- new_data[,1:2]
  y <- new_data[,3]
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_5[j] <- ichimura_calc (X,y,h.ichimura)$beta.hat[2]
  mc.beta.KS_5[j] <- KS_calc (X,y,h.KS)$beta.hat[2]
}

write.csv(mc.beta.ichimura_5, file = "ichimura_5.csv")
write.csv(mc.beta.KS_5, file = "KS_5.csv")
######################  6  #####################
mc.beta.ichimura_6 <- rep(NA,M)
mc.beta.KS_6 <- rep(NA,M)

for(j in 1:M){
##Generate x and y sample:
  x_1<-rexp(n)
  x_2<-rexp(n)
  X<-cbind(x_1,x_2)
  e<-0.75*rnorm(n,mean=-0.5,sd=1)+0.25*rnorm(n,mean=1.5,sd=2.5)
  m<- X %*% beta.true - e 
  y<-m>0
##Impose a trimming function:
  new_data <- data.trim(X,y)
  X <- new_data[,1:2]
  y <- new_data[,3]
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_6[j] <- ichimura_calc (X,y,h.ichimura)$beta.hat[2]
  mc.beta.KS_6[j] <- KS_calc (X,y,h.KS)$beta.hat[2]
}

write.csv(mc.beta.ichimura_6, file = "ichimura_6.csv")
write.csv(mc.beta.KS_6, file = "KS_6.csv")
###########################################################################
#plot histogram of monte carlo simulation

par(mfrow=c(2,6))
hist(mc.beta.ichimura_1,breaks = 50, main="ichimura_1")
hist(mc.beta.ichimura_2,breaks = 50, main="ichimura_2")
hist(mc.beta.ichimura_3,breaks = 50, main="ichimura_3")
hist(mc.beta.ichimura_4,breaks = 50, main="ichimura_4")
hist(mc.beta.ichimura_5,breaks = 50, main="ichimura_5")
hist(mc.beta.ichimura_6,breaks = 50, main="ichimura_6")


hist(mc.beta.KS_1,breaks = 50, main="KS_1")
hist(mc.beta.KS_2,breaks = 50, main="KS_2")
hist(mc.beta.KS_3,breaks = 50, main="KS_3")
hist(mc.beta.KS_4,breaks = 50, main="KS_4")
hist(mc.beta.KS_5,breaks = 50, main="KS_5")
hist(mc.beta.KS_6,breaks = 50, main="KS_6")


###########################################################################
#define mean squared error from monte carlo and compare ichimura and KS


mse_ichimura_1=sum( (mc.beta.ichimura_1-(beta.true[2]/beta.true[1]))^2  )/M
mse_ichimura_2=sum( (mc.beta.ichimura_2-(beta.true[2]/beta.true[1]))^2  )/M
mse_ichimura_3=sum( (mc.beta.ichimura_3-(beta.true[2]/beta.true[1]))^2  )/M
mse_ichimura_4=sum( (mc.beta.ichimura_4-(beta.true[2]/beta.true[1]))^2  )/M
mse_ichimura_5=sum( (mc.beta.ichimura_5-(beta.true[2]/beta.true[1]))^2  )/M
mse_ichimura_6=sum( (mc.beta.ichimura_6-(beta.true[2]/beta.true[1]))^2  )/M

mse_KS_1=mean(mc.beta.KS_1-(beta.true[2]/beta.true[1]))^2
mse_KS_2=mean(mc.beta.KS_2-(beta.true[2]/beta.true[1]))^2  
mse_KS_3=mean(mc.beta.KS_3-(beta.true[2]/beta.true[1]))^2  
mse_KS_4=mean(mc.beta.KS_4-(beta.true[2]/beta.true[1]))^2 
mse_KS_5=mean(mc.beta.KS_5-(beta.true[2]/beta.true[1]))^2 
mse_KS_6=mean(mc.beta.KS_6-(beta.true[2]/beta.true[1]))^2 


mse_ichimura <- cbind(mse_ichimura_1,mse_ichimura_2,mse_ichimura_3,
                      mse_ichimura_4,mse_ichimura_5,mse_ichimura_6)
mse_KS <- cbind(mse_KS_1,mse_KS_2,mse_KS_3,mse_KS_4,mse_KS_5,mse_KS_6)

write.csv(mse_ichimura, file = "mse_ichimura.csv")
write.csv(mse_KS, file = "mse_KS.csv")

