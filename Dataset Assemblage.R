library(tidyverse)
library(stringr)
library(readr)
library(asciiSetupReader)

# Read in data from the GTD
pvia <- read_csv("https://raw.githubusercontent.com/Glacieus/Political-Violence-in-America-PVRL/master/Data%20files/GTD-Export.csv")

# change column names to lowercase
names(pvia)[1:23] <- tolower(names(pvia))[1:23]

pvia$date <- as.Date(pvia$date, "%Y-&m-%d")

pvia <- pvia %>% 
  select(2, 4:15, 20:23)

ggplot(pvia, aes(x = city)) + geom_bar() + coord_flip()


# Read in data from the Data Bank of Assassinations (ICPSR)
pvia_2 <- asciiSetupReader::spss_ascii_reader("05208-0001-Data.txt", "05208-0001-Setup.sps")

# rename columns
names(pvia_2) <- c("country", "month", "day", "year", "outcome", "action", "minority_hostility",
                   "reason", "perpetrator 1", "type_target", "nature_initiator", "nature_target",
                   "fatalities", "injured", "target", "assassin", "nyt_ref_month", "nyt_ref_day", "nyt_ref_year",
                   "delete", "nyt_ref_pg_num", "nyt_ref_col_um")

pvia_2$delete <- NULL

# add 19 to the year column to create complete years
pvia_2$year <- paste0("19", pvia_2$year)
pvia_2$nyt_ref_year <- paste0("19", pvia_2$nyt_ref_year)

pvia_2 <- pvia_2 %>% 
  unite("date", c("year", "month", "day")) %>% 
  unite("nyt_ref_date", c("nyt_ref_year", "nyt_ref_month", "nyt_ref_day")) %>% 
  transform(date = as.Date(date, "%Y_%m_%d"),
            nyt_ref_date = as.Date(nyt_ref_date, "%Y_%m_%d")) %>% 
  filter(country == "79") # select only US obs

########  RECODING VARIABLE MEANINGS
# Success - Y/N
pvia_2$outcome <- ifelse(pvia_2$outcome == "1", "Yes", "No")

# Action - attempt vs plot
pvia_2$action<- ifelse(pvia_2$action == "1", "attempt", "plot")

# Minority Hostility - Y/N
pvia_2$minority_hostility <- ifelse(pvia_2$minority_hostility == 1, "Yes", "No")

# Reason
pvia_2$reason <- ifelse(pvia_2$reason == "1", "Political", 
                        ifelse(pvia_2$reason == "2", "Religious",
                               ifelse(pvia_2$reason == "3", "Economic", 
                                      ifelse(pvia_2$reason == "4", "Ethnic",
                                            ifelse(pvia_2$reason == "5", "Educational", NA)))))
# Type of Initiator
pvia_2$perpetrator 1[pvia_2$perpetrator 1 == "1"] <- "Unspecified"
pvia_2$perpetrator 1[pvia_2$perpetrator 1 == "4"] <- "Extremist political group"
pvia_2$perpetrator 1[pvia_2$perpetrator 1 == "11"] <- "Big business/managers/professional"

# Type of Target
pvia_2$type_target <- recode(pvia_2$type_target, "15" = "worker/laborer", 
       "20" = "Chief of State or military junta",
       "27" = "legislative",
       "35" = "state governor",
       "24" = "other national government official",
       "3" = "social/political movt/leader",
       "1" = "unspecified",
       "25" = "political party/leader")

# Nature of initiator
pvia_2$nature_initiator <- recode(pvia_2$nature_initiator,
                                  "68" = "Puerto Rican",
                                  "200" = "majority")

# Nature of target
pvia_2$nature_target <- recode(pvia_2$nature_target, 
                             "200" = "majority",
                             "46" = "black")


pvia_3 <- asciiSetupReader::spss_ascii_reader("05302-0001-Data.txt", "05302-0001-Setup.sps")
pvia_4 <- asciiSetupReader::spss_ascii_reader("05206-0001-Data.txt", "05206-0001-Setup.sps")
pvia_5 <- asciiSetupReader::spss_ascii_reader("00080-0001-Data.txt", "00080-0001-Setup.sps" )

pvia_4 <- pvia_4 %>% filter(COUNTRY_CODE == "UNITED STATES", TYPE_OF_EVENT == "ASSASSINATIONS (ASSASSINATION IS DEFINED AS THE")



