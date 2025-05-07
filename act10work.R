# Tidy Armed Forces Data ----
## Create Data Frame: case as group of soldiers
## Include Rank, Sex, Pay Grade, Branch

# Load Packages ----
library(tidyverse)
library(rvest)
library(googlesheets4)

# Scrape Rank Data ----
webRanks <- read_html("https://neilhatfield.github.io/Stat184_PayGradeRanks.html") %>%
  html_elements(css = "table") %>%
  html_table()

rawRanks <- webRanks[[1]] # Extract the data frame of ranks

# Wrangle Rank Data ----
## Enter a value in the first cell (1, 1)
rawRanks[1, 1] <- "Type"
## Extract actual column headers
rankHeaders <- rawRanks[1, ]
## Apply headers as column names
names(rawRanks) <- rankHeaders[1,]
## Remove redundant first row and last row
rawRanks <- rawRanks[-c(1, 26), ]

cleanRanks <- rawRanks %>%
  dplyr::select(!Type) %>% # Remove extra column
  pivot_longer(
    cols = !`Pay Grade`, # The improper name requires backticks
    names_to = "Branch",
    values_to = "Rank"
  ) %>%
  mutate(
    Rank = na_if(x = Rank, y = "--")
  )

# Load Armed Forces Data ----
gs4_deauth()
forcesHeaders <- read_sheet(
  ss = "https://docs.google.com/spreadsheets/d/1cn4i0-ymB1ZytWXCwsJiq6fZ9PhGLUvbMBHlzqG4bwo/edit?usp=sharing",
  col_names = FALSE, # Turn off Column Names
  n_max = 3 # read only the first three rows
)

rawForces <- read_sheet(
  ss = "https://docs.google.com/spreadsheets/d/1cn4i0-ymB1ZytWXCwsJiq6fZ9PhGLUvbMBHlzqG4bwo/edit?usp=sharing",
  col_names = FALSE, # Turn off Column Names
  skip = 3, # Skip the first three rows
  n_max = 28, # Read only the next 28 rows; drops footer
  col_types = "c" # Tells R to read everything as character data
)

# Wrangle Armed Forces Data ----
## Create good column names ----
### Pattern is Pay Grade followed by 3 columns for each branch in the order
### Army, Navy, Marine Corp, Air Force, Space Force, and Total
branchNames <- rep( # Create three copies of each branch
  x = c("Army", "Navy", "Marine Corps", "Air Force", "Space Force", "Total"),
  each = 3
)
tempHeaders <- paste( # Combine branch with other headers
  c("", branchNames),
  forcesHeaders[3,],
  sep = "."
)

names(rawForces) <- tempHeaders

cleanForces <- rawForces %>%
  rename(Pay.Grade = `.Pay Grade`) %>%
  dplyr::select(!contains("Total")) %>% # Remove total columns
  filter(Pay.Grade != "Total Enlisted" &
           Pay.Grade != "Total Warrant Officers" &
           Pay.Grade != "Total Officers" &
           Pay.Grade != "Total") %>% # Remove total rows; see note below
  pivot_longer( # Reshape data
    cols = !Pay.Grade,
    names_to = "Branch.Sex",
    values_to = "Frequency"
  ) %>%
  separate_wider_delim( # Separate branches and sex
    cols = Branch.Sex,
    delim = ".",
    names = c("Branch", "Sex")
  ) %>%
  mutate(
    Frequency = na_if(Frequency, y = "N/A*"), # Convert N/A* to missing
    Frequency = parse_number(Frequency) # Parse values as numbers
  )

# Merge Data Frames ----
key_forcesRanks <- left_join(
  x = cleanForces,
  y = cleanRanks,
  by = join_by(Pay.Grade == `Pay Grade`, Branch == Branch)
) 

# Filter and reshape data
# Focusing on just the Navy branch, and its Enlisted members
# Enlisted members are those with Pay Grades beginning with E
table <- key_forcesRanks %>%
  filter(Branch == "Navy") %>%
  filter(str_detect(Pay.Grade, "E")) %>%
  group_by(Sex, Rank) %>%
  summarise(Frequency = sum(Frequency), .groups = 'drop') %>%
  pivot_wider(names_from = Rank, values_from = Frequency, values_fill = 0)

# Add row totals
table <- table %>%
  mutate(Total = rowSums(across(where(is.numeric))))

# Add column totals (i.e., "Total" row)
totals_row <- table %>%
  summarise(across(where(is.numeric), sum)) %>%
  mutate(Sex = "Total") %>%
  relocate(Sex)

# Bind total row to the table
final_table <- bind_rows(table, totals_row)

# test



