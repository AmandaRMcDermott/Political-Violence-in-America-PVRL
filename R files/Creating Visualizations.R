library(tidyverse)
library(ggmap)
library(usmap)
library(stringr)
library(maps)
library(ggrepel)
library(lubridate)
library(scales)
library(gridExtra)
library(ggthemes)
library(usmap)
library(kableExtra)

initial_pvia_2 <- read_csv("initial_pvia_2.csv")

# Necessary after editing in Excel - it fixes the date format
initial_pvia_2<- initial_pvia_2 %>% 
  separate(date, c("month", "day", "year"), sep = "/")

initial_pvia_2$year <- ifelse(as.numeric(initial_pvia_2$year) > 20, paste0("19", initial_pvia_2$year), paste0("20", initial_pvia_2$year))

initial_pvia_2$month <- str_pad(initial_pvia_2$month, width = 2, side = "left", pad = "0")
initial_pvia_2$day <- str_pad(initial_pvia_2$day, width = 2, side = "left", pad = "0")

initial_pvia_2 <- initial_pvia_2 %>% 
  unite(date, c(year, month, day), sep = "-") %>% 
  mutate(date = as.Date(date, "%Y-%m-%d"))



# Map
coords <- read_csv("uscitiesv1.4.csv")

US <- map_data("state")

refined_coords <- coords %>%
  select(-c(2, 3, 5, 6, 9:16)) %>% 
  distinct() %>% 
  rename(state = "state_name")

# Add coordinates not found in the coordinates for US cities csv
added_coords <- tibble(city = c("Carolina", "St. Louis", "Canton", "Edison", "Greenburgh"),
                             state = c("Puerto Rico", "Missouri", "Michigan", "New Jersey", "New York"),
                             lat = c(18.380102, 38.627003, 42.271498914, 40.522964, 41.03),
                             lng = c(-65.961975, -90.199402, -83.472164778, -74.411674, -73.83))

final_coords <- rbind(refined_coords, added_coords)

pvia_coords <- initial_pvia_2 %>% 
  inner_join(final_coords, c("city", "state"))

# Map
ggplot() +
  geom_polygon(data = US, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3, color = "lightgray") + guides(fill = T) +
  geom_point(data = pvia_coords %>% filter(state != "Puerto Rico"), aes(x = lng, y = lat, color = perpetrator_poli_leaning, size = fatalities), alpha = .4) +
  geom_text_repel(data = pvia_coords %>% arrange(desc(fatalities)) %>% head(), aes(x = lng, y = lat, label = city), size = 3) +
  theme_void() +
  labs(color = "Classification", size = "Fatalities") +
  ggtitle("Attacks in the United States (1948-2017)")



# Bar plots
# Bar plot of ideologies and deaths
deaths_by_ideol <- pvia_coords %>% filter(!is.na(perpetrator_poli_leaning), !is.na(fatalities)) %>% group_by(perpetrator_poli_leaning) %>% summarize(all_deaths = sum(fatalities))

ggplot() +
  geom_bar(data = pvia_coords %>% filter(!is.na(perpetrator_poli_leaning)) %>%  count(perpetrator_poli_leaning), 
           aes(x = reorder(perpetrator_poli_leaning, -n), y = n), stat = "identity", fill = "lightskyblue3") + 
  geom_bar(data = deaths_by_ideol, 
           aes(x = reorder(perpetrator_poli_leaning, -all_deaths), y = all_deaths, fill = all_deaths), stat = "identity", fill = "lightskyblue4") +
  theme_light() +
  ggtitle("Assassinations Committed by Political Leanings") +
  xlab("Perpetrator by Political Leaning") +
  ylab("Number") 



# Bar plot of deaths by target type
deaths_by_group <- pvia_coords %>% filter(!is.na(target_type_1), !is.na(fatalities)) %>% group_by(target_type_1) %>% summarize(all_deaths = sum(fatalities))

ggplot() +
  geom_bar(data = pvia_coords %>% filter(!is.na(target_type_1)) %>%  count(target_type_1), 
           aes(x = reorder(target_type_1, -n), y = n), stat = "identity", fill = "lightskyblue3", width = .5) + 
  geom_bar(data = deaths_by_group, 
           aes(x = reorder(target_type_1, -all_deaths), y = all_deaths, fill = all_deaths), stat = "identity", fill = "lightskyblue4", width = .5) +
  #theme_light() +
  ggtitle("Assassinations by Target") +
  xlab("Type of Target") +
  ylab("Number") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 6.5))
  
# Success of attack based on target type
deaths_by_group <- initial_pvia_2 %>% filter(!is.na(target_type_1), !is.na(fatalities)) %>% group_by(target_type_1) %>% summarize(all_deaths = sum(fatalities))

tot_attacks <- initial_pvia_2 %>% 
  filter(!is.na(target_type_1), !is.na(fatalities)) %>% 
  count(target_type_1, sort = T) %>% 
  rename(total_attacks = n)

deaths_by_group <- initial_pvia_2 %>% filter(!is.na(target_type_1), !is.na(fatalities)) %>% group_by(target_type_1) %>% summarize(all_deaths = sum(fatalities))

# use this in markdown
deaths_by_group %>% 
  right_join(tot_attacks) %>% 
  mutate(success_rate = round((all_deaths/total_attacks)*100, digits = 2)) %>% 
  rename("Target Type" = target_type_1, 
         "Total Deaths" = all_deaths, 
         "Total Attacks" = total_attacks, 
         "Success Rate" = success_rate) %>% 
  kable()



# Time Series
pvia_coords %>% 
  filter(!is.na(target_type_1), !is.na(fatalities)) %>% 
 # count(target_type_1) %>% 
  ggplot(aes(x = date, y = fatalities)) + 
  geom_line(aes(group = perpetrator_poli_leaning, color = perpetrator_poli_leaning))
  geom_smooth(aes(color= perpetrator_poli_leaning), se = F)

# Instances by state
initial_pvia_2 %>%
    filter(!is.na(state)) %>% 
    count(state) %>% 
    #group_by(state) %>% 
    #mutate()
    #summarize(total = sum(n))
    ggplot(aes(x = reorder(state, -n), y = n)) + 
    geom_bar(stat = "identity", fill = "lightskyblue4") +
    xlab("State") +
    ylab("Count") +
    ggtitle("Recored Instances by State") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8)) 


# Scatter plot of attacks over time by target type
initial_pvia_2 %>%
  ggplot(., aes(x = date, y = fatalities, color = target_type_1)) + 
  geom_point() + 
  geom_jitter() + 
  theme(legend.position = "bottom") +
  labs(title = "Victims of Assassination Over Time", color = "Target Type") +
  ylab("Fatalities") +
  xlab("Date")

  
