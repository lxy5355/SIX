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
beta.true<-c(1,7.6)

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

m.grid<- seq(min(X %*% beta.hat.ichimura), max(X %*% beta.hat.ichimura), len=500)

plot( m.grid,m.grid>0,col="red",main=c("true (red) data and y from estimated g function (black)"), 
  ylim=range(sin(m.grid),g.hat.ichimura(m.grid)),type="p")
points(m[order(m)],g.hat.ichimura(m[order(m)]), type="p")


####################################################################
#define loss function and compare ichimura and KS

sum((sin(m[order(m)]/4) -  g.hat(m[order(m)]) )^2)

#########################################################################
#monte carlo
M = 100   #number of monte carlo simulation
n = 30    # Sample Size
z <- rep(NA,M)
beta_vec<-c(1,7.6) #true beta


## MC-Experiments:
for(j in 1:M){
##Generate x and y sample:
  x_1<-rnorm(N,mean=10,sd=1.5)
  x_2<-rnorm(N,mean=5,sd=1)
  X<-cbind(x_1,x_2)
  m<-X %*% beta_vec
  y<-sin(m)+runif(N,-1,1)
## Compute jth realization of Z:
  estimates=nlm(min_SSE_Gaussian,c(1,1),X=X,y=y,h=bandwidth)$estimate
  estimates_norm = estimates/estimates[1]
  z[j] <- estimates_norm[2] 
}

#plot histogram
hist(z,breaks = 25)
