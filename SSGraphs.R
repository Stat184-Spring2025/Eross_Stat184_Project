library(ggplot2)
batters <- merged_data
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