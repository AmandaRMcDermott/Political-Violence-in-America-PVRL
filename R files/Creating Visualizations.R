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
#library(reshape2)


pvia_2 <- read_csv("pvia_2.csv")


# Necessary after editing in Excel/adding more observations - it fixes the date format
pvia_2<- pvia_2 %>% 
  separate(date, c("month", "day", "year"), sep = "/")

pvia_2$year <- ifelse(as.numeric(pvia_2$year) > 20, paste0("19", pvia_2$year), paste0("20", pvia_2$year))

pvia_2$month <- str_pad(pvia_2$month, width = 2, side = "left", pad = "0")
pvia_2$day <- str_pad(pvia_2$day, width = 2, side = "left", pad = "0")

pvia_2 <- pvia_2 %>% 
  unite(date, c(year, month, day), sep = "-") %>% 
  mutate(date = as.Date(date, "%Y-%m-%d"))

# incidents per capita
pvia_2 <- pvia_2 %>% 
  filter(perpetrator_class != "Police/Military") %>% 
  group_by(state) %>% 
  count(fatalities) %>% 
  summarize(total_incidents = sum(n)) %>% 
  inner_join(pvia_2, by = "state") %>% 
  mutate(incidents_percapita = total_incidents/pop_1980) %>% 
  dplyr::select(state, incidents_percapita) %>% 
  unique() %>% 
  left_join(pvia_2, by = "state")

# total incidents
pvia_2 <- pvia_2 %>% 
  group_by(state) %>% 
  count(fatalities) %>% 
  summarize(total_incidents = sum(n)) %>% 
  left_join(pvia_2, by = "state") %>% 
  dplyr::select(date, city, state, everything())

# MAPS ################################################################################
classes <- c("Islamic extremism", "Left-wing", "Right-wing", "Separatist")
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

pvia_coords <- pvia_2 %>% 
  inner_join(final_coords, c("city", "state"))

# Map - blocked states by incidents ---------------------------------------------------------------

deaths_by_state <- pvia_2 %>% 
  filter(state != "Police/Military", !is.na(fatalities)) %>% 
  count(state, fatalities) %>% 
  group_by(state) %>% 
  mutate(total_incidents= sum(n)) %>% 
  mutate(total_deaths = sum(fatalities * n)) %>% 
  dplyr::select(-fatalities, -n) %>% 
  unique() %>% 
  mutate(percent_success = total_deaths/total_incidents * 100) %>% 
  transform(percent_success = paste0(round(percent_success, digits = 1), " %")) %>% 
  select(-percent_success)

# Map of incidents
state_list <- unique(pvia_2$state_abbrev)
plot_usmap(data = deaths_by_state, 
           values = "total_incidents", 
           lines = "darkblue",
           include = state_list) +
  scale_fill_continuous(low = "lightcyan", high = "steelblue4", name = "Number of Attacks") +
  theme_void() +
  ggtitle("Attacks in United States (1948-2017)")

# Incidents per capita
state_list2 <- state_list[state_list != c("DC", "PR")]
plot_usmap(data = pvia_2,
           values = "incidents_percapita",
           lines = "darkblue",
           include = state_list2) +
scale_fill_continuous(low = "lightcyan", high = "steelblue3", name = "Number of Attacks") +
theme_void() +
ggtitle("Attacks in United States Per Capita (1948-2017)")

# DC attacks per capita
plot_usmap(data = pvia_2,
           values = "incidents_percapita",
           lines = "darkblue",
           include = "DC") +
  scale_fill_continuous("navyblue", name = "") +
  theme_void() +
  ggtitle("District of Colombia")


# Map  - locations ---------------------------------------------------------------
(temp <- pvia_coords %>% arrange(desc(fatalities)))

map1_lab <- temp[c(1, 3, 4, 7, 8, 14),]

ggplot() +
  geom_polygon(data = US, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3, color = "lightgray") + guides(fill = T) +
  geom_point(data = pvia_coords %>% filter(perpetrator_class %in% classes), aes(x = lng, y = lat, color = perpetrator_class, size = fatalities), alpha = .4) +
  geom_text_repel(data = map1_lab, aes(x = lng, y = lat, label = city), size = 4) +
  theme_void() +
  labs(color = "Classification", size = "Fatalities") +
  ggtitle("Attacks in the United States (1948-2017)")


# Map - incidents per capita ---------------------------------------------------------------
temp <- pvia_coords %>% 
  dplyr::select(-date) %>% 
  unique() %>% 
  group_by(state) %>% 
  arrange(row_number(desc(incidents_percapita))) %>% 
  head(40) 
labels <- temp[c(1, 8,30, 31),]
little_labels <- temp[c(21,  25,  27, 28, 29,  33),]


map2 <- ggplot() +
  geom_polygon(data = US, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3, color = "lightgray") + guides(fill = T) +
  geom_point(data = pvia_coords %>% filter(perpetrator_class %in% classes), aes(x = lng, y = lat, color = perpetrator_class, size = incidents_percapita), alpha = .4) +
  geom_text_repel(data = labels, aes(x = lng, y = lat, label = city), size = 4) +
  geom_text_repel(data = little_labels, aes(x = lng, y = lat, label = city), size = 3, nudge_x = 2) +
  theme_void() +
  labs(size = "Attacks per Capita") +
  scale_color_discrete(guide = "none") +
  ggtitle("Attacks Per Capita", subtitle = "Using 1980 population data")

grid.arrange(map1, map2)

# Bar plots ##########################################################################################

# Bar plot of ideologies and deaths ---------------------------------------------------------------
deaths_by_ideol <- pvia_2 %>% 
  filter(perpetrator_class %in% classes, target_type_1 != "Police/Military", !is.na(fatalities)) %>% 
  count(perpetrator_class, fatalities) %>% 
  #na.omit() %>% 
  group_by(perpetrator_class) %>% 
  mutate(total_incidents= sum(n)) %>% 
  mutate(total_deaths = sum(fatalities * n)) %>% 
  dplyr::select(-fatalities, -n) %>% 
  unique() %>% 
  mutate(percent_success = total_deaths/total_incidents * 100) %>% 
  transform(percent_success = paste0(round(percent_success, digits = 1), " %")) %>% 
  mutate(new = total_incidents - total_deaths) %>% 
  select(-percent_success, -total_incidents) %>% 
  gather(total_deaths:new, key = Key, value = n) 

ggplot(deaths_by_ideol, aes(x = reorder(perpetrator_class, n), y = n, fill = Key)) +
  geom_bar(stat = "identity", position = "stack") +
  theme_light() +
  ggtitle("Assassinations Committed by Political Leanings") +
  xlab("Perpetrator by Political Leaning") +
  ylab("Number") +
  coord_flip() +
  scale_fill_manual(values = c("lightskyblue3", "lightskyblue4"), labels = c("Total Attacks", "Total Kills")) +
  theme(legend.position = "bottom") +
  ylim(0, 80) +
  annotate("text", x = 1:4, y = c(16, 27, 27, 75), label = c("37.5%", "60%", "50%","89.7%")) +
  labs(caption = "Percentages shown represent the proportion of successful attacks")



# Bar plot of deaths by target type ---------------------------------------------------------------
deaths_by_group <- pvia_2 %>% 
  filter(target_type_1 != "Police/Military", !is.na(fatalities)) %>% 
  count(target_type_1, fatalities) %>% 
  group_by(target_type_1) %>% 
  mutate(total_incidents= sum(n)) %>% 
  mutate(total_deaths = sum(fatalities * n)) %>%
  select(-fatalities, -n) %>% 
  unique() %>% 
  mutate(percent_success = total_deaths/total_incidents * 100) %>% 
  transform(percent_success = paste0(round(percent_success, digits = 1), " %")) %>%
  mutate(new = total_incidents - total_deaths) %>% 
  select(-percent_success, -total_incidents) %>% 
  gather(total_deaths:new, key = Key, value = n) 

 
deaths_by_group %>% 
  ggplot(aes(x = reorder(target_type_1, n), y = n, fill = Key)) +
  geom_bar(stat = "identity",  width = .8) +
  theme_light() +
  ggtitle("Assassinations by Target") +
  xlab("Type of Target") +
  ylab("Number") +
  coord_flip() +
  scale_fill_manual(values = c("lightskyblue3", "lightskyblue4"), labels = c("Total Attacks", "Total Kills")) +
  theme(legend.position = "bottom") +
  ylim(0,45) +
  annotate("text", x = 5:12, y = c(10, 10, 11, 17, 18, 20, 37, 43), label= c("57.1%","57.1%", "", "76.9%","80%", "37.5%", "60.6%", "85%")) +labs(caption = "Percentages shown represent the proportion of successful attacks")



# Raw instances by state ---------------------------------------------------------------
deaths_by_state <- pvia_2 %>% 
  filter(state != "Police/Military", !is.na(fatalities)) %>% 
  count(state, fatalities) %>% 
  group_by(state) %>% 
  mutate(total_incidents= sum(n)) %>% 
  mutate(total_deaths = sum(fatalities * n)) %>% 
  dplyr::select(-fatalities, -n) %>% 
  unique() %>% 
  mutate(percent_success = total_deaths/total_incidents * 100) %>% 
  transform(percent_success = paste0(round(percent_success, digits = 1), " %")) %>% 
  select(-percent_success) %>% 
  gather(total_incidents:total_deaths, key = Key, value = n) 
  
deaths_by_state %>%
  ggplot(aes(x = reorder(state, n), y = n, fill = Key)) + 
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  xlab("State") +
  ylab("Number") +
  ggtitle("Raw Counts of Instances by State") +
  coord_flip() +
  theme_light() +
  scale_fill_manual(values = c("lightskyblue4", "lightskyblue3"), labels = c("Total Kills", "Total Attacks")) +
  theme(legend.position = "bottom")




# Panel ##########################################################################################
targets_int <- c("Government", "Private Citizens", "Civil Rights Activists", "Religious Figures/Institutions", "Journalists & Media",
                 "Political Party", "Abortion Related")
# Assassination attacks and deaths over time
pvia_2 %>% 
 filter(perpetrator_class == c("Right-wing", "Left-wing", "Separatist")) %>% 
  #transform(perpetrator_class = factor(perpetrator_class, levels = c("Right-wing", "Left-wing", "Separatist"))) %>% 
  mutate(year = as.integer(str_extract(date, "\\d{4}"))) %>% 
  filter(perpetrator_class %in% classes, target_type_1 %in% targets_int) %>% 
  count(year, fatalities, perpetrator_class, target_type_1) %>% 
  group_by(year) %>%
  mutate(total_attacks = sum(n)) %>% 
  #dplyr::select(-fatalities, -n) %>% 
  #gather(total_deaths:total_attacks, key = Key, value = n) %>% 
  ggplot(., aes(x = year, y = total_attacks)) +
  geom_point(alpha = .3)+
  geom_jitter(width = .4, alpha = .3) +
  #geom_smooth(se = F) 
  geom_smooth(aes(color = perpetrator_class), se = F, alpha = 0.8) +
  facet_grid(perpetrator_class ~ .) +
  theme_light() +
  ylab("Attacks") +
  xlab("Year") +
  ggtitle("Attacks Over Time By Class") +
  scale_color_discrete(labels = c("Left-Wing", "Right-Wing", "Separatist"), name = "Perpetrator Class") +
  theme(legend.position = "bottom", axis.text.x = element_text(angle = 45, hjust = 1, size = 8)) +
  scale_x_continuous(breaks = seq(1910, 2017, by = 5))


pvia_2 %>% 
  filter(perpetrator_class == c("Right-wing", "Left-wing")) %>% 
  transform(perpetrator_class = factor(perpetrator_class, levels = c("Right-wing", "Left-wing", "Separatist", "Islamic extremism"))) %>% 
  mutate(year = as.integer(str_extract(date, "\\d{4}"))) %>% 
  filter(perpetrator_class %in% classes, target_type_1 %in% targets_int) %>% 
  count(year, fatalities, perpetrator_class, target_type_1) %>% 
  group_by(year) %>%
  mutate(total_attacks = sum(n)) %>% 
  #dplyr::select(-fatalities, -n) %>% 
  #gather(total_deaths:total_attacks, key = Key, value = n) %>% 
  ggplot(., aes(x = year, y = total_attacks)) +
  geom_point(alpha = .6)+
  geom_jitter(width = .4, alpha = .3) +
  #geom_smooth(se = F) 
  geom_smooth(aes(group = perpetrator_class, color = perpetrator_class),  se = F, alpha = 0.8) +
  facet_grid(perpetrator_class ~ target_type_1) +
  theme_light() +
  ylab("Attacks") +
  xlab("Year") +
  scale_color_discrete(labels = c("Left-Wing", "Right-Wing"), name = "Perpetrator Class") +
  theme(legend.position = "bottom", axis.text.x = element_text(angle = 45, hjust = 1, size = 8)) +
  scale_x_continuous(breaks = seq(1910, 2017, by = 10))


# Scatter plot of attacks over time by target type
pvia_2 %>%
  filter(target_type_1 != "Police/Military") %>% 
  ggplot(., aes(x = date, y = fatalities, color = target_type_1)) + 
  geom_point() + 
  geom_jitter() + 
  theme_light() +
  labs(title = "Victims of Assassination Over Time", color = "Target Type") +
  ylab("Fatalities") +
  xlab("Date")

