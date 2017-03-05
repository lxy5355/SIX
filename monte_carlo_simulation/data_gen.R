source("ichimura_functions.R") 
source("KS_functions.R") 

###############################################################
#generate data

#first simulation: only continuous variables for x and monotonic funtional form for g.

#Set parameters for true model
set.seed(109)
N<-300
x_1<-rnorm(N,mean=-7,sd=2.5)
x_2<-rnorm(N,mean=1,sd=.5)
x_3<-rnorm(N,mean=2,sd=.5)
X<-cbind(x_1,x_2,x_3)
beta.true<-c(1,7.6,5)

#construct linear single index
m<-X %*% beta.true 

#construct a simple true link function g as m^2 plus an error following standard normal distribution.
e<- rnorm(N,mean=0,sd=1)
y<- m^2 + e    
#plot(m,y)

#select bandwidth for estimator
h <- .5

#employ the idea of data trimming: for all b_vec in a compact set B,
#keep the term p_n(X_i%*%b_vec) from arbitrarily getting close to zero.
b_2<-seq(0.1,10,len=20)
b_3<-seq(0.1,10,len=20)

for (b2 in b_2){
  for (b3 in b_3){
    b_vec <- c(1,b2,b3)
    X_new <- double()
    y_new <- double()
    for (i in 1:nrow(X)){
      u <- sweep(X,2,X[i,])[-i,] %*% b_vec
      kde <- normal_kde(u,h)
      if (sum(kde)>1){
        X_new <- rbind(X_new,X[i,])
        y_new <- rbind(y_new,y[i])
      }
    }
    X <- X_new
    y <- y_new
  }
}

m<-X %*% beta.true
##################################################################
#estimations

estimates.ichimura = ichimura_calc (X_new,y_new,h)
g.hat.ichimura = estimates.ichimura$g.hat
beta.hat.ichimura = estimates.ichimura$beta.hat

estimates.KS = KS_calc (X,y,h)
g.hat.KS = estimates.KS$g.hat
beta.hat.KS = estimates.KS$beta.hat


####################################################################
#plot results 

m.grid<- seq(min(X %*% beta.hat.ichimura), max(X %*% beta.hat.ichimura), len=500)

plot(m.grid,exp(m.grid),col="red",main=c("true (red) data and y from estimated g function (black)"), 
      ylim=range((exp(40)), exp(80)), type="p")
points(m[order(m)],g.hat.ichimura(m[order(m)]), type="p")

###################################################################



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
