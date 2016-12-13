# Construct single index m = x_1*beta_1+x_2*beta_2. Given x_1 and x_2 mutually independent,
# m_i is iid with normal distribution N(15,2.5).
set.seed(109)
N<-300
x_1<-rnorm(N,mean=10,sd=1.5)
x_2<-rnorm(N,mean=5,sd=1)
X<-cbind(x_1,x_2)
beta.vec<-c(1,7.6)
m<-X %*% beta.vec

# Construct reponsive variable y with function sine based on single index m 
# and uniformly distributed errors.
y<-sin(m)+runif(N,-1,1)


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
    sse <-t(y-g_i)%*%(y-g_i)
    }
  return(sse)
}



# Minimize the objective function, look for a best extimate for beta.vec.
estimates=nlm(min_SSE_Gaussian,c(1,1),X=X,y=y,h=.2)$estimate


#approximate function g
g<-approxfun(m, g_i(X,y,estimates,.2), method = "linear", rule = 1, ties = mean)

#plot generated data 
plot(m,y,col="red",main=c("true (red) data and y from estimated g function (black)"))
par(new=TRUE)
#plot(m,g_i,col="green")
par(new=TRUE)
plot(m,g(m))
