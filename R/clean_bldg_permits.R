#' ---------------------------------------------------------------------------- #
#'
#' get_permits.R
#'
#' authors:	AC Forrester
#' created: 05.02.2020
#' updated: 
#'
#' purpose: Collect the Census Bureau building permits data.
#'
#' args:
#' 
#'  years  - list of years to get
#'  path   - path where subfolders are located
#'
#' ---------------------------------------------------------------------------- #
get_permits <- function(years, path, geo = c("State", "Metro", "County", "Place"))
{
  
  ## checks - only in 1990-2019
  if(!(years %in% 1990:2019)){
    break()
  }
  
  ## program start
  
  cat("------------------------------------- \n")
  cat(" Downloading Bldg Permits ", min(years), " - ", max(years), "\n\n")
  
  ## read schema
  schema <- read_csv(paste0(path, "/", "schema/schema_county.csv"))
    
  # loop over years
  for(year in years){
    
    ## file to read
    in_file  <- paste0("https://www2.census.gov/econ/bps/", "County", "/", "co", year, "a.txt")
    
    ## output file
    out_file <- paste0(path, "/", "csv", "/", "co", year, "a.csv")
    
    ## read file from url
    dat <- read_csv(in_file, col_names = schema$variable_name, skip = 3) %>% 
      
      write_csv(., out_file, col_names = T)
    
  }
  
}



