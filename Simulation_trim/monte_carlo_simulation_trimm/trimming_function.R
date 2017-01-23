source("ichimura_functions.R")

data.trim <- function(X,y) {

b_2<-seq(0,20,len=40)
for (b2 in b_2){
    b_vec <- c(1,b2)
    n <- nrow(X)
    i <- 1
    while (i<=n){
      u <- sweep(X,2,X[i,])[-i,] %*% b_vec
      kde <- normal_kde(u,h)
      if (sum(kde)<0.01){
        X <- X[-i,]
        y <- y[-i]
        n <- n - 1
        #print(i)
      }else{
        i <- i + 1
      }
    }
  } 
  new_data <- cbind(X,y)
  return(new_data)
}
