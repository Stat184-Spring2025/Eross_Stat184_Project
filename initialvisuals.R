batters2019 <- `2019.batters`
library(dplyr)
# According to mlb.com a qualified hitter must have 3.1 plate appearances per 
# team games played on average. Equalling a minimum of about 502 PAs
batters_filtered <- batters2019 %>% 
  filter(pa >= 502)
View(batters_filtered)
# The numbers used from this summary are mean: 14.435, 3rdQ:26.420, Max:64.657
# These will be rounded
summary(batters_filtered)
# Since we are investigating the best hitters, we will narrow the data down 
# to only include the 3rd quartile
batters_filtered2 <- batters_filtered %>% 
  filter(runs_all >= 26)
View(batters_filtered2)
library(esquisse)
esquisser(data=batters_filtered,viewer="browser")

