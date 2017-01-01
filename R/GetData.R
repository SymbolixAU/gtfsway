#' Get gtfs
#'
#' Downloads and extracts GTFS static data
#' @param url link to GTFS .zip
#' @param exctract logical indicating if the files should be extracted as data.frames into the global environment. If \code{FALSE} a list of data.frames is returned. If \code{TRUE} data.frames for each file are extracted into the Global Environment.
#' @return list of dataframes, one for each .txt file
#' @export
get_gtfs <- function(url, extract = TRUE){

	if(!is.logical(extract))
		stop("extract must be either TRUE or FALSE")

	temp_file <- tempfile()
	download.file(url, destfile = temp_file, mode = "wb")

	zipDir <- tempfile()
	dir.create(zipDir)

	files <- unzip(temp_file, list = T)
	zipFiles <- files[grepl("\\.zip$", files$Name), ]

	## extract all the .txt files
	lst <- apply(files, 1, function(x){
		if(grepl("\\.txt$", x["Name"])){
			fileName <- gsub("\\.txt$", "", x["Name"])
			lst <- list(read.csv(unz(temp_file, x["Name"]), stringsAsFactors = F))
			names(lst) <- fileName
			return(lst)
		}else{
			return()
		}
	})

	unlink(temp_file)
	unlink(zipDir)

	if(extract){
		for(i in seq_along(lst)){
			assign(paste0("dt_", names(lst[[i]])), lst[[i]][[1]], envir = .GlobalEnv)
		}
	}else{
		return(lst)
	}
}

