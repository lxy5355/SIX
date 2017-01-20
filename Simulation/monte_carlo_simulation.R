source("ichimura_functions.R") 
source("KS_functions.R") 

#########################################################################
#monte carlo simulation
#true parameters

M = 1000 #number of monte carlo simulation
n = 250    # Sample Size
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
#monte carlo simulation set 2
#true parameters

M = 1000 #number of monte carlo simulation
n = 250    # Sample Size
beta.true.2<-c(-2,7) #true beta
h=.2


######################  7  #####################
mc.beta.ichimura_7 <- rep(NA,M)
mc.beta.KS_7 <- rep(NA,M)

for(j in 1:M){
##Generate x and y sample:
  x_1<-rnorm(n)
  x_2<-rnorm(n)
  X<-cbind(x_1,x_2)
  e<-rnorm(n)
  m<- X %*% beta.true.2 + e 
  y<-m>0         
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_7[j] <- ichimura_calc (X,y,h)$beta.hat[2]
  mc.beta.KS_7[j] <- KS_calc (X,y,h)$beta.hat[2]
}



######################  8  #####################
mc.beta.ichimura_8 <- rep(NA,M)
mc.beta.KS_8 <- rep(NA,M)

for(j in 1:M){
##Generate x and y sample:
  x_1<-rexp(n)
  x_2<-rexp(n)
  X<-cbind(x_1,x_2)
  e<-rnorm(n)
  m<- X %*% beta.true.2 + e 
  y<-m>0         
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura_8[j] <- ichimura_calc (X,y,h)$beta.hat[2]
  mc.beta.KS_8[j] <- KS_calc (X,y,h)$beta.hat[2]
}


########################################################################

write.csv(mc.beta.ichimura_1, file = "ichimura_1.csv")
write.csv(mc.beta.ichimura_2, file = "ichimura_2.csv")
write.csv(mc.beta.ichimura_3, file = "ichimura_3.csv")
write.csv(mc.beta.ichimura_4, file = "ichimura_4.csv")
write.csv(mc.beta.ichimura_5, file = "ichimura_5.csv")
write.csv(mc.beta.ichimura_6, file = "ichimura_6.csv")
write.csv(mc.beta.ichimura_7, file = "ichimura_7.csv")
write.csv(mc.beta.ichimura_8, file = "ichimura_8.csv")

write.csv(mc.beta.KS_1, file = "KS_1.csv")
write.csv(mc.beta.KS_2, file = "KS_2.csv")
write.csv(mc.beta.KS_3, file = "KS_3.csv")
write.csv(mc.beta.KS_4, file = "KS_4.csv")
write.csv(mc.beta.KS_5, file = "KS_5.csv")
write.csv(mc.beta.KS_6, file = "KS_6.csv")
write.csv(mc.beta.KS_7, file = "KS_7.csv")
write.csv(mc.beta.KS_8, file = "KS_8.csv")


########################################################################
#define loss function from monte carlo and compare ichimura and KS

true parameters

loss_ichimura_1=sum( (mc.beta.ichimura_1-(beta.true[2]/beta.true[1]))^2  )/M
loss_ichimura_2=sum( (mc.beta.ichimura_2-(beta.true[2]/beta.true[1]))^2  )/M
loss_ichimura_3=sum( (mc.beta.ichimura_3-(beta.true[2]/beta.true[1]))^2  )/M
loss_ichimura_4=sum( (mc.beta.ichimura_4-(beta.true[2]/beta.true[1]))^2  )/M
loss_ichimura_5=sum( (mc.beta.ichimura_5-(beta.true[2]/beta.true[1]))^2  )/M
loss_ichimura_6=sum( (mc.beta.ichimura_6-(beta.true[2]/beta.true[1]))^2  )/M
loss_ichimura_7=sum( (mc.beta.ichimura_7-(beta.true.2[2]/beta.true.2[1]))^2  )/M
loss_ichimura_8=sum( (mc.beta.ichimura_8-(beta.true.2[2]/beta.true.2[1]))^2  )/M

loss_KS_1=sum( (mc.beta.KS_1-(beta.true[2]/beta.true[1]))^2  )/M
loss_KS_2=sum( (mc.beta.KS_2-(beta.true[2]/beta.true[1]))^2  )/M
loss_KS_3=sum( (mc.beta.KS_3-(beta.true[2]/beta.true[1]))^2  )/M
loss_KS_4=sum( (mc.beta.KS_4-(beta.true[2]/beta.true[1]))^2  )/M
loss_KS_5=sum( (mc.beta.KS_5-(beta.true[2]/beta.true[1]))^2  )/M
loss_KS_6=sum( (mc.beta.KS_6-(beta.true[2]/beta.true[1]))^2  )/M
loss_KS_7=sum( (mc.beta.KS_7-(beta.true.2[2]/beta.true.2[1]))^2  )/M
loss_KS_8=sum( (mc.beta.KS_8-(beta.true.2[2]/beta.true.2[1]))^2  )/M


loss_ichimura=cbind(loss_ichimura_1,loss_ichimura_2,loss_ichimura_3,loss_ichimura_4,
           loss_ichimura_5,loss_ichimura_6,loss_ichimura_7,loss_ichimura_8)

loss_KS=cbind(loss_KS_1,loss_KS_2,loss_KS_3,loss_KS_4,loss_KS_5,loss_KS_6,
         loss_KS_7,loss_KS_8)
