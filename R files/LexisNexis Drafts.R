# Lexis Nexis
library(LexisNexisTools)
library(nyt)
library(purrr)
library(dplyr)
library(stringr)
library(tm.plugin.lexisnexis)


# paste nyt api key
apikey <- paste0("NYTIMES_KEY=", "8v8ojxWmMFUJWqkQ")

## make path to .Renviron
file <- file.path(path.expand("~"), ".Renviron")

## save environment variable
cat(apikey, file = file, append = TRUE, fill = TRUE)

test <- nyt_search("test", n = 200)


us1 <- nyt_articles(section = "us", page = 1)

us2 <- purrr::map(1:100, ~ nyt_articles(section = "world", page = .x))
nyt <- dplyr::bind_rows(us2)
str_de

test <- nytimes::nyt_search("assassinate", n = 100, end_date = "19540101", apikey = "5APNpTufzFuGRG0Bsij3aAAIwEbgcuR9") %>% 
  as.data.frame()

# words to test for
contains <- c("killed", "assassinated", "assassinate", "assassinates", "assassinating")
str_detect(test3[2,17], contains)

test3 <- nyt_articles("assassinated", section = "us", page = 1)


# lexisnexis



setwd("~/Downloads/pdftotext")

LNToutput <- lnt_read(list.files())
