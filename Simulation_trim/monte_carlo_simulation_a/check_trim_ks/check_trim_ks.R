source("ichimura_functions.R") 
source("KS_functions.R") 
source("trimming_function.R")

n <- 250
true.beta <- -2
h <- .2
set.seed(109)
x_1<-rnorm(n)
x_2<-rnorm(n)
X<-cbind(x_1,x_2)
y <- ifelse(x_1 + true.beta*x_2 - rnorm(n) > 0, 1, 0)
kleinspadyFloor <- sqrt(.Machine$double.eps)

g_i <- (1:nrow(X))*NA
for (i in 1:nrow(X)){
  u <- sweep(X,2,X[i,])[-i,]%*%c(1,true.beta)
  kde=normal_kde(u,h)
  estimate <- y[-i]%*%kde / sum(kde)
  ## Avoid taking log of zero (estimate=0 or 
  ## 1-estimate=0)
  estimate[which(estimate < kleinspadyFloor)] <- kleinspadyFloor
  estimate[which(estimate > 1 - kleinspadyFloor)] <- 1 - kleinspadyFloor
  g_i[i] <- estimate
  L <-log(g_i)%*%y + log(1-g_i)%*%(1-y)    
}
new_data <- data.trim(X,y)
X <- new_data[,1:2]
y <- new_data[,3]
write.csv(g_i,file = "check_ks_trim.csv")


