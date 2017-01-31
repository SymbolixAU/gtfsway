#' GTFS real time
#'
#' Parses the response from a GTFS real-time feed
#'
#' @param response binary response body
#' @return FeedMessage RProtoBuf object containing the feed message
#' @examples
#' \dontrun{
#' ## South-East Queensland
#' url <- "https://gtfsrt.api.translink.com.au/Feed/SEQ"
#'
#' response <- httr::GET(url,
#' httr::accept_json(),
#' httr::add_headers('Authorization' = ''))
#'
#' feed <- gtfs_realtime(response)
#'
#' }
#' @export
gtfs_realtime <- function(response){

	b <- readBin(response$content, raw(0), length(response$content) )

	# Alert <- RProtoBuf::read(transit_realtime.Alert, b)
	# EntitySelector <- RProtoBuf::read(transit_realtime.EntitySelector, b)
	# FeedEntity <- RProtoBuf::read(transit_realtime.FeedEntity, b)
	# FeedHeader <- RProtoBuf::read(transit_realtime.FeedHeader, b)
	FeedMessage <- RProtoBuf::read(transit_realtime.FeedMessage, b)
	# VehiclePosition <- RProtoBuf::read(transit_realtime.Position, b)
	# TimeRange <- RProtoBuf::read(transit_realtime.TimeRange, b)
	# TranslatedString <- RProtoBuf::read(transit_realtime.TranslatedString, b)
	# TripDescriptor <- RProtoBuf::read(transit_realtime.TripDescriptor, b)
	# TripUpdate <- RProtoBuf::read(transit_realtime.TripUpdate, b)
	# TripUpdate.StopTimeEvent <- RProtoBuf::read(transit_realtime.TripUpdate.StopTimeEvent, b)
	# TripUpdate.StopTimeUpdate <- RProtoBuf::read(transit_realtime.TripUpdate.StopTimeUpdate, b)
	# VehicleDescriptor <- RProtoBuf::read(transit_realtime.VehicleDescriptor, b)
	# VehiclePosition <- RProtoBuf::read(transit_realtime.VehiclePosition, b)

	## return objects (s4) of all these, then call various methods to extract useful data

	return(FeedMessage)

}


#' GTFS Trip Updates
#'
#' Returns a list of trip update information
#'
#' @param FeedMessage returned from \link{gtfs_realtime}
#' @return list of \code{data.table} trip update tables
#' @examples
#' \dontrun{
#'
#' ## South-East Queensland
#' url <- "https://gtfsrt.api.translink.com.au/Feed/SEQ"
#'
#' response <- httr::GET(url,
#' httr::accept_json(),
#' httr::add_headers('Authorization' = ''))
#'
#' FeedMessage <- gtfs_realtime(response)
#' lst <- gtfs_tripUpdates(FeedMessage)
#' }
#'
#' @export
gtfs_tripUpdates <- function(FeedMessage){

	trip_update_idx <- lapply(FeedMessage$entity, function(x) { length(x[['trip_update']]) > 0 })
#	vehicle_update_idx <- lapply(FeedMessage$entity, function(x) { length(x[['vehicle']]) > 0 })

	trip_updates <- FeedMessage$entity[which(trip_update_idx == T)]
#	vehicle_positions <- FeedMessage$entity[which(vehicle_update_idx == T)]

	lst <- lapply(trip_updates, function(x){

		trip_id = x[['trip_update']][['trip']][['trip_id']]
		start_time = x[['trip_update']][['trip']][['start_time']]
		start_date = x[['trip_update']][['trip']][['start_date']]
		route_id = x[['trip_update']][['trip']][['route_id']]

		stop_time_update <- x[['trip_update']][['stop_time_update']]

		stop_time_update <- lapply(stop_time_update, function(y){
			return(data.table::data.table(
				stop_sequence = y[['stop_sequence']],
				stop_id = y[['stop_id']],
				arrival_time = y[['arrival']][['time']],
				departure_time = y[['departure']][['time']]
			))
		})
		dt_stop_time_update <- data.table::rbindlist(stop_time_update, use.names = T, fill = T)

		dt_trip_info <- data.table::data.table(trip_id = trip_id,
																					 start_time = start_time,
																					 start_date = start_date,
																					 route_id = route_id)


		return(list(dt_trip_info = dt_trip_info,
								dt_stop_time_update = dt_stop_time_update))

	})
}
