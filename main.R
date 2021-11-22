# Creat my dataset
library(dplyr)
library(purrr)



# Import the Data set
computerByHome <- read.csv(file = "Database/ComputersByHome.csv")
computerByHome$NAME <- do.call(paste, c(computerByHome[c("LOCATION", "TIME")], sep = " "))


employeement <- read.csv(file = "Database/Employeement.csv")
employeement$NAME <- do.call(paste, c(employeement[c("LOCATION", "TIME")], sep = " "))
EMP <- employeement[c("NAME","Value" )]

exports <- read.csv(file = "Database/Exports.csv")
exports$NAME <- do.call(paste, c(exports[c("LOCATION", "TIME")], sep = " "))
EXP <- exports[c("NAME","Value" )]

internetAcess <- read.csv(file = "Database/InternetAcess.csv")
internetAcess$NAME <- do.call(paste, c(internetAcess[c("LOCATION", "TIME")], sep = " "))

investment <- read.csv(file = "Database/Investiment.csv")
investment$NAME <- do.call(paste, c(investment[c("LOCATION", "TIME")], sep = " "))
INV <- investment[c("NAME","Value" )]

researches <- read.csv(file = "Database/Researches.csv")
indicator <- c("PC_GDP"," ")
researches <- filter(researches, researches$MEASURE %in% indicator)
researches$NAME <- do.call(paste, c(researches[c("LOCATION", "TIME")], sep = " "))
RES <- researches[c("NAME","Value" )]


temp1 <- merge(CBH, INV, by="NAME")
df <- merge(temp1, RES, by="NAME")
colnames(df) <-c("Local", "Computador","Investimento", "Pesquisa")

med <- quantile(df$Computador, 0.5)
df$Computador[df$Computador < med] <- 0
df$Computador[df$Computador > med] <- 1

write.csv(df, file = "./Database/DataFrame.csv", row.names=FALSE)
source("RegLog.R")