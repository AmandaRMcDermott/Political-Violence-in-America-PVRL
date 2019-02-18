library(tidyverse)
library(plyr)
# Assembling
names(pvia)
names(pvia_2)
names(spec_pvia_5)

DBA <- pvia_2 %>% 
  select(date, reason, perpetrator.1, target.type.1, fatalities, injured)
levy <- spec_pvia_5 %>% 
  select(date_issued, reason, `target type 1`, `target type 2`, `perpetrator 1`,
         `perpetrator 2`)
GTD <- pvia %>% 
  select(date, `perpetrator 1`, `perpetrator 2`,fatalities,injured,`target type 1`,`target type 2`)

names(DBA) <- c("date", "reason", "perpetrator 1", "target type 1", "fatalities", "injured")
names(levy) <- c("date", "reason", "target type 1", "target type 2", "perpetrator 1")

GTD$fatalities <- as.numeric(GTD$fatalities)
GTD$injured <- as.numeric(GTD$injured)


initial_pvia <- bind_rows(GTD, levy, DBA)
write_csv(initial_pvia, "initial_pvia.csv")
