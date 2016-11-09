#' Get gtfs
#'
#' Downloads and extracts GTFS static data
#' @param url link to GTFS .zip
#' @return list of dataframes, one for each .txt file
get_gtfs <- function(url){

	temp_file <- tempfile()
	download.file(url, destfile = temp_file, mode = "wb")

	zipDir <- tempfile()
	dir.create(zipDir)

	files <- unzip(temp_file, list = T)
	zipFiles <- files[grepl("\\.zip$", files$Name), ]

	## if 'files' is a data.frame with a column of '.txt' files, we can use it!

	lst <- apply(files, 1, function(x){
		## extract all the .txt files
		if(grepl("\\.txt$", x["Name"])){
			lst <- list(file = x["Name"],
									data = read.csv(unz(temp_file, x["Name"]), stringsAsFactors = F)
									)
		}else{
			lst <- list()
		}
		return(lst)
	})

	unlink(temp_file)
	unlink(zipDir)

	return(lst)

}

