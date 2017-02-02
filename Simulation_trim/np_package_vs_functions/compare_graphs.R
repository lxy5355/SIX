beta_ich_fun=read.csv("mc_beta_ich_fun.csv",header=TRUE)
beta_ks_fun=read.csv("mc_beta_ks_fun.csv",header=TRUE)
beta_ich_np=read.csv("mc_beta_ich_np.csv",header=TRUE)
beta_ks_np=read.csv("mc_beta_ks_np.csv",header=TRUE)


#########################################################################
par(mfrow=c(2,2))
hist(beta_ich_fun$x,breaks = 30, main="beta_ich_fun")
hist(beta_ks_fun$x,breaks = 30, main="beta_ks_fun")
hist(beta_ich_np$x,breaks = 50, main="beta_ich_np", xlim = range(beta_ich_fun$x))
hist(beta_ks_np$x,breaks = 50, main="beta_ks_np", xlim = range(beta_ks_fun$x))

