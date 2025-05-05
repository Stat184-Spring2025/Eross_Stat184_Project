library(tidyverse)
library(rvest)
library(dplyr)
SSNLRawList <- read_html(x = "https://www.baseball-reference.com/awards/silver_slugger_nl.shtml") %>%
  html_elements(css = "table") %>%
  html_table()
SSNLData <- bind_rows(SSNLRawList)
SSNLData <- SSNLData %>%
  mutate(Year = str_extract(`Year & Common`, "^\\d{4}"))
SSNL2019 <- SSNLData %>%
  filter(Year == "2019")
SSALRawList <- read_html(x = "https://www.baseball-reference.com/awards/silver_slugger_al.shtml") %>%
  html_elements(css = "table") %>%
  html_table()
SSALData <- bind_rows(SSALRawList)
SSALData <- SSALData %>%
  mutate(Year = str_extract(`Year & Common`, "^\\d{4}"))
SSAL2019 <- SSALData %>%
  filter(Year == "2019")
SSNL2019 <- SSNL2019 %>%
  mutate(League = "NL")
SSAL2019 <- SSAL2019 %>%
  mutate(League = "AL")
SS2019 <- bind_rows(SSNL2019, SSAL2019)
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
View(SS2019_long)
