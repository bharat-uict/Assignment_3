# Install necessary packages 

install.packages("tidyverse")
install.packages("pastecs")
install.packages("reshape2")

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(pastecs)
library(reshape2)

# Load the dataset
df <- read.csv("TextMessages.csv")

# Reshape data from wide to long format
df_long <- df %>%
  pivot_longer(cols = c(Baseline, Six_months), 
               names_to = "Time", 
               values_to = "TextMessages")

# ------------------------
# Visualization 1: Faceted Boxplot
# ------------------------
ggplot(df_long, aes(x = as.factor(Group), y = TextMessages, fill = as.factor(Group))) +
  geom_boxplot() +
  facet_wrap(~ Time) + 
  labs(title = "Distribution of Text Messages by Group and Time",
       x = "Group",
       y = "Number of Text Messages") +
  theme_minimal() +
  scale_fill_manual(values = c("blue", "orange"))

# ------------------------
# Visualization 2: Faceted Bar Chart with Error Bars
# ------------------------
ggplot(df_long, aes(x = as.factor(Group), y = TextMessages, fill = as.factor(Group))) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.2, 
               position = position_dodge(width = 0.9)) +
  facet_wrap(~ Time) + 
  labs(title = "Average Text Messages by Group and Time",
       x = "Group",
       y = "Average Number of Text Messages") +
  theme_minimal() +
  scale_fill_manual(values = c("blue", "orange"))

# ------------------------
# Summary Statistics using pastecs
# ------------------------

# Using melt() for pastecs-based stats
data_long <- melt(df, id = c("Group", "Participant"), measured = c("Baseline", "Six_months"))

# Summary by Group
summary_Group <- by(data_long$value, data_long$Group, function(X) round(stat.desc(X), 2))

# Summary by Time
summary_Time <- by(data_long$value, data_long$variable, function(X) round(stat.desc(X), 2))

# Print summaries
print(summary_Group)
print(summary_Time)
``