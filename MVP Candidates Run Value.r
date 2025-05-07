# Load required libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

batters_df <- read_csv("https://raw.githubusercontent.com/Stat184-Spring2025/Sec1_FP_Andrew_Owen_Nick/main/2019-batters.csv")

# MVP candidates 
mvp_candidates <- c(
  "Bellinger, Cody", "Trout, Mike", "Yelich, Christian", "Bregman, Alex", "Rendon, Anthony",
  "Semien, Marcus", "Marte, Ketel", "LeMahieu, DJ", "Acuña Jr., Ronald", "Bogaerts, Xander",
  "Arenado, Nolan", "Alonso, Pete", "Freeman, Freddie", "Chapman, Matt", "Springer, George",
  "Betts, Mookie", "Cruz, Nelson", "Soto, Juan", "Devers, Rafael", "Donaldson, Josh"
)

# MVP vote order
mvp_vote_order <- c(
  "Bellinger, Cody", "Trout, Mike", "Yelich, Christian", "Bregman, Alex", "Rendon, Anthony",
  "Semien, Marcus", "Marte, Ketel", "LeMahieu, DJ", "Acuña Jr., Ronald", "Bogaerts, Xander",
  "Arenado, Nolan", "Alonso, Pete", "Freeman, Freddie", "Chapman, Matt", "Springer, George",
  "Betts, Mookie", "Cruz, Nelson", "Soto, Juan", "Devers, Rafael", "Donaldson, Josh"
)

# Filter and reshape data
mvp_long <- batters_df %>%
  filter(`last_name, first_name` %in% mvp_candidates) %>%
  select(`last_name, first_name`, runs_heart, runs_shadow, runs_chase, runs_waste) %>%
  pivot_longer(cols = starts_with("runs_"),
               names_to = "zone",
               values_to = "runs") %>%
  mutate(zone = gsub("runs_", "", zone))

# Apply MVP order for plotting
mvp_long$`last_name, first_name` <- factor(
  mvp_long$`last_name, first_name`,
  levels = rev(mvp_vote_order) 
)

# Plot
ggplot(mvp_long, aes(x = `last_name, first_name`, y = runs, fill = zone)) +
  geom_col(position = position_dodge2(preserve = "single", padding = 0.1), width = 0.75) +
  coord_flip() +
  labs(
    title = "MVP Candidates - Run Value by Zone (2019)",
    x = "Player (MVP Vote Order)", y = "Run Value", fill = "Zone"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "top",
    axis.text.y = element_text(size = 10, margin = margin(r = 10))
  )
