# Assembling

library(tidyverse)
library(RColorBrewer)
library(kableExtra)

names(pvia_2)
names(levy_pvia_edit)
names(GTD)

# select specific columns
DBA <- pvia_2 %>% 
  select(date, reason, perpetrator.1, target.type.1, fatalities, injured, target, assassin, ref_pg_num, nyt_ref_col_um)
levy <- levy_pvia_edit %>% 
  select(date, City, State, reason, `target type 1`, `target type 2`, `perpetrator 1`,
         `perpetrator 2`, fatalities_target, target_name, perpetrator_name, Comments)
GTD <- GTD %>% 
  select(date, provstate, city, targtype1_txt, targsubtype1_txt, target1, gname, motive, nkill, addnotes, scite1, scite2, scite3)

# rename columns
names(DBA) <- c("date", "reason", "perpetrator_1", "target_type_1", "fatalities", "injured", "target_name", "perperator_name", "nyt_ref_pg_num", "nyt_ref_col_num")
names(levy) <- c("date", "city", "state", "reason", "target_type_1", "target_type_2", "perpetrator_1", "perpetrator_2", "fatalities", "target_name", "perperator_name", "comments")
names(GTD) <- c("date", "state", "city", "target_type_1", "target_type_2", "target_name", "perpetrator_1", "reason", "fatalities", "comments", "cite1", "cite2", "cite3")

# Convert fatalities variable to numeric
DBA$fatalities <- as.numeric(DBA$fatalities)

levy$fatalities <- as.numeric(levy$fatalities)

GTD$fatalities <- as.numeric(GTD$fatalities)




# bind rows
initial_pvia <- bind_rows(GTD, levy, DBA)

# reorganize columns
initial_pvia <- initial_pvia %>% 
  select(date, city, state, target_type_1, target_type_2, target_name, perpetrator_1, perpetrator_2, perperator_name, fatalities, injured, reason, comments)

# write to csv
write_csv(initial_pvia, "initial_pvia_2.csv")





