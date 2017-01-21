# Set parameters for true model
set.seed(109)
N<-300
x_1<-rnorm(N,mean=-7,sd=2.5)
x_2<-rnorm(N,mean=1,sd=.5)
X<-cbind(x_1,x_2)
beta_vec<-c(1,7.6)

# assume true distribution function g of the error is normal
e <- rnorm(N,mean=0,sd=1)
m <-X %*% beta_vec 
y = m > e         


#select bandwidth for estimator
#bandwidth<-.1


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



####################################################
dens.est <- density(m)
f.hat.fun<-splinefun(y=dens.est$y, x=dens.est$x) 
f.hat.fun(55)
####################################################



# Define the objective minimizing function of sum-of-squared errors,
# Use Gaussian kernel function.
loglike <- function(X,y,b_vec,h) {
  g_i <- (1:N)*NA
  for (i in 1:N){
    u <- sweep(X,2,X[i,])[-i,]%*%b_vec
    kde=normal_kde(u,h)
    estimate <- y[-i]%*%kde / sum(kde)
    g_i[i] <- estimate
    L <-log(g_i+0.0000001)%*%y + log(1-g_i+0.0000001)%*%(1-y)    #only this line is different from the function g_i
    }
  return(-L)
}


bandwidth <- 3


# Minimize the objective function, look for a best extimate for beta_vec.
estimates=nlm(loglike,c(1,10),X=X,y=y,h=bandwidth)$estimate
(estimates_norm = estimates/estimates[1])

#approximate function g
g<-approxfun( X%*%estimates_norm, g_i(X,y,estimates_norm, bandwidth), method = "linear", rule = 1, ties = mean)

#plot generated data 
plot(m,y,col="red",main=c("true (red) data and y from estimated g function (black)"), xlim=c(-3,3))
par(new=TRUE)
#plot(m,g_i,col="green")
par(new=TRUE)


plot(m[order(m)],g(m[order(m)]), type="b", xlim=c(-3,3))



#monte carlo
M = 50   #number of monte carlo simulation
n = 20    # Sample Size
z <- rep(NA, M)
beta_vec<-c(1,7.6) #true beta


## MC-Experiments:
for(j in 1:M){
##Generate x and y sample:
  x_1<-rnorm(N,mean=-7,sd=2.5)
  x_2<-rnorm(N,mean=1,sd=.5)
  X<-cbind(x_1,x_2)
# assume true distribution function g of the error is normal
  e<- rnorm(N,mean=0,sd=1)
  m<-X %*% beta_vec + e 
  y = m>0 
## Compute jth realization of Z:
  estimates=nlm(loglike,c(1,4),X=X,y=y,h=bandwidth)$estimate
  estimates_norm = estimates/estimates[1]
  z[j] <- estimates_norm[2] 
}

#plot histogram
hist(z,breaks = 25)
