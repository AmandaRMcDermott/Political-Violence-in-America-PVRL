# Assembling

library(tidyverse)
library(RColorBrewer)
library(kableExtra)

names(pvia)
names(pvia_2)
names(levy_pvia_edit)


# select specific columns
DBA <- pvia_2 %>% 
  select(date, reason, perpetrator.1, target.type.1, fatalities, injured, target, assassin)
levy <- levy_pvia_edit %>% 
  select(date, City, State, reason, `target type 1`, `target type 2`, `perpetrator 1`,
         `perpetrator 2`, fatalities_target, target_name, perpetrator_name, Comments)
GTD <- pvia %>% 
  select(date, city, `perpetrator 1`, `perpetrator 2`,fatalities,injured,`target type 1`,`target type 2`)

# rename columns
names(DBA) <- c("date", "reason", "perpetrator_1", "target_type_1", "fatalities", "injured", "target_name", "perperator_name")
names(levy) <- c("date", "city", "state", "reason", "target_type_1", "target_type_2", "perpetrator_1", "perpetrator_2", "fatalities", "target_name", "perperator_name", "comments")
names(GTD) <- c("date", "city", "perpetrator_1", "perpetrator_2", "fatalities", "injured", "target_type_1", "target_type_2")

# Convert fatalities variable to numeric
DBA$fatalities <- as.numeric(DBA$fatalities)

levy$fatalities <- as.numeric(levy$fatalities)

GTD$fatalities <- as.numeric(GTD$fatalities)
GTD$injured <- as.numeric(GTD$injured)



# bind rows
initial_pvia <- bind_rows(GTD, levy, DBA)

# reorganize columns
initial_pvia <- initial_pvia %>% 
  select(date, city, state, target_type_1, target_type_2, target_name, perpetrator_1, perpetrator_2, perperator_name, fatalities, injured, reason, comments)

# write to csv
write_csv(initial_pvia, "initial_pvia.csv")



# Graphs
pl <- initial_pvia %>%
  filter(
    !is.na(`target type 1`),
    `target type 1` != "Unknown",
    `target type 1` != "Military",
    `target type 1` != "Police",
    `target type 1` != "Three",
    `target type 1` != "Educational Institution",
    `target type 1` != "North America",
    `target type 1` != "Religious Figures/Institutions",
    `target type 1` != "Terrorists/Non-state Militia",
    `target type 1` != "unspecified"
  ) %>%
  ggplot(., aes(x = date, y = fatalities, color = `target type 1`)) + geom_point(size = .9) + geom_jitter(size = .9) + theme(legend.position = "bottom")



pl+labs(title = "Victims of Assassination Over Time")



initial_pvia %>% filter(
  `target type 1` != "Unknown",
  `target type 1` != "Military",
  `target type 1` != "Police",
  `target type 1` != "Three",
  `target type 1` != "Educational Institution",
  `target type 1` != "North America",
  `target type 1` != "Religious Figures/Institutions",
  `target type 1` != "Terrorists/Non-state Militia",
  `target type 1` != "unspecified"
) %>% 
  group_by(`target type 1`) %>% 
  summarize(total = sum(fatalities)) %>% 
  arrange(desc(total)) %>% 
  na.omit() %>% 
  head() %>% 
  kable()
  




