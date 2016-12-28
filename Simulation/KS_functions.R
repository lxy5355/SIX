# Gaussian kernel function.
normal_kde <- function(u,h){
  res <- (1/sqrt(2 *pi)) * exp(-0.5 * ((u/h)^2))
  return(res)
}

# Define leave-one-out estimator g,
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


# Define function to estimate beta.hat and g.hat
KS_calc <- function(X,y,h) {
  opt.test <- gridSearch(fun=function(x){loglike(X=X,y=y,b_vec=x,h=h)},
	                     levels=append(1,rep(list(seq(0,20,len=40)),ncol(X)-1)) )
  beta.hat <- opt.test$minlevels
  g.hat <-approxfun(X%*%beta.hat, g_i(X,y,beta.hat,h), method = "linear", rule = 1, ties = mean)
  returnlist <- list(g.hat=g.hat,beta.hat=beta.hat)
}


