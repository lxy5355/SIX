source("ichimura_functions.R") 
source("KS_functions.R") 

###############################################################
#generate data

# Set parameters for true model
N<-300
x_1<-rnorm(N)
x_2<-rexp(N)
X<-cbind(x_1,x_2)
beta.true<-c(-2,1)

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

