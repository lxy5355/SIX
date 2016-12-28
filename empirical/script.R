library(caTools)
#library(rpart)
#library(rpart.plot)
source ("ichimura_functions.R")

data <- read.csv('C:/Users/lxy53/Documents/GitHub/SIX/empirical part/voice.csv')

# Create a train and test set.
set.seed(777)
spl <- sample.split(data$label, 0.7)
train <- subset(data, spl == TRUE)
test <- subset(data, spl == FALSE)

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
genderLog <- ichimura
