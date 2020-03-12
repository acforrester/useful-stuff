#' ---------------------------------------------------------------------------- #
#'
#' get_cbp
#'
#' authors:	AC Forrester
#' created: 03.11.2020
#' updated: 
#'
#' purpose: Collect the Census Bureau County Business Patterns data
#'
#' args:
#' 
#'  years  - list of years to get
#'  dest   - destination to place the zip files
#'
#' ---------------------------------------------------------------------------- #
get_cbp <- function(years, dest)
{
	
	# checks - only in 1986-2017
	if(min(years) < 1986 || max(years) > 2017){
		break()
	}
	
	## program start
	
	cat("------------------------------------- \n")
	cat(" Downloading CBP ", min(years), " - ", max(years), "\n\n")
	
	# loop over years
	for(year in years){
		
		# destination file name
		file <- paste0("cbp", 
									 sprintf("%02.0f", year %% 100),
									 "co.zip")
		
		# make URL	
		url <- paste0("https://www2.census.gov/programs-surveys/cbp/datasets/",
									year,
									"/",
									file)
	
		# download file if needed
		if(!file.exists(file.path(dest, file))){
			download.file(url, 
										file.path(dest,file), 
										mode = "wb",
										quiet = T)
			cat("  Downloaded CBP ", year, " \n")
		}	else {
			cat("  Already have CBP ", year, "moving on \n")
		}
				
	}
	
}
