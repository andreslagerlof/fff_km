

# Create a long dataset
long_hist <- result_hist %>% gather(results, name, -1)
View(long_hist)



# Select relevant variables
long_hist1 <- long_hist %>% select(-results)
View(long_hist1)

# Rename variable
long_hist <- long_hist %>% rename(place = res)

# Change place variable to levels
long_hist$place <- factor(long_hist$place, ordered = TRUE,
                      levels = c("1:a", "2:a", "3:a"))

# Create dataframe with variables name, place and n for count
stat1 <- long_hist %>% group_by(name, place) %>% count()
View(stat1)

# Create df with name and no of entries
stat2 <- long_hist %>% group_by(name) %>% count() %>% arrange(desc(n)) 
View(stat2)

# Create datafreme with name, place and count of place
stat3 <- long_hist %>% group_by(name, place) %>% count() %>%arrange(desc(n)) %>%  arrange(place) #%>%  arrange(desc(n))
View(stat3)


# Change place variable to levels
stat3$place <- factor(stat3$place, ordered = TRUE,
                      levels = c("1:a", "2:a", "3:a"))

# Separate name variable in stat3 df
stat3 <- stat3 %>% separate(name, into = c("firstname", "lastname"))

# Winners
wins <- stat3 %>% filter(place == "1:a") %>% select(-lastname)
View(wins)

# Seconds
seconds <- stat3 %>% filter(place == "2:a") %>% select(-lastname)
View(seconds)

# Thirds
thirds <- stat3 %>% filter(place == "3:a") %>% select(-lastname)
View(thirds)


# Calculate no of years
long_hist$year %>%  n_distinct()

#### ----- Create plots

# Create barplot of top 3
stat2 %>%  
  ggplot( aes(x=reorder(name, n), n,)) + 
  geom_bar(stat = "identity", fill = "chocolate") + # , 
  theme_minimal() +
  coord_flip() +
  labs(title="Antal top 3 placeringar", 
       subtitle = "Perioden 2006 till 2018",
       caption = "Källa: Janne Tivenius",
       x= "Fäktare", 
       y="Antal top 3") +
  geom_text(aes(label = n), 
            hjust = -0.3, 
            color = "#1380A1") 

# Create barplot of winners
stat3 %>% filter(place == "1:a") %>% 
  ggplot( aes(x=reorder(firstname, n), n)) +
  geom_bar(stat = "identity", fill = "darkolivegreen") +
  theme_minimal()+
  coord_flip() +
  labs(title="Antal segrar per fäktare", 
       subtitle = "Perioden 2006 till 2018",
       caption = "Källa: Janne Tivenius",
       x= "Fäktare", 
       y="Antal segrar") +
  geom_text(aes(label = n), 
            hjust = -0.3, 
            color = "darkgreen")

# Create barplot of seconds
stat3 %>% filter(place == "2:a") %>% 
  ggplot( aes(x=reorder(firstname, n), n)) +
  geom_bar(stat = "identity", fill = "dodgerblue") +
  theme_minimal()+
  coord_flip() +
  labs(title="Antal 2:a platser per fäktare", 
       subtitle = "Perioden 2006 till 2018",
       caption = "Källa: Janne Tivenius",
       x= "Fäktare", 
       y="Antal 2:a placeringar") +
  geom_text(aes(label = n), 
            hjust = -0.3, 
            color = "#1380A1")

# Create barplot of thirds
stat3 %>% filter(place == "3:a") %>% 
  ggplot( aes(x=reorder(firstname, n), n)) +
  geom_bar(stat = "identity", fill = "wheat4") +
  theme_minimal()+
  coord_flip() +
  labs(title="Antal 3:e platser per fäktare", 
       subtitle = "Perioden 2006 till 2018",
       caption = "Källa: Janne Tivenius",
       x= "Fäktare", 
       y="Antal 3:e platser") +
  geom_text(aes(label = n), 
            hjust = -0.3)  
 

# Tests with table
long_hist %>%  table(name)

long_hist %>% filter() table(long_hist$place)



ggplot(mydata, aes(name, n)) +
  geom_bar(stat = "identity", aes(sort(mydata$n, decreasing = T)), fill = "steelblue") +
  #geom_text(aes(label = name))+
  theme_minimal()

# Import dataset with winners (plakett)
KM_plakett <- read_excel("C:/Users/AndrésLagerlöf/OneDrive - Andrés Lagerlöf Konsulttjänst AB/Övrigt/Fäktning/KM/KM_webb/fff_km/KM_plakett.xlsx", 
                         col_types = c("text", "text"))
View(KM_plakett)

# Dataframe of winners and no of wins per person
no_victories <-  KM_plakett %>% group_by(Name) %>% count() %>% arrange(desc(n))

# Dataframe of "one hit wonders"
one_timers <- no_victories %>% filter(n==1)

# Dataframe of winners of 2 or more titles
multi_winners <- no_victories %>% filter(n>1)


