source("ichimura_functions.R") 
source("KS_functions.R") 

#########################################################################
#monte carlo simulation
#true parameters

M = 10 #number of monte carlo simulation
n = 50    # Sample Size
beta.true<-c(-2,1) #true beta
h=.2

######################  1  #####################
mc.beta.ichimura_1 <- rep(NA,M)
mc.beta.KS_1 <- rep(NA,M)

for(j in 1:M){
##Generate x and y sample:
  x_1<-rnorm(n)
  x_2<-rnorm(n)
  X<-cbind(x_1,x_2)
  e<-rnorm(n)
  m<- X %*% beta.true + e 
  y<-m>0         
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_1[j] <- ichimura_calc (X,y,h)$beta.hat[2]
  mc.beta.KS_1[j] <- KS_calc (X,y,h)$beta.hat[2]
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
  m<- X %*% beta.true + e 
  y<-m>0         
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_2[j] <- ichimura_calc (X,y,h)$beta.hat[2]
  mc.beta.KS_2[j] <- KS_calc (X,y,h)$beta.hat[2]
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
  m<- X %*% beta.true + e 
  y<-m>0         
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_3[j] <- ichimura_calc (X,y,h)$beta.hat[2]
  mc.beta.KS_3[j] <- KS_calc (X,y,h)$beta.hat[2]
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
  m<- X %*% beta.true + e 
  y<-m>0         
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_4[j] <- ichimura_calc (X,y,h)$beta.hat[2]
  mc.beta.KS_4[j] <- KS_calc (X,y,h)$beta.hat[2]
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
  m<- X %*% beta.true + e 
  y<-m>0         
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_5[j] <- ichimura_calc (X,y,h)$beta.hat[2]
  mc.beta.KS_5[j] <- KS_calc (X,y,h)$beta.hat[2]
}

######################  6  #####################
mc.beta.ichimura_6 <- rep(NA,M)
mc.beta.KS_6 <- rep(NA,M)

for(j in 1:M){
##Generate x and y sample:
  x_1<-rexp(n)
  x_2<-rexp(n)
  X<-cbind(x_1,x_2)
  e<-0.75*rnorm(n,mean=-0.5,sd=1)+0.25*rnorm(n,mean=1.5,sd=2.5)
  m<- X %*% beta.true + e 
  y<-m>0         
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_6[j] <- ichimura_calc (X,y,h)$beta.hat[2]
  mc.beta.KS_6[j] <- KS_calc (X,y,h)$beta.hat[2]
}

###########################################################################
#plot histogram of monte carlo simulation

par(mfrow=c(2,1))
hist(mc.beta.ichimura_1,breaks = 50)
hist(mc.beta.KS_1,breaks = 50)

###########################################################################
#define loss function from monte carlo and compare ichimura and KS

mc.e.ichimura<-mc.beta.ichimura_1-beta.true
mc.loss.ichimura<-sum((mc.e.ichimura)^2)/M

mc.e.KS<-mc.beta.KS_1-beta.true
mc.loss.KS<-sum((mc.e.KS)^2)/M




