library(caTools)
library(np)
source ("ichimura_functions.R")
source ("KS_functions.R")

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
xtest = as.matrix(  within(test,rm(label))  )
colnames(xtest) = NULL
rownames(xtest) = NULL

#xtrain=scale(xtrain)

h=.2


###################################
# Logistic regression model.
###################################

print('Logistic regression model')

genderLog <- glm(label ~ ., data=train, family='binomial')

# Accuracy: 0.9711
predictLog <- predict(genderLog, type='response')
table(train$label, predictLog >= 0.5)
(1073+1081)/nrow(train)

# Accuracy: 0.9789
predictLog2 <- predict(genderLog, newdata=test, type='response')
table(test$label, predictLog2 >= 0.5)
(462+468)/nrow(test)

##################################
#np-package, does not work
##################################

ichimura.racine = npindex(xtrain,ytrain,method="ichimura")
KS.racine = npindex(xtrain,ytrain,method="kleinspady")


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

##############################
#draw graph
##############################
xfit=cbind(rep(1,nrow(xtrain)),xtrain)
b=unname(genderLog$coefficients,force=FALSE)
b[is.na(b)] = 0
m.log=xfit%*%b

m.ichimura=xtrain%*%beta.hat.ichimura
m.KS = xtrain%*%beta.hat.KS

par(mfrow=c(1,1))
plot(m.KS,ytrain)
points(m.KS,y.hat.KS,col="red")

plot(m.ichimura,ytrain)
points(m.ichimura,y.hat,col="red")

plot(m.log,ytrain)
points(m.log,predictLog,col="red")


##########################################################################
#try out code

x1 = rnorm(200)
x2 = rnorm(200)
#x3 = rnorm(200)
#x4 = rnorm(200)
y = x1*2+x2*3
x=cbind(x1,x2)
ichimura = ichimura_calc(X=x,y=y,h=.1)
npindex = npindex(x,y)
