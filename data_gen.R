source("ichimura_functions.R") 
source("KS_functions.R") 

###############################################################
#generate data

# Set parameters for true model
set.seed(109)
N<-300
x_1<-rnorm(N,mean=-7,sd=2.5)
x_2<-rnorm(N,mean=1,sd=.5)
X<-cbind(x_1,x_2)
beta.true<-c(1,7)

# assume true distribution function g of the error is normal
e<- rnorm(N,mean=0,sd=1)
m<-X %*% beta.true + e 
y = m>0         

#select bandwidth for estimator
h <-.1

##################################################################
#estimations

estimates.ichimura = ichimura_calc (X,y,h)
g.hat.ichimura = estimates.ichimura$g.hat
beta.hat.ichimura = estimates.ichimura$beta.hat

estimates.KS = KS_calc (X,y,h)
g.hat.KS = estimates.KS$g.hat
beta.hat.KS = estimates.KS$beta.hat


####################################################################
#plot results 

par(mfrow=c(2,1))

m.grid<- seq(min(X %*% beta.hat.ichimura), max(X %*% beta.hat.ichimura), len=500)
plot( m.grid,m.grid>0,col="red",main=c("Ichimura: true (red) data and y from estimated g function (black)"), 
      ylim=range(m.grid>0,g.hat.ichimura(m.grid)),type="p")
points(m[order(m)],g.hat.ichimura(m[order(m)]), type="p")

m.grid<- seq(min(X %*% beta.hat.KS), max(X %*% beta.hat.KS), len=500)
plot( m.grid,m.grid>0,col="red",main=c("KS: true (red) data and y from estimated g function (black)"), 
      ylim=range(m.grid>0,g.hat.KS(m.grid)),type="p")
points(m[order(m)],g.hat.KS(m[order(m)]), type="p")

####################################################################
#define loss function and compare ichimura and KS

e.ichimura = na.omit((m[order(m)]>0) -  g.hat.ichimura(m[order(m)]))
loss.ichimura = sum((e.ichimura)^2)/length(e.ichimura)

e.KS = na.omit((m[order(m)]>0) -  g.hat.KS(m[order(m)]))
loss.KS = sum((e.KS)^2)/length(e.KS)

#########################################################################
#monte carlo simulation

M = 1000 #number of monte carlo simulation
n = 30    # Sample Size
mc.beta.ichimura <- rep(NA,M)
mc.beta.KS <- rep(NA,M)
beta.true<-c(1,7.6) #true beta


#ichimura:
for(j in 1:M){
##Generate x and y sample:
  x_1<-rnorm(N,mean=10,sd=1.5)
  x_2<-rnorm(N,mean=5,sd=1)
  X<-cbind(x_1,x_2)
  e<-rnorm(N,mean=0,sd=1)
  m<-X %*% beta.true + e 
  y<-m>0         
## Compute jth realization of mc.beta.ichimura and mc.beta.KS:
  mc.beta.ichimura[j] <- ichimura_calc (X,y,h)$beta.hat[2]
  mc.beta.KS[j] <- KS_calc (X,y,h)$beta.hat[2]
}


###########################################################################
#plot histogram of monte carlo simulation

par(mfrow=c(2,1))
hist(mc.beta.ichimura,breaks = 50)
hist(mc.beta.KS,breaks = 50)

###########################################################################
#define loss function from monte carlo and compare ichimura and KS

mc.e.ichimura<-mc.beta.ichimura-beta.true
mc.loss.ichimura<-sum((mc.e.ichimura)^2)/M

mc.e.KS<-mc.beta.KS-beta.true
mc.loss.KS<-sum((mc.e.KS)^2)/M

save(mc.beta.KS, file = "mc_beta_KS_1000m_30n")
save(mc.beta.ichimura, file = "mc_beta_ichimura_1000m_30n")

