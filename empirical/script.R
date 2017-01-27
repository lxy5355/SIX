library(caTools)
#library(rpart)
#library(rpart.plot)
source ("ichimura_functions.R")
source ("KS_functions.R")

data <- read.csv('C:/Users/lxy53/Documents/GitHub/SIX/empirical/voice.csv')

# Create a train and test set.
set.seed(777)
spl <- sample.split(data$label, 0.7)
train <- subset(data, spl == TRUE)
test <- subset(data, spl == FALSE)

h=.1
###############
# Basline model (always predict male).
###############

print('Baseline model')

# Accuracy: 0.50
table(train$label)
1109/nrow(train)

# Accuracy: 0.50
table(test$label)
475/nrow(test)

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
#ichimura methods
##################################

ytrain = train$label == "male"  #convert y data to binary
ytest = test$label == "male"

xtrain = as.matrix( within(train,rm(label)) )
colnames(xtrain) = NULL
rownames(xtrain) = NULL
xtest = as.matrix(  within(test,rm(label))  )
colnames(xtest) = NULL
rownames(xtest) = NULL

ichimura <- ichimura_calc (xtrain,ytrain,h)
g.hat.ichimura = ichimura$g.hat
beta.hat.ichimura = ichimura$beta.hat

# accuracy rate for training sample
y.hat = g.hat.ichimura(xtrain%*%beta.hat.ichimura)>.5
table(ytrain, y.hat)
(1030+1045)/nrow(xtrain)

# accuracy rate for test sample
y.test.hat = g.hat.ichimura(xtest%*%beta.hat.ichimura)>.5
table(ytest, y.test.hat)
(446+451)/nrow(xtest)

##################################
#KS methods
##################################
KS <- KS_calc (xtrain,ytrain,h)
g.hat.KS = KS$g.hat
beta.hat.KS = KS$beta.hat

# accuracy rate for training sample
y.hat.KS = g.hat.KS(xtrain%*%beta.hat.KS)>.5
table(ytrain, y.hat.KS)
(1022+1030)/nrow(xtrain)

# accuracy rate for test sample
y.test.hat.KS = g.hat.KS(xtest%*%beta.hat.KS)>.5
table(ytest, y.test.hat.KS)
(440+441)/nrow(xtest)

##########################################################################
#try out code

grid.min <- min(genderLog$coefficients,na.rm=TRUE)
grid.max <- max(genderLog$coefficients,na.rm=TRUE)


x1 = rnorm(100)
x2 = rnorm(100)
x3 = rnorm(100)
x4 = rnorm(100)
y = x1*2+x2*3+x3*4+x4*5>0
x=cbind(x1,x2,x3,x4)
ichimura = ichimura_calc(X=x,y=y,h=.2)

