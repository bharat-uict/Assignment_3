
install.packages('tidyverse')


library(ggplot2)
library(dplyr)
library(tidyr)
#load the dataset
df = read.csv("TextMessages.csv")

#reshape data from wide to long format
df_long = df %>%
  pivot_longer(cols = c(Baseline, Six_months), 
               names_to = "Time", 
               values_to = "TextMessages")

#create faceted boxplot
ggplot(df_long, aes(x = as.factor(Group), y = TextMessages, fill = as.factor(Group))) +
  geom_boxplot() +
  facet_wrap(~ Time) + 
  labs(title = "Distribution of Text Messages by Group and Time",
       x = "Group",
       y = "Number of Text Messages") +
  theme_minimal() +
  scale_fill_manual(values = c("blue", "orange"))

#create faceted bar chart
ggplot(df_long, aes(x = as.factor(Group), y = TextMessages, fill = as.factor(Group))) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.2, position = position_dodge(width = 0.9)) +
  facet_wrap(~ Time) + 
  labs(title = "Average Text Messages by Group and Time",
       x = "Group",
       y = "Average Number of Text Messages") +
  theme_minimal() +
  scale_fill_manual(values = c("blue", "orange"))
