library(reshape2)

MVP_Hitters <- rbind(AL_MVP, NL_MVP) %>%
  select(-Rank)

rows <- c("WAR", "runs_all")
cols <- c("BA", "OBP", "SLG", "OPS", "HR", "RBI")

Correlation_DF <- MVP_Hitters[, c(rows, cols)]

Correlation_Matrix <- cor(Correlation_DF, use = "complete.obs")

Correlation_Subset <- Correlation_Matrix[rows, cols]

Correlation_Long <- melt(Correlation_Subset)

ggplot(Correlation_Long, aes(x = Var2, y = Var1, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white",
                       midpoint = 0, limit = c(-1, 1),
                       name = "Correlation") +
  geom_text(aes(label = round(value, 2)), color = "black", size = 4) +
  theme_minimal() +
  labs(x = "", y = "", title = "WAR and Run Value vs Vote Getter Stats") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))