# Set parameters for true model
set.seed(109)


N  <-300
x_1<-rnorm(N,mean=10,sd=1.5)
x_2<-rnorm(N,mean=5,sd=1)
X  <-cbind(x_1,x_2)
beta_vec<-c(1,7.6)
m  <- X %*% beta_vec

# Construct reponsive variable y with function sine based on single index m 
# and uniformly distributed errors.
y<-sin(m/4)+runif(N,-1,1)

#select bandwidth for estimator
bandwidth<-.1


# Gaussian kernel function.
normal_kde <- function(u,h){
  res <- (1/sqrt(2 *pi)) * exp(-0.5 * ((u/h)^2))
  return(res)
}

## Define leave-one-out estimator g,
# Use Gaussian kernel function.
g_i <- function(X,y,b_vec,h) {
  g_i <- (1:N)*NA
  for (i in 1:N){
  	## i <- 1
    u        <- sweep(X,2,X[i,])[-i,]%*%b_vec
    kde      <- normal_kde(u,h)
    estimate <- y[-i]%*%kde / sum(kde)
    g_i[i]   <- estimate
    }
  return(g_i)
}

## check 
## g_i(X=X,y=y,b_vec=beta_vec,h=0.25)



# Define the objective minimizing function of sum-of-squared errors,
# Use Gaussian kernel function.
min_SSE_Gaussian <- function(X,y,b_vec,h) {
  g_i <- (1:N)*NA
  for (i in 1:N){
    u <- sweep(X,2,X[i,])[-i,]%*%b_vec
    kde=normal_kde(u,h)
    estimate <- y[-i]%*%kde / sum(kde)
    g_i[i] <- estimate
    sse <-t(y-g_i)%*%(y-g_i)    #only this line is different from the function g_i
    }
  return(sse)
}
## check 
## min_SSE_Gaussian(X=X,y=y,b_vec=beta_vec,h=0.25)

## install.packages("NMOF")
library("NMOF")

opt.test <- gridSearch(fun=function(x){min_SSE_Gaussian(X=X,y=y,b_vec=x,h=0.5)},
	                     levels=list(1,  # evaluation-grid for beta[1]
	       	                         seq(0,20,len=40))) # evaluation-grid for beta[2]


beta.hat <- opt.test$minlevels

## chosen normalization:
beta.hat/beta.hat[1]


















# Minimize the objective function, look for a best extimate for beta_vec.
estimates=nlm(min_SSE_Gaussian,rnorm(2,sd=1),X=X,y=y,h=0.4)$estimate
(estimates_norm = estimates/estimates[1])

#approximate function g
g.hat <-approxfun(X%*%estimates_norm, g_i(X,y,estimates_norm,.2), method = "linear", rule = 1, ties = mean)

#plot generated data 

m.grid<- seq(min(m), max(m), len=500)

plot( m.grid,sin(m.grid/4),col="red",main=c("true (red) data and y from estimated g function (black)"), 
  ylim=range(sin(m.grid),g.hat(m)),type="b")
points(m[order(m)],g.hat(m[order(m)]), type="p")


sum((sin(m[order(m)]/4) -  g.hat(m[order(m)]) )^2)



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
