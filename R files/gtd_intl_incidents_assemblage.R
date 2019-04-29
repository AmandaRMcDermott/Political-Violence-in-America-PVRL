# gtd
library(tidyverse)

gtd <- read_excel("globalterrorismdb_0718dist (1).xlsx")

gtd <- gtd %>% 
  select(iyear,imonth, iday, summary, country, attacktype1, nkill, nwound)

gtd <- gtd %>% 
  filter(country != 217, attacktype1 == 1)

gtd_sum <- gtd %>% 
  group_by(iyear) %>% 
  count(nkill) %>% 
  summarize(gtd_incidents = sum(n))
write_csv(gtd_sum, "gtd_nkill_sum.csv")
