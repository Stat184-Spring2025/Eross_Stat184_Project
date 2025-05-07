library(tidyverse)
library(ggplot2)

RVData <- read.table(
  file = "~/Documents/GitHub/MLB_Awards_Project/2019-batters.csv", 
  sep =",",
  header = TRUE) %>%
  separate(last_name..first_name, into = c("Last_Name", "First_Name"), sep = ", ")

Raw_AL_MVP <- read.table(
  file = "~/Documents/GitHub/MLB_Awards_Project/2019ALMVP.xls.csv",
  header = FALSE,
  sep = ",",
)
AL_MVP_Header <- read.table(
  file = "~/Documents/GitHub/MLB_Awards_Project/2019ALMVP.xls.csv",
  header = FALSE,
  sep = ",",
  skip = 1,
  nrows = 1
)
AL_MVP <- read.table(
  file = "~/Documents/GitHub/MLB_Awards_Project/2019ALMVP.xls.csv",
  header = FALSE,
  sep = ",",
  skip = 2,
  col.names = as.character(unlist(AL_MVP_Header))
) %>%
  select(1:19) %>%
  filter(AB > 100) %>%
  separate(Name, into = c("First_Name", "Last_Name"), sep = " ") %>%
  mutate(First_Name = ifelse(First_Name == "JosÃ©", "José", First_Name)) %>%
  mutate(First_Name = ifelse(First_Name == "YoÃ¡n", "Yoán", First_Name)) %>%
  rename('1st.Place.Votes' = X1st.Place) %>%
  inner_join(RVData, by = c("First_Name", "Last_Name")) %>%
  select(-player_id, -year, -pitches, -team_id)



ggplot(AL_MVP, aes(x = runs_all, y = Vote.Pts, label = paste(First_Name, Last_Name))) +
  geom_point(color = "#FF474C", size = 3) +                
  geom_text(vjust = -0.5, hjust = 0.5, size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "gray") +
  labs(
    title = "MVP Vote Points vs Offensive Run Value",
    x = "Offensive Run Value (All)",
    y = "MVP Vote Points"
  ) +
  theme_minimal()

model_almvp_rv <- lm(Vote.Pts ~ runs_all, data = AL_MVP)
rsq_almvp_rv<- summary(model_almvp_rv)$r.squared
print(rsq_almvp_rv)

ggplot(AL_MVP, aes(x = WAR, y = Vote.Pts, label = paste(First_Name, Last_Name))) +
  geom_point(color = "#B0E0E6", size = 3) +                 # Plot points
  geom_text(vjust = -0.5, hjust = 0.5, size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "gray") +
  labs(
    title = "MVP Vote Points vs Offensive Run Value",
    x = "Offensive Run Value (All)",
    y = "MVP Vote Points"
  ) +
  theme_minimal()

model_almvp_war <- lm(Vote.Pts ~ WAR, data = AL_MVP)
rsq_almvp_war<- summary(model_almvp_war)$r.squared
print(rsq_almvp_war)
