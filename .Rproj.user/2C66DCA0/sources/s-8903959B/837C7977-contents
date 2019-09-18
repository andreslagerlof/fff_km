# Load libraries
library(tidyverse)
library(readxl)

# Import result dataset
comp1 <- read_excel("C:/Users/AndrésLagerlöf/OneDrive - Andrés Lagerlöf Konsulttjänst AB/Övrigt/Fäktning/KM/KM_webb/fff_km/KM_deltävlingar.xlsx")
View(comp1)

# Add new variable "points"
tot <- comp1 %>% mutate(points = case_when(
  Place == 1 ~ 25,
  Place == 2 ~ 22,
  Place == 3 ~ 19,
  Place == 4 ~ 17,
  Place == 5 ~ 15,
  Place == 6 ~ 13,
  Place == 7 ~ 12,
  Place == 8 ~ 11,
  Place == 9 ~ 10,
  Place == 10 ~ 9,
  Place == 11 ~ 8,
  Place == 12 ~ 7,
  Place == 13 ~ 6,
  Place == 14 ~ 5,
  Place == 15 ~ 4,
  Place == 16 ~ 3,
  Place == 17 ~ 2,
  TRUE ~ 1
))
View(tot)

# Create tabel output using kableExtra package
kable(tot) %>%
  kable_styling(bootstrap_options = "striped", full_width = F, position = "left")

# Create a table with the DT package
datatable( tot,
           colnames = c("Namn" = "Name", "Placering" = "Place", "Poäng" = "points"),
           caption = "Tabell 1: Placering efter KM, deltävling 1", 
           options = list(pageLength = 18)) %>%
          formatStyle('Poäng',  color = 'steelblue', fontWeight = 'bold') 
