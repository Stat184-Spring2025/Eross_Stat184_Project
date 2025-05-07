# Load required libraries
library(tidyverse)
library(rvest)
library(dplyr)
library(knitr)
# Scrape NL Silver Slugger Data from Baseball reference
SSNLRawList <- read_html(x = "https://www.baseball-reference.com/awards/silver_slugger_nl.shtml") %>%
  html_elements(css = "table") %>%
  html_table()
SSNLData <- bind_rows(SSNLRawList)
# Extract 2019 year from 'Year & Common' column
SSNLData <- SSNLData %>%
  mutate(Year = str_extract(`Year & Common`, "^\\d{4}"))
SSNL2019 <- SSNLData %>%
  filter(Year == "2019")
# Scrape AL Silver Slugger Data from Baseball Reference
SSALRawList <- read_html(x = "https://www.baseball-reference.com/awards/silver_slugger_al.shtml") %>%
  html_elements(css = "table") %>%
  html_table()
SSALData <- bind_rows(SSALRawList)
# Extract 2019 year from 'Year & Common' column
SSALData <- SSALData %>%
  mutate(Year = str_extract(`Year & Common`, "^\\d{4}"))
SSAL2019 <- SSALData %>%
  filter(Year == "2019")
# Label leagues
SSNL2019 <- SSNL2019 %>%
  mutate(League = "NL")
SSAL2019 <- SSAL2019 %>%
  mutate(League = "AL")
# Combine AL and NL data
SS2019 <- bind_rows(SSNL2019, SSAL2019)
# Reshape data from wide to long format for positions
SS2019_long <- SS2019 %>%
  pivot_longer(
    cols = c("P", "C", "1B", "2B", "3B", "SS", "OF...7", "OF...8", "OF...9", "OF...10", "DH", "Utility"),
    names_to = "Position",
    values_to = "Player"
  ) %>%
  filter(Player != "") %>%
  mutate(Position = as.character(Position),   
         Position = ifelse(grepl("^OF", Position), "OF", Position)) %>% 
  select(Year, League, Player, Position)
# Load 2019 batters data from baseball savant
batters2019 <- read.csv("C:\\Users\\owass\\OneDrive - The Pennsylvania State University\\Documents\\GitHub\\Sec1_FP_Andrew_Owen_Nick\\2019-batters.csv")
# Rename player column for consistency and ease when merging data frames
colnames(batters2019)[colnames(batters2019) == "last_name..first_name"] <- "Player"
# Drop unnecessary columns
batters2019 <- batters2019 %>%
  select(-c(player_id, team_id, pa, pitches))
# Convert player names to characters to edit 
SS2019_long$Player <- as.character(SS2019_long$Player)
# Manually edit names to match the data from baseball savant
SS2019_long$Player[grepl("Greinke", SS2019_long$Player)] <- "Greinke, Zack"
SS2019_long$Player[grepl("Realmuto", SS2019_long$Player)] <- "Realmuto, J.T."
SS2019_long$Player[grepl("Freeman", SS2019_long$Player)] <- "Freeman, Freddie"
SS2019_long$Player[grepl("Albies", SS2019_long$Player)] <- "Albies, Ozzie"
SS2019_long$Player[grepl("Rendon", SS2019_long$Player)] <- "Rendon, Anthony"
SS2019_long$Player[grepl("Story", SS2019_long$Player)] <- "Story, Trevor"
SS2019_long$Player[grepl("Bellinger", SS2019_long$Player)] <- "Bellinger, Cody"
SS2019_long$Player[grepl("Acuña", SS2019_long$Player)] <- "Acuña Jr., Ronald"
SS2019_long$Player[grepl("Yelich", SS2019_long$Player)] <- "Yelich, Christian"
SS2019_long$Player[grepl("Garver", SS2019_long$Player)] <- "Garver, Mitch"
SS2019_long$Player[grepl("Santana", SS2019_long$Player)] <- "Santana, Carlos"
SS2019_long$Player[grepl("LeMahieu", SS2019_long$Player)] <- "LeMahieu, DJ"
SS2019_long$Player[grepl("Bregman", SS2019_long$Player)] <- "Bregman, Alex"
SS2019_long$Player[grepl("Bogaerts", SS2019_long$Player)] <- "Bogaerts, Xander"
SS2019_long$Player[grepl("Trout", SS2019_long$Player)] <- "Trout, Mike"
SS2019_long$Player[grepl("Betts", SS2019_long$Player)] <- "Betts, Mookie"
SS2019_long$Player[grepl("Springer", SS2019_long$Player)] <- "Springer, George"
SS2019_long$Player[grepl("Cruz", SS2019_long$Player)] <- "Cruz, Nelson"
# Merge data frames to display each silver slugger and their run values
merged_data <- inner_join(SS2019_long, batters2019, by = "Player")
merged_data <- merged_data %>%
  select(-c(year))
# Create table to show relationships
kable(merged_data)
write.csv(merged_data, "merged_silver_sluggers_2019.csv", row.names = FALSE)

