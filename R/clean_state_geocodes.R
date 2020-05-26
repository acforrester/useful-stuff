# Clean Census state geocodes ---------------------------------------------

# load packages
library(tidyverse); library(dplyr); library(httr)

# target URLs
url1 <- "https://www2.census.gov/programs-surveys/popest/geographies/2018/state-geocodes-v2018.xlsx"
url2 <- "https://www2.census.gov/geo/docs/reference/state.txt"

# col names
names1 <- c("region_code", "division_code", "state_code", "state_name")
names2 <- c("state_code", "usps", "state_name", "statens")

# USPS codes
usps_codes <- read_delim(url2, delim = "|", col_names = names2, skip = 1)

# sort the Excel file as temp file
httr::GET(url1, write_disk(tf <- tempfile(fileext = ".xlsx")))

# read in the UN data and format
dat <- readxl::read_excel(tf, skip = 6, col_names = names1) %>% 
  
  # get region name
  group_by(region_code) %>% 
  mutate(region_name = state_name[1]) %>% 
  
  # get division name
  group_by(division_code) %>% 
  mutate(division_name = state_name[1]) %>% 
  
  # ungroup
  ungroup(.) %>% 
  
  # get USPS codes
  full_join(., usps_codes, by = c("state_code", "state_name")) %>% 
  
  # make codes numeric
  mutate_at(., 1:3, as.numeric) %>% 
  
  # keep states
  filter(state_code %in% 1:56) %>% 
  
  # sort by state
  arrange(state_code) %>% 
  
  # order cols
  select(state_code, state_name, usps, 
         region_code, region_name, 
         division_code, division_name) %>% 
  
  # write as CSV
  write_csv(., "data/census-bureau/geo-codes/state-fips-codes.csv")

# ------------------------------------------------------------ #
# End of file