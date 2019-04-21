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
library(raster)

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
  dplyr::select(city, state_name, lat, lng) %>% 
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
  geom_point(data = pvia_coords %>% filter(state != "Puerto Rico"), aes(x = lng, y = lat, color = perpetrator_class, size = fatalities), alpha = .4) +
  geom_text_repel(data = pvia_coords %>% arrange(desc(fatalities)) %>% head(), aes(x = lng, y = lat, label = city), size = 3) +
  theme_void() +
  labs(color = "Classification", size = "Fatalities") +
  ggtitle("Attacks in the United States (1948-2017)")

# Map - incidents per capita
classes <- c("Islamic extremism", "Left-wing", "Right-wing", "Separatist")

incidents_percent <- initial_pvia_2 %>% 
  filter(perpetrator_class %in% classes) %>% 
  group_by(state) %>% 
  count(fatalities) %>% 
  group_by(state) %>% 
  summarize(total = sum(n)) %>% 
  inner_join(pop, by = "state") %>% 
  mutate(incident_capita = total/pop_1980) %>% 
  dplyr::select(state, incident_capita)
  
pvia_coords <- pvia_coords %>% 
  inner_join(incidents_percent, by = "state") 

temp <- pvia_coords %>% 
  dplyr::select(-date) %>% 
  unique() %>% 
  group_by(state) %>% 
  arrange(row_number(desc(incident_capita))) %>% 
  head(30) 
labels <- temp[c(1, 8, 12, 18, 19),]
little_labels <- temp[c(9, 10:11, 13:17, 18, 21, 22, 24, 25, 27),]

pvia_coords %>% 
  filter(perpetrator_class %in% classes) %>% 
  ggplot() +
  geom_polygon(data = US, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3, color = "lightgray") + guides(fill = T) +
  geom_point( aes(x = lng, y = lat, color = perpetrator_class, size = incident_capita), alpha = .4) +
  geom_text_repel(data = labels, aes(x = lng, y = lat, label = city), size = 3) +
  geom_text_repel(data = little_labels, aes(x = lng, y = lat, label = city), size = 2) +
  theme_void() +
  labs(color = "Classification", size = "Attacks per Capita") +
  ggtitle("Attacks Per Capita (1948-2017)", subtitle = "Using 1980 population data")
  

# Bar plots
# Bar plot of ideologies and deaths
deaths_by_ideol <- pvia_coords %>% filter(!is.na(perpetrator_class), !is.na(fatalities)) %>% group_by(perpetrator_class) %>% summarize(all_deaths = sum(fatalities))

pvia_coords %>% 
  filter(perpetrator_class %in% classes) %>% 
  ggplot() +
  geom_bar(data = pvia_coords %>% filter(!is.na(perpetrator_class)) %>%  count(perpetrator_class), 
           aes(x = reorder(perpetrator_class, -n), y = n), stat = "identity", fill = "lightskyblue3") + 
  geom_bar(data = deaths_by_ideol, 
           aes(x = reorder(perpetrator_class, -all_deaths), y = all_deaths, fill = all_deaths), stat = "identity", fill = "lightskyblue4") +
  theme_light() +
  ggtitle("Assassinations Committed by Political Leanings") +
  xlab("Perpetrator by Political Leaning") +
  ylab("Number") 



# Bar plot of deaths by target type
deaths_by_group <- pvia_coords %>% filter(!is.na(target_type_1), !is.na(fatalities), target_type_1 != "Police/Military") %>% group_by(target_type_1) %>% summarize(all_deaths = sum(fatalities))

ggplot() +
  geom_histogram(data = pvia_coords %>% filter(!is.na(target_type_1), target_type_1 != "Police/Military") %>%  count(target_type_1), 
           aes(x = reorder(target_type_1, n), y = n), stat = "identity", fill = "lightskyblue3", binwidth = .3) + 
  geom_histogram(data = deaths_by_group, 
           aes(x = reorder(target_type_1, -all_deaths), y = all_deaths, fill = all_deaths), stat = "identity", fill = "lightskyblue4", binwidth = .3) +
  #theme_light() +
  ggtitle("Assassinations by Target") +
  xlab("Type of Target") +
  ylab("Number") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10)) +
  coord_flip()
  
# Success of attack based on target type
deaths_by_group <- initial_pvia_2 %>% filter(!is.na(target_type_1), !is.na(fatalities), target_type_1 != "Police/Military") %>% group_by(target_type_1) %>% summarize(all_deaths = sum(fatalities))

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
  mutate(year = as.integer(str_extract(date, "\\d{4}"))) %>% 
  group_by(year) %>% 
  count(fatalities) 
  #filter(!is.na(target_type_1), !is.na(fatalities)) %>% 
 # count(target_type_1) %>% 
  ggplot(aes(x = date, y = n)) + 
  geom_line()
  #geom_line(aes(group = perpetrator_class, color = perpetrator_class))
  geom_smooth(se = F)
  
  
pvia_coords %>% 
  filter(!is.na(target_type_1), !is.na(fatalities), !is.na(perpetrator_class)) %>% 
  ggplot(aes(x = date, y = fatalities)) +
  #geom_smooth() +
  geom_smooth(aes(group = perpetrator_class))

# Raw instances by state
initial_pvia_2 %>%
    filter(!is.na(state), target_type_1 != "Police/Military") %>% 
    count(state) %>% 
    #group_by(state) %>% 
    #mutate()
    #summarize(total = sum(n))
    ggplot(aes(x = reorder(state, n), y = n)) + 
    geom_bar(stat = "identity", fill = "lightskyblue4") +
    xlab("State") +
    ylab("Count") +
    ggtitle("Raw Counts of Instances by State") +
   # theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8)) +
    coord_flip()
ggsave("attack_count_by_state.png")

# Scatter plot of attacks over time by target type
initial_pvia_2 %>%
  filter(target_type_1 != "Police/Military") %>% 
  ggplot(., aes(x = date, y = fatalities, color = target_type_1)) + 
  geom_point() + 
  geom_jitter() + 
  theme(legend.position = "bottom") +
  labs(title = "Victims of Assassination Over Time", color = "Target Type") +
  ylab("Fatalities") +
  xlab("Date")

  
