# Construct single index m = x_1*beta_1+x_2*beta_2. Given x_1 and x_2 mutually independent,
# m_i is iid with normal distribution N(15,2.5).
set.seed(109)
N<-100
x_1<-rnorm(N,mean=10,sd=1.5)
x_2<-rnorm(N,mean=5,sd=2)
X<-cbind(x_1,x_2)
beta.vec<-c(1,-5)
m<-X %*% beta.vec

# Construct reponsive variable y with function sine based on single index m 
# and uniformly distributed errors.
y<-sin(m)+runif(length(m),-1,1)

# Gaussian kernel function.
normal_kde <- function(u,h){
  res <- (1/sqrt(2 *pi)) * exp(-0.5 * (u/h)^2)
  return(res)
}

# Epanechnikov kernel function.
epanech_kern_f  <- function(u,h){
  ifelse(abs(u)<=1,( 3/ 4)*(1-(u/h)^2),0)
}
# Construct the matrix of data.
data <- cbind(X,y)

# Define the objective minimizing function of sum-of-squared errors,
# Use Gaussian kernel function.
min_SSE_Gaussian <- function(data,b_vec,h) {
  n <- nrow(data)
  sse <- 0
  g_i <- c(NA,n)
  for (i in 1:n){
    new_data <- data[-i,]
    kde <- c(NA,nrow(new_data))
    for (j in 1:nrow(new_data)){
      u <- ((new_data[j,1:2]-data[i,1:2]) %*% b_vec)
      kde[j]=normal_kde(u,h)
    }
    estimate <- kde %*% new_data[,3] / sum(kde)
    g_i[i] <- estimate
  }
  sse <- sum((data[i,3]-g_i[i])^2)
  return(sse)
}

# Define the objective minimizing function of sum-of-squared errors,
# Use Epanechnikov kernel function.
min_SSE_Epa <- function(data,b_vec,h) {
  n <- nrow(data)
  sse <- 0
  g_i <- c(NA,n)
  for (i in 1:n){
    new_data <- data[-i,]
    kde <- c(NA,nrow(new_data))
    for (j in 1:nrow(new_data)){
      u <- ((new_data[j,1:2]-data[i,1:2]) %*% b_vec)
      kde[j]=epanech_kern_f(u,h)
    }
    estimate <- kde %*% new_data[,3] / sum(kde)
    g_i[i] <- estimate
  }
  sse <- sum((data[i,3]-g_i[i])^2)
  return(sse)
}
# Minimize the objective function, look for a best extimate for beta.vec.
result=optim(par=c(1,2),min_SSE_Gaussian(data,par,4))
