#' Get the county-level NOAA files
#'
#' This function gets the county-level temperature, precipitation, etc
#' files from NOAA's FTP site. 
#'
#' ========================================================================== '#

library(tidyverse)
library(dplyr)
library(haven)

#' ========================================================================== '#
#' 
#' get_climdiv
#' 
#' `dest`   - desired output destination
#' `schema` - location for file schema
#' 
#' ========================================================================== '#
get_climdiv <- function(dest, schema)
{

	# schema files
	scm <- read_csv(file.path(schema, "file_layout.csv"))
	
	# state codes
	state <- read_csv(file.path(schema, "state_codes.csv"))
		
	# FWF setup
	setup <- fwf_positions(scm$start, scm$end,scm$variable_name)
	
	# file types
	files <- c("pcpncy", "tmaxcy", "tmincy", "tmpccy")
	
	# loop over the file types
	for(file in files){
		
		# make URL and output file names
		url <- gsub("FILE", file, "ftp://ftp.ncdc.noaa.gov/pub/data/cirs/climdiv/climdiv-FILE-v1.0.0-20200204")
		out <- file.path(dest,gsub("FILE", file, "climdiv-FILE.csv"))
				
		# make file if needed
		if(!file.exists(out)){
			dat <- read_fwf(url, setup) %>% 
				mutate_all(., as.numeric) %>% 
				left_join(., state, by = "state_code_noaa") %>% 
				select(state_code, county_code, everything(), -state_code_noaa, -state_name)
			write_csv(dat, out)			
		} # end conditional
		
	} # end loop
	
}

#' ========================================================================== '#
#' get the NOAA files
#' ========================================================================== '#

# schema and output directories
schema <- "E:/projects/useful-stuff/data/noaa-data/county-data/schema"
output <- "E:/projects/useful-stuff/data/noaa-data/county-data/csv"

# get the files
get_climdiv(output,schema)

