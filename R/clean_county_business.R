#' ---------------------------------------------------------------------------- #
#'
#' clean_cbp
#'
#' authors:	AC Forrester
#' created: 03.11.2020
#' updated: 03.12.2020
#'
#' purpose: Subset the County Business Patterns by 2-digit NAICS code
#'
#' args:
#' 
#'  years      - list of years to get
#'  zip_path   - path to the input ZIP file
#'  csv_path   - path to output the CSV
#'
#' ---------------------------------------------------------------------------- #
clean_cbp <- function(years, zip_path, csv_path){
		
	# checks - only in 1986-2017
	if(min(years) < 1986 || max(years) > 2017){
		break()
	}
	
	## program start
	
	cat("------------------------------------- \n")
	cat(" Subsetting CBP ", min(years), " - ", max(years), "\n\n")
	
	# loop over years
	for(year in years){
		
		# destination file name
		zip_file <- paste0("cbp",sprintf("%02.0f", year %% 100), "co.zip")
		
		# csv file
		csv_file <- paste0("cbp_2dig_", year, ".csv")
		
		# download file if needed
		if(!file.exists(file.path(csv_path, csv_file))){
		
			# read the file
			dat <- read_csv(file.path(zip_path, zip_file),
							 progress = F) 
			
			# names to lower case
			names(dat) <- tolower(names(dat))
			
			# subset the CBP data
			dat %>% 
				
				# fix naics
				mutate(naics = str_replace_all(naics, "-----", "0"),
							 naics = str_replace_all(naics, "-", ""),
							 naics = str_replace_all(naics, "/", ""),
							 naics = as.numeric(naics),
							 year = 2012
							 ) %>% 
				
				# filter two digit
				filter(naics %in% 0:99) %>% 
				
				# rename FIPS codes
				rename(state_code  = fipstate,
							 county_code = fipscty) %>% 
				
				# order cols and remove census codes
				select(state_code, 
							 county_code, 
							 year, 
							 naics, 
							 everything(), 
							 -c("censtate", "cencty")) %>% 
				
				# write as CSV
				write_csv(., file.path(csv_path, csv_file), na = "")
		
			cat("  subset CBP ", year, " \n")
		}	else {
			cat("  Already have CBP ", year, "moving on \n")
		}
				
	}
	
	cat(" Done!")
	
}
