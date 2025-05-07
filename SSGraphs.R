# Load ggplot2 library for graph making
library(ggplot2)
# adjust data name for simplicity
batters <- read.csv("merged_silver_sluggers_2019.csv")
# Graph displaying relationship between total runs and waste zone runs
ggplot(batters) +
  aes(x = runs_all, y = runs_waste, label = Player) +
  geom_label() +
  labs(
    x = "Total Runs",
    y = "Waste Zone Runs",
    title = "Total Runs vs. Waste Runs"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))
# Graph displaying relationship between total runs and shadow zone runs
ggplot(batters) +
  aes(x = runs_all, y = runs_shadow, label = Player) +
  geom_label() +
  labs(
    x = "Total Runs",
    y = "Shadow Zone Runs",
    title = "Total Runs vs. Shadow Runs"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))
# Graph displaying relationship between total runs and chase zone runs
ggplot(batters) +
  aes(x = runs_all, y = runs_chase, label = Player) +
  geom_label() +
  labs(
    x = "Total Runs",
    y = "Chase Zone Runs",
    title = "Total Runs vs. Chase Runs"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))
# Graph displaying relationship between total runs and heart zone runs
ggplot(batters) +
  aes(x = runs_all, y = runs_heart, label = Player) +
  geom_label() +
  labs(
    x = "Total Runs",
    y = "Heart Zone Runs",
    title = "Total Runs vs. Heart Runs"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))