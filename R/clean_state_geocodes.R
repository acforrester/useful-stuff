# Clean Census state geocodes ---------------------------------------------

# load packages
library(tidyverse); library(dplyr); library(httr)

# target URL
url1 <- "https://www2.census.gov/programs-surveys/popest/geographies/2018/state-geocodes-v2018.xlsx"

# col names
names <- c("region_code", "division_code", "state_code", "state_name")

# sort the Excel file as temp file
httr::GET(url1, write_disk(tf <- tempfile(fileext = ".xlsx")))

# read in the UN data and format
dat <- readxl::read_excel(tf, skip = 6, col_names = names) %>% 
  
  # get region name
  group_by(region_code) %>% 
  mutate(region_name = state_name[1]) %>% 
  
  # get division name
  group_by(division_code) %>% 
  mutate(division_name = state_name[1]) %>% 
  
  # ungroup
  ungroup(.) %>% 
  
  # make codes numeric
  mutate_at(., 1:3, as.numeric) %>% 
  
  # keep states
  filter(state_code > 0) %>% 
  
  # sort by state
  arrange(state_code) %>% 
  
  # order cols
  select(state_code, state_name, 
         region_code, region_name, 
         division_code, division_name) %>% 
  
  # write as CSV
  write_csv(., "data/census-bureau/geo-codes/state-fips-codes.csv")

# ------------------------------------------------------------ #
# End of file