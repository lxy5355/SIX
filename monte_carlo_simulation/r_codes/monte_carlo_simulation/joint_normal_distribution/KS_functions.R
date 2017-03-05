#install.packages("NMOF")
library("NMOF")

#define fourth-order Gaussian kernel function
normal_kde <- function(u,h){
  res <- (1/2)*(3-u^2)*((1/sqrt(2 *pi)) * exp(-0.5 * ((u/h)^2)))
  return(res)
}

#add a floor to avoid taking log of zero (estimate=0 or 1-estimate=0)
kleinspadyFloor <- sqrt(.Machine$double.eps)

#define leave-one-out estimator g which uses Gaussian kernel function
g_i <- function(X,y,b_vec,h) {
  g_i <- (1:nrow(X))*NA
  for (i in 1:nrow(X)){
    u <- sweep(X,2,X[i,])[-i,]%*%b_vec
    kde=normal_kde(u,h)
    estimate <- y[-i]%*%kde / sum(kde)
    estimate[which(estimate < kleinspadyFloor)] <- kleinspadyFloor
    estimate[which(estimate > 1 - kleinspadyFloor)] <- 1 - kleinspadyFloor
    g_i[i] <- estimate
    }
  return(g_i)
}

#define the objective minimizing function of sum-of-loglikelihood,which uses Gaussian kernel function.
loglike <- function(X,y,b_vec,h) {
  g_i <- (1:nrow(X))*NA
  for (i in 1:nrow(X)){
    u <- sweep(X,2,X[i,])[-i,]%*%b_vec
    kde=normal_kde(u,h)
    estimate <- y[-i]%*%kde / sum(kde)
    estimate[which(estimate < kleinspadyFloor)] <- kleinspadyFloor
    estimate[which(estimate > 1 - kleinspadyFloor)] <- 1 - kleinspadyFloor
    g_i[i] <- estimate
    L <-log(g_i)%*%y + log(1-g_i)%*%(1-y)    #only this line is different from the function g_i
    }
  return(-L)
}

#define function to estimate beta.hat and g.hat
KS_calc <- function(X,y,h) {
  opt.test <- gridSearch(fun=function(x){loglike(X=X,y=y,b_vec=x,h=h)},
	                     levels=append(1,rep(list(seq(-4,0,len=81)),ncol(X)-1)) )
  beta.hat <- opt.test$minlevels
  g.hat <-approxfun(X%*%beta.hat, g_i(X,y,beta.hat,h), method = "linear", rule = 1, ties = mean)
  returnlist <- list(g.hat=g.hat,beta.hat=beta.hat)
}


