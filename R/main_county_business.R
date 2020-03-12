#' ---------------------------------------------------------------------------- #
#'
#' clean_county_business.R
#'
#' authors:	AC Forrester
#' created: 03.11.2020
#' updated: 03.12.2020
#'
#' purpose: Clean the County Business Patterns (CBP) data.
#'
#' ---------------------------------------------------------------------------- #
	
	# file destinations
	zip_dest <- "E:/projects/useful-stuff/data/census-bureau/county-business/zip"
	csv_dest <- "E:/projects/useful-stuff/data/census-bureau/county-business/csv"
	
# ---------------------------------------------------------------------------- #
# Run through the `get` and `clean` functions
# ---------------------------------------------------------------------------- #

	# run the `get_cbp` function
	get_cbp(2000:2017, zip_dest)
	
	# run the `clean_cbp` function
	clean_cbp(2015:2017, zip_dest, csv_dest)

# ---------------------------------------------------------------------------- #
# End of file