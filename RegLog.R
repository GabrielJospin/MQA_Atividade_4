library(ggplot2)

data <- read.csv("./Database/DataFrame.csv")
summary(data)

modrl <- glm(Computador ~ Pesquisa+Investimento, data = data,family = binomial)
summary(modrl)

prev.data <- predict(modrl, data, type = "response")
str(prev.data)
plot(prev.data, data$Computador)
newdata <- data.frame(CompNovo=seq(min(data$Pesquisa), max(data$Pesquisa), len=length(data$Pesquisa)))
newdata$CompPred <- predict(modrl, data, type = "response")

plot(sort(CompPred) ~sort(CompNovo), newdata)
ggplot(data, aes(x=Pesquisa+Investimento, y=Computador)) + geom_point(alpha=.5) + stat_smooth(method="glm", se=FALSE, method.args=list(family=binomial))
ggplot(data, aes(x=Pesquisa, y=Computador)) + geom_point(alpha=.5) + stat_smooth(method="glm", se=FALSE, method.args=list(family=binomial))
ggplot(data, aes(x=Investimento, y=Computador)) + geom_point(alpha=.5) + stat_smooth(method="glm", se=FALSE, method.args=list(family=binomial))
plot(data$Pesquisa, prev.data, col="steelblue")
plot(data$Computador, fitted(glm(Computador~Pesquisa, data, family=binomial)))
plot(data$Computador, fitted(glm(Computador~Investimento, data, family=binomial)))
plot(data$Computador, prev.data, col="steelblue")

matconf <- table(data$Computador, round(predict(modrl, data, type = "response")))
result = sum(diag(matconf)/sum(matconf))
print(result*100)

matComp <- table(data$Computador, rep(0, length(data$Computador)))
comp = sum(diag(matComp)/sum(matComp))
print(comp*100)

print(matconf)
print(matComp)