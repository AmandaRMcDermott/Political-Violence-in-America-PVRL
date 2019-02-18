# Assembling

library(tidyverse)
library(RColorBrewer)

names(pvia)
names(pvia_2)
names(spec_pvia_5)

# select specific columns
DBA <- pvia_2 %>% 
  select(date, reason, perpetrator.1, target.type.1, fatalities, injured)
levy <- spec_pvia_5 %>% 
  select(date_issued, reason, `target type 1`, `target type 2`, `perpetrator 1`,
         `perpetrator 2`, fatalities_target)
GTD <- pvia %>% 
  select(date, `perpetrator 1`, `perpetrator 2`,fatalities,injured,`target type 1`,`target type 2`)

# rename columns
names(DBA) <- c("date", "reason", "perpetrator 1", "target type 1", "fatalities", "injured")
names(levy) <- c("date", "reason", "target type 1", "target type 2", "perpetrator 1", "perpetrator 2", "fatalities")

GTD$fatalities <- as.numeric(GTD$fatalities)
GTD$injured <- as.numeric(GTD$injured)

# bind rows
initial_pvia <- bind_rows(GTD, levy, DBA)

# write to csv
write_csv(initial_pvia, "initial_pvia.csv")

ggplot(initial_pvia, aes(x = date, y = fatalities, color = `target type 1`)) + geom_point() + geom_jitter() + theme(legend.position = "bottom")
