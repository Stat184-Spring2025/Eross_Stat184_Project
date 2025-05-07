library(tidyverse)
library(ggplot2)

RVData <- read.table(
  file = "~/Documents/GitHub/MLB_Awards_Project/2019-batters.csv", 
  sep =",",
  header = TRUE) %>%
  separate(last_name..first_name, into = c("Last_Name", "First_Name"), sep = ", ")

Raw_NL_MVP <- read.table(
  file = "~/Documents/GitHub/MLB_Awards_Project/2019NLMVP.csv",
  header = FALSE,
  sep = ",",
)
NL_MVP_Header <- read.table(
  file = "~/Documents/GitHub/MLB_Awards_Project/2019NLMVP.csv",
  header = FALSE,
  sep = ",",
  skip = 1,
  nrows = 1
)
NL_MVP <- read.table(
  file = "~/Documents/GitHub/MLB_Awards_Project/2019NLMVP.csv",
  header = FALSE,
  sep = ",",
  skip = 2,
  col.names = as.character(unlist(NL_MVP_Header))
) %>%
  select(1:19) %>%
  filter(AB > 100) %>%
  separate(Name, into = c("First_Name", "Last_Name"), sep = " ") %>%
  mutate(Last_Name = ifelse(Last_Name == "SuÃ¡rez", "Suárez", Last_Name)) %>%
  mutate(Last_Name = ifelse(Last_Name == "AcuÃ±a", "Acuña Jr.", Last_Name)) %>%
  rename('1st.Place.Votes' = X1st.Place) %>%
  inner_join(RVData, by = c("First_Name", "Last_Name")) %>%
  select(-player_id, -year, -pitches, -team_id)



ggplot(NL_MVP, aes(x = runs_all, y = Vote.Pts, label = paste(First_Name, Last_Name))) +
  geom_point(color = "blue", size = 3) +                
  geom_text(vjust = -0.5, hjust = 0.5, size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(
    title = "MVP Vote Points vs Offensive Run Value",
    x = "Offensive Run Value (All)",
    y = "MVP Vote Points"
  ) +
  theme_minimal()

model_nlmvp_rv <- lm(Vote.Pts ~ runs_all, data = NL_MVP)
rsq_nlmvp_rv<- summary(model_nlmvp_rv)$r.squared
print(rsq_nlmvp_rv)

ggplot(NL_MVP, aes(x = WAR, y = Vote.Pts, label = paste(First_Name, Last_Name))) +
  geom_point(color = "blue", size = 1) +                 # Plot points
  geom_text(vjust = -0.5, hjust = 0.5, size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(
    title = "MVP Vote Points vs Offensive Run Value",
    x = "Offensive Run Value (All)",
    y = "MVP Vote Points"
  ) +
  theme_minimal()

model_nlmvp_war <- lm(Vote.Pts ~ WAR, data = NL_MVP)
rsq_nlmvp_war<- summary(model_nlmvp_war)$r.squared
print(rsq_nlmvp_war)

  
