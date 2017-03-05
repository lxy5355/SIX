

##################################
#ichimura methods
##################################

ichimura <- ichimura_calc (xtrain,ytrain,h)
g.hat.ichimura = ichimura$g.hat
beta.hat.ichimura = ichimura$beta.hat

# accuracy rate for training sample
y.hat = g.hat.ichimura(xtrain%*%beta.hat.ichimura)
table(ytrain, y.hat>.5)
#(401+461)/nrow(xtrain)

# accuracy rate for test sample
y.test.hat = g.hat.ichimura(xtest%*%beta.hat.ichimura)
table(ytest, y.test.hat>.5)
#(904+1063)/nrow(xtest)

##################################
#KS methods
##################################
KS <- KS_calc (xtrain,ytrain,h)
g.hat.KS = KS$g.hat
beta.hat.KS = KS$beta.hat

# accuracy rate for training sample
y.hat.KS = g.hat.KS(xtrain%*%beta.hat.KS)>.5
table(ytrain, y.hat.KS)
#(1022+1030)/nrow(xtrain)

# accuracy rate for test sample
y.test.hat.KS = g.hat.KS(xtest%*%beta.hat.KS)>.5
table(ytest, y.test.hat.KS)
#(440+441)/nrow(xtest)



##########################################################################
#try out code

x1 = rnorm(100)
x2 = rnorm(100)
x3 = rnorm(100)
x4 = rnorm(100)
x5 = rnorm(100)
x6 = rnorm(100)
x7 = rnorm(100)
x8 = rnorm(100)
x9 = rnorm(100)
x10 = rnorm(100)
x11 = rnorm(100)
x12 = rnorm(100)
x13 = rnorm(100)
x14 = rnorm(100)
x15 = rnorm(100)
x16 = rnorm(100)
x17 = rnorm(100)
x18 = rnorm(100)
x19 = rnorm(100)
x20 = rnorm(100)
x=cbind(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20)
b = (1:20)
y=1:100
ichimura = ichimura_calc(X=x,y=y,h=.1)
npindex = npindex(x,y)
