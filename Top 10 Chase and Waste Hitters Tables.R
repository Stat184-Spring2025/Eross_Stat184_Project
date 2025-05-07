# Load libraries
library(dplyr)
library(readr)

# Read the CSV file (use raw GitHub link or local file path if needed)
batters_df <- read_csv("https://raw.githubusercontent.com/Stat184-Spring2025/Sec1_FP_Andrew_Owen_Nick/main/2019-batters.csv")

# List of 2019 MVP candidate names (as they appear in CSV)
mvp_candidates <- c(
  "Bellinger, Cody", "Yelich, Christian", "Rendon, Anthony", "Marte, Ketel", "Acuña Jr., Ronald",
  "Arenado, Nolan", "Alonso, Pete", "Freeman, Freddie", "Soto, Juan", "Donaldson, Josh",
  "Trout, Mike", "Bregman, Alex", "Semien, Marcus", "LeMahieu, DJ", "Bogaerts, Xander",
  "Chapman, Matt", "Springer, George", "Betts, Mookie", "Cruz, Nelson", "Devers, Rafael"
)

# List of 2019 Silver Sluggers (as they appear in CSV)
silver_sluggers <- c(
  "Greinke, Zack", "Realmuto, J.T.", "Freeman, Freddie", "Albies, Ozzie", "Rendon, Anthony", "Story, Trevor",
  "Bellinger, Cody", "Yelich, Christian", "Acuña Jr., Ronald",
  "Garver, Mitch", "Santana, Carlos", "LeMahieu, DJ", "Bregman, Alex", "Bogaerts, Xander",
  "Betts, Mookie", "Trout, Mike", "Springer, George", "Cruz, Nelson"
)

#add flags for MVP and Silver Slugger
batters_df <- batters_df %>%
  mutate(
    `Top Ten MVP` = `last_name, first_name` %in% mvp_candidates,
    `Silver Slugger` = `last_name, first_name` %in% silver_sluggers
  )

# Top 10 CHASE zone hitters
top_chase <- batters_df %>%
  select(`Last, First` = `last_name, first_name`, runs_chase, runs_all, `Top Ten MVP`, `Silver Slugger`) %>%
  arrange(desc(runs_chase)) %>%
  slice_head(n = 10)

# Top 10 WASTE zone hitters
top_waste <- batters_df %>%
  select(`Last, First` = `last_name, first_name`, runs_waste, runs_all, `Top Ten MVP`, `Silver Slugger`) %>%
  arrange(desc(runs_waste)) %>%
  slice_head(n = 10)

# View results
cat("Top 10 Hitters in CHASE Zone:\n")
print(top_chase)

cat("\nTop 10 Hitters in WASTE Zone:\n")
print(top_waste)

View((top_chase))
