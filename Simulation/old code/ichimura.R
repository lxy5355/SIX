# Set parameters for true model
set.seed(109)
N<-300
x_1<-rnorm(N,mean=10,sd=1.5)
x_2<-rnorm(N,mean=5,sd=1)
X<-cbind(x_1,x_2)
beta_vec<-c(1,7.6)
m<-X %*% beta_vec

# Construct reponsive variable y with function sine based on single index m 
# and uniformly distributed errors.
y<-sin(m)+runif(N,-1,1)

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
    u <- sweep(X,2,X[i,])[-i,]%*%b_vec
    kde=normal_kde(u,h)
    estimate <- y[-i]%*%kde / sum(kde)
    g_i[i] <- estimate
    }
  return(g_i)
}


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



# Minimize the objective function, look for a best extimate for beta_vec.
estimates=nlm(min_SSE_Gaussian,c(1,1),X=X,y=y,h=bandwidth)$estimate
estimates_norm = estimates/estimates[1]

#approximate function g
g<-approxfun(m, g_i(X,y,estimates_norm,.2), method = "linear", rule = 1, ties = mean)

#plot generated data 
plot(m,y,col="red",main=c("true (red) data and y from estimated g function (black)"))
par(new=TRUE)
#plot(m,g_i,col="green")
par(new=TRUE)
plot(m,g(m))



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
