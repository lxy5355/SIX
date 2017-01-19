#install.packages("NMOF")
library("NMOF")

#########################################################################

# Define Gaussian kernel function.
normal_kde <- function(u,h){
  res <- (1/sqrt(2 *pi)) * exp(-0.5 * ((u/h)^2))
  return(res)
}

# Define leave-one-out estimator g
g_i <- function(X,y,b_vec,h) {
  g_i <- (1:nrow(X))*NA
  for (i in 1:nrow(X)){
    u <- sweep(X,2,X[i,])[-i,]%*%b_vec
    kde <- normal_kde(u,h)
    estimate <- y[-i]%*%kde / sum(kde)
    g_i[i] <- estimate
  }
  return(g_i)
}


# Define the objective minimizing function of sum-of-squared errors,
# Use Gaussian kernel function.
min_SSE_Gaussian <- function(X,y,b_vec,h) {
  g_i <- (1:nrow(X))*NA
  for (i in 1:nrow(X)){
    u <- sweep(X,2,X[i,])[-i,]%*%b_vec
    kde=normal_kde(u,h)
    estimate <- y[-i]%*%kde / sum(kde)
    g_i[i] <- estimate
    sse <-t(y-g_i)%*%(y-g_i)    #only this line is different from the function g_i
    }
  return(sse)
}


# Define function to estimate beta.hat and g.hat
ichimura_calc <- function(X,y,h) {

  opt.test <- gridSearch(fun=function(x){min_SSE_Gaussian(X=X,y=y,b_vec=x,h=h)},
	                     levels=append(1,rep(list(seq(0,20,len=40)),ncol(X)-1)) )
                                          
  beta.hat <- opt.test$minlevels
  g.hat <-approxfun(X%*%beta.hat, g_i(X,y,beta.hat,h), method = "linear", rule = 1, ties = mean)
  returnlist <- list(g.hat=g.hat,beta.hat=beta.hat)
}

