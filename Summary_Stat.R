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

summary_Group <- by(data_long$value,data_long$Group, function (X) round(stat.desc(X),2))
summary_Time <- by(data_long$value,data_long$variable, function (X) round(stat.desc(X),2) )

print(summary_Group)
print(summary_Time)

   