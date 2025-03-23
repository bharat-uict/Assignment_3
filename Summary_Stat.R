install.packages("tidyverse")
library(dplyr)
install.packages("reshape")
library(reshape)
install.packages("reshape2")
library(reshape2)
install.packages("pastecs")
library(pastecs)

data <- read.csv("TextMessages.csv")

data_long <- melt(data,id=c("Group","Participant"),measured=c("Baseline","Six_months"))

by(data_long$value,data_long$Group, function (X) round(stat.desc(X),2))
by(data_long$value,data_long$variable, function (X) round(stat.desc(X),2) )


   