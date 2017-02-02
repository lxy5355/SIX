library(caTools)
library(np)

#need to adapt data import path
data <- read.csv('C:/Users/lxy53/Documents/GitHub/SIX/empirical/voice.csv')

# Create a train and test set.
set.seed(777)
spl <- sample.split(data$label, 0.7)
train <- subset(data, spl == TRUE)
test <- subset(data, spl == FALSE)

ytrain = (train$label == "male")*1  #convert y data to binary
ytest = (test$label == "male")*1

xtrain = as.matrix( within(train,rm(label)) )
colnames(xtrain) = NULL
rownames(xtrain) = NULL
xtrain = cbind(xtrain[,1:5],xtrain[,7:11],xtrain[,13:18],xtrain[,20])  #remove multicoliearity

xtest = as.matrix(  within(test,rm(label)) )
colnames(xtest) = NULL
rownames(xtest) = NULL
xtest = cbind(xtest[,1:5],xtest[,7:11],xtest[,13:18],xtest[,20])


###################################
# Logistic regression model.
###################################

genderLog <- glm(label ~ ., data=train, family='binomial')
predictLog <- predict(genderLog, type='response')
predictLog2 <- predict(genderLog, newdata=test, type='response')

##################################
#np-package
##################################

bw.ichimura <- npindexbw(xdat=xtrain, ydat=ytrain)
model.ichimura <- npindex(bws=bw.ichimura)
fit.ichimura <- predict(model.ichimura)
test.ichimura <- fitted(npindex(exdat=xtest, bws=bw.ichimura))

bw.KS <- npindexbw(xdat=xtran, ydat=ytrain,method="kleinspady")
model.KS <- npindex(bws=bw.KS,method="kleinspady")
fit.KS <- predict(model.KS)
test.KS <- fitted(npindex(exdat=xtest,bws=bw.KS,method="kleinspady"))

###################################
#draw graphs and tables
###################################
m.ichimura = xtrain%*%model.ichimura$beta
m.KS = xtrain%*%model.KS$beta

xfit=cbind(rep(1,nrow(xtrain)),xtrain)
b=unname(genderLog$coefficients,force=FALSE)
b=na.omit(b)   
m.log=xfit%*%b


m2.ichimura = xtest%*%model.ichimura$beta
m2.KS = xtest%*%model.KS$beta

xfit2=cbind(rep(1,nrow(xtest)),xtest)  
m2.log=xfit2%*%b


par(mfrow=c(4,2))
plot(m.log,predictLog,col="blue")
title(main = "comparison of methods on training set")
points(m.ichimura,fit.ichimura,col="red")
points(m.KS,fit.KS,col="green")

plot(m2.log,predictLog2,col="blue")
title(main = "comparison of methods on test set")
points(m2.ichimura,test.ichimura,col="red")
points(m2.KS,test.KS,col="green")

plot(m.ichimura,ytrain)
title(main = "ichimura on training set")
points(m.ichimura,fit.ichimura,col="red")

plot(m2.ichimura,ytest)
title(main = "ichimura on test set")
points(m2.ichimura,test.ichimura,col="red")

plot(m.log,ytrain)
title(main = "logistic on training set")
points(m.log,predictLog,col="blue")

plot(m2.log,ytest)
title(main = "logistic on test set")
points(m2.log,predictLog2,col="blue")

plot(m.KS,ytrain)
title(main = "kleinspady on training set")
points(m.KS,fit.KS,col="green")

plot(m2.KS,ytest)
title(main = "kleinspady on test set")
points(m2.KS,test.KS,col="green")

#######table#######
log1 = table(train$label, predictLog >= 0.5)
ichimura1 = table(ytrain,fit.ichimura>=.5)
ks1 = table(ytrain,fit.KS>=.5)

log2 = table(test$label, predictLog2 >= 0.5)
ichimura2 = table(ytest,test.ichimura>=.5)
ks2 = table(ytest,test.KS>=.5)

table = cbind(log1,ichimura1,ks1,log2,ichimura2,ks2)