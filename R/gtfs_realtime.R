#' GTFS real time
#'
#' Parses the raw response from a GTFS real-time feed
#'
#' @param response binary response body
#' @param content String specifying which section of the response to return
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
#' feed <- gtfs_realtime(response, content = "FeedMessage")
#'
#' }
#' @export
gtfs_realtime <- function(response, content = c("FeedMessage",
																								"Alert",
																								"EntitySelector",
																								"FeedEntity",
																								"FeedHeader",
																								"VehiclePosition",
																								"TimeRange",
																								"TranslateedString",
																								"TripDescriptor",
																								"TripUpdate",
																								"TripUpdate.StopTimeEvent",
																								"TripUpdate.StopTimeUpdate",
																								"VehicleDescriptor",
																								"Vehicle")){

	content <- match.arg(content)

	validate_response(response)

	b <- readBin(response$content, raw(0), length(response$content) )

	res <- switch(content,
								"Alert" = RProtoBuf::read(transit_realtime.Alert, b),
								"EntitySelector" = RProtoBuf::read(transit_realtime.EntitySelector, b),
								"FeedEntity" = RProtoBuf::read(transit_realtime.FeedEntity, b),
								"FeedHeader" = RProtoBuf::read(transit_realtime.FeedHeader, b),
								"FeedMessage" = RProtoBuf::read(transit_realtime.FeedMessage, b),
								"VehiclePosition" = RProtoBuf::read(transit_realtime.Position, b),
								"TimeRange" = RProtoBuf::read(transit_realtime.TimeRange, b),
								"TranslatedString" = RProtoBuf::read(transit_realtime.TranslatedString, b),
								"TripDescriptor" = RProtoBuf::read(transit_realtime.TripDescriptor, b),
								"TripUpdate" = RProtoBuf::read(transit_realtime.TripUpdate, b),
								"TripUpdate.StopTimeEvent" = RProtoBuf::read(transit_realtime.TripUpdate.StopTimeEvent, b),
								"TripUpdate.StopTimeUpdate" = RProtoBuf::read(transit_realtime.TripUpdate.StopTimeUpdate, b),
								"VehicleDescriptor" = RProtoBuf::read(transit_realtime.VehicleDescriptor, b),
								"VehiclePosition" = RProtoBuf::read(transit_realtime.VehiclePosition, b)
	)
	return(res)
}


#' GTFS Trip Updates
#'
#' Returns a list of trip update information given a FeedMessage input
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
#' lst <- gtfs_tripUpdates(gtfs_realtime(response, content = "FeedMessage"))
#' }
#'
#' @export
gtfs_tripUpdates <- function(FeedMessage){

	## validate FeedMessage
	if(!"transit_realtime.FeedMessage" %in% attributes(FeedMessage))
		stop("FeedMessage must be a FeedMesssage response")


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
				arrival_delay = y[['arrival']][['delay']],
				departure_time = y[['departure']][['time']],
				departure_delay = y[['departure']][['delay']]
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




# gtfs_realtimeData.transit_realtime.Alert <- function(){
# 	print("getting Alert data")
# }
#
# gtfs_realtimeData.transit_realtime.FeedMessage <- function(resposne){
# 	print("getting FeedMessage data")
# 	gtfs_tripUpdates(response)
# }



validate_response <- function(response){
	if(response[['status_code']] != 200){
		warning("The response did not have a status code of 200")
	}
}



