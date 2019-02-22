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
  select(2, 4:15, 20:22)

# Read in data from the Data Bank of Assassinations (ICPSR)
pvia_2 <- asciiSetupReader::spss_ascii_reader("DBA_Data.txt", "DBA_Setup.sps")

# rename columns
names(pvia_2) <- c("country", "month", "day", "year", "outcome", "action", "minority_hostility",
                   "reason", "perpetrator 1", "target type 1", "nature_initiator", "nature_target",
                   "fatalities", "injured", "target", "assassin", "nyt_ref_month", "nyt_ref_day", "nyt_ref_year",
                   "delete", "ref_pg_num", "nyt_ref_col_um")

pvia_2$delete <- NULL

# add 19 to the year column to create complete years
pvia_2$year <- paste0("19", pvia_2$year)
pvia_2$nyt_ref_year <- paste0("19", pvia_2$nyt_ref_year)

pvia_2 <- pvia_2 %>% 
  unite("date", c("year", "month", "day")) %>% 
  unite("nyt_ref_date", c("nyt_ref_year", "nyt_ref_month", "nyt_ref_day")) %>% 
  transform(date = as.Date(date, "%Y_%m_%d"),
            nyt_ref_date = as.Date(nyt_ref_date, "%Y_%m_%d")) %>% 
  filter(country == "79") %>% # select only US obs 
  select(-1)

# Convert variable contents to lowercase
pvia_2$outcome <- tolower(pvia_2[,2])
pvia_2$action <- tolower(pvia_2[,3])
pvia_2$reason <- tolower(pvia_2[,5])
pvia_2$perpetrator.1 <- tolower(pvia_2[,6])
pvia_2$target.type.1 <- tolower(pvia_2[,7])
pvia_2$fatalities <- tolower(pvia_2[,10])


########  RECODING VARIABLE MEANINGS

#pvia_3 <- asciiSetupReader::spss_ascii_reader("05302-0001-Data.txt", "05302-0001-Setup.sps")
#pvia_4 <- asciiSetupReader::spss_ascii_reader("05206-0001-Data.txt", "05206-0001-Setup.sps")

# Import Poli Violence in the US data
pvia_5 <- asciiSetupReader::spss_ascii_reader("00080-0001-Data.txt", "00080-0001-Setup.sps" )



# change column names to lowercase
names(pvia_5)[1:30] <- tolower(names(pvia_5))[1:30]

# selecting relevant columns
pvia_5 <- pvia_5 %>% 
  select(4:9, 11:17, 19:21, 27:29)

# rename columns
names(pvia_5) <- c("newspaper_ref", "month", 
                   "day", "year", 
                   "ref_page_num", "target type 1", 
                   "number_perpetrator", "weapon type 1", 
                   "group_violence", "reason", 
                   "injury_target", "injury_group_target", 
                   "fatalities_target", "injury_perpetrator", 
                   "injury_group_perpetrator", "fatalities_perpetrator",
                   "target type 2", "perpetrator 1", 
                   "perpetrator 2")


# Recode Newspaper identification
pvia_5$newspaper_ref <- recode(pvia_5$newspaper_ref,
       "01" = "New York Times",
       "02" = "Philadelphia Inquirer",
       "03" = "St. Louis Post Dispatch",
       "04" = "Chicago Tribune",
       "05" = "San Francisco Chronicle",
       "06" = "Cleveland Plain Dealer",
       "07" = "Detroit Free Press",
       "08" = "Atlanta Constitution",
       "09" = "Washington Post",
       "10" = "Los Angeles Times",
       "11" = "Kansas City Star",
       "12" = "Daily National Intelligence (DC)")

# Create one date column
# Convert to integer
pvia_5$month <- as.integer(pvia_5$month)
# pad month and date column so it contains 2 digits
pvia_5$month <- str_pad(pvia_5$month, width = 2, side = "left", pad = "0")
pvia_5$day <- str_pad(pvia_5$day, width = 2, side = "left", pad = "0")

pvia_5 <- pvia_5 %>% 
  unite("date_issued", c("year", "month", "day"), sep = "-")

pvia_5$date_issued <- as.Date(pvia_5$date_issued, "%Y-%m-%d")

# filter dates between 1954 and 1970
pvia_5 <- pvia_5 %>% filter(between(date_issued, as.Date("1954/01/01"), as.Date("1970/01/01")))


#recode nature of target column
pvia_5$`target type 1` <- recode(pvia_5$`target type 1`,
       "2" = "Cabinet Member",
       "3" = "Other federal appointments",
       "4" = "President",
       "7" = "Representative",
       "11" = "Presidential candidate",
       "15" = "Governor",                                  
       "16" = "State Legislator",                          
       "17" = "Judge",              
       "18" = "Mayor of a City",
       "20" = "Other City Official",
       "21" = "Governor candidate",
       "24" = "Mayoral candidate",
       "27" = "Political Party Leader or Official",        
       "28" = "Labor Leader",                              
       "29" = "Business Leader",
       "40" = "Religious Leader",                          
       "41" = "Leader of racial group",                    
       "47" = "Other Individual",
       "30" = "Two",                                       
       "31" = "Three",                                     
       "32" = "Four",                                      
       "33 "= "Five",                                      
       "34" = "6-10",                                      
       "35" = "11-25",                                     
       "36" = "26-99",                                    
       "37" = "100-500",                                   
       "38" = "501-1000")

# recode number of persons injured - target
pvia_5$number_perpetrator <- recode(pvia_5$number_perpetrator,
       "01" = "1",
       "02" = "2",
       "03" = "3",
       "04" = "4",
       "05" = "5",
       "06" = "6-10",
       "07" = "11-25",
       "08" = "26-99",
       "09" = "100-500",
       "10" = "501-1000",
       "11" = "Over 1000",
       "97" = "Other")

# recode number of persons injured - target
pvia_5$injury_target[pvia_5$injury_target == "51"] <- "51-99"
pvia_5$injury_target[pvia_5$injury_target == "52"] <- "100-499"
pvia_5$injury_target[pvia_5$injury_target == "53"] <- "500-999"
pvia_5$injury_target[pvia_5$injury_target == "54"] <- "Over 1000"
pvia_5$injury_target[pvia_5$injury_target == "97"] <- "None"
pvia_5$injury_target[pvia_5$injury_target == "98"] <- NA
pvia_5$injury_target[pvia_5$injury_target == "99"] <- NA


# recode number of persons killed - target
pvia_5$fatalities_target[pvia_5$fatalities_target == "51"] <- "51-99"
pvia_5$fatalities_target[pvia_5$fatalities_target == "52"] <- "100-499"
pvia_5$fatalities_target[pvia_5$fatalities_target == "53"] <- "500-999"
pvia_5$fatalities_target[pvia_5$fatalities_target == "54"] <- "Over 1000"
pvia_5$fatalities_target[pvia_5$fatalities_target == "97"] <- "None"
pvia_5$fatalities_target[pvia_5$fatalities_target == "98"] <- NA
pvia_5$fatalities_target[pvia_5$fatalities_target == "99"] <- NA

# Filtering for specific attacks (deadly assault)
spec_pvia_5 <- pvia_5 %>% 
  filter(group_violence == "6")

# recode individual violence
spec_pvia_5$`weapon type 1` <- recode(spec_pvia_5$`weapon type 1`,
       "4" = "pistol")

# recode group violence
spec_pvia_5$group_violence <- recode(spec_pvia_5$group_violence, 
       "6" = "Deadly Assault (lynching, homocide)")

# recode reason
spec_pvia_5$reason <- recode(spec_pvia_5$reason,
       "42" = "Racial antagonism",
       "44" = "Differences in social viewpoints",
       "97" = "Other")

# recode individual injury
spec_pvia_5$injury_target <- recode(spec_pvia_5$injury_target,
      "0" = "None",
      "3" = "Wound, fatal",
      "9" = "NA")

# recode type of type of group target
spec_pvia_5$`target type 2` <- recode(spec_pvia_5$`target type 2`,
      "0" = "Racial group",
      "4" = "Political group",
      "5" = "Social protest group")

# recode type of perpetrator
spec_pvia_5$`perpetrator 1` <- recode(spec_pvia_5$`perpetrator 1`,
      "0" = "Federal office holder",
      "3" = "Primary political affiliation",
      "5" = "Primary racial affiliation")

# recode type of group perpetrator
spec_pvia_5$`perpetrator 2` <- recode(spec_pvia_5$`perpetrator 2`,
      "0" = "Racial group",
      "4" = "Political group")

# change class of fatalities target
spec_pvia_5$fatalities_target <- as.numeric(spec_pvia_5$fatalities_target)



