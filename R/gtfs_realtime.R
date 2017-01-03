#' GTFS real time
#'
#' Parses the response from a GTFS real-time feed
#'
#' @param response binary response body
#' @export
gtfs_realtime <- function(response){

	b <- readBin(response$content, raw(0), length(response$content) )

	Alert <- read(transit_realtime.Alert, b)
	EntitySelector <- read(transit_realtime.EntitySelector, b)
	FeedEntity <- read(transit_realtime.FeedEntity, b)
	FeedHeader <- read(transit_realtime.FeedHeader, b)
	FeedMessage <- read(transit_realtime.FeedMessage, b)
	VehiclePosition <- read(transit_realtime.Position, b)
	TimeRange <- read(transit_realtime.TimeRange, b)
	TranslatedString <- read(transit_realtime.TranslatedString, b)
	TripDescriptor <- read(transit_realtime.TripDescriptor, b)
	TripUpdate <- read(transit_realtime.TripUpdate, b)
	TripUpdate.StopTimeEvent <- read(transit_realtime.TripUpdate.StopTimeEvent, b)
	TripUpdate.StopTimeUpdate <- read(transit_realtime.TripUpdate.StopTimeUpdate, b)
	VehicleDescriptor <- read(transit_realtime.VehicleDescriptor, b)
	VehiclePosition <- read(transit_realtime.VehiclePosition, b)

	## return objects (s4) of all these, then call various methods to extract useful data

}


## Example function to return updated stop_times
#
# library(data.table)
# lst <- lapply(FeedMessage$entity, function(x){
# 	trip_id = x[['trip_update']][['trip']][['trip_id']]
# 	start_time = x[['trip_update']][['trip']][['start_time']]
# 	start_date = x[['trip_update']][['trip']][['start_date']]
# 	route_id = x[['trip_update']][['trip']][['route_id']]
# 	stop_time_update <- x[['trip_update']][['stop_time_update']]
#
# 	if(length(stop_time_update) > 0){
#
# 		stop_time_update <- lapply(stop_time_update, function(y){
# 			return(data.table::data.table(
# 				stop_sequence = y[['stop_sequence']],
# 				stop_id = y[['stop_id']],
# 				arrival_time = y[['arrival']][['time']],
# 				departure_time = y[['departure']][['time']]
# 			))
# 		})
# 		dt_stop_time_update <- data.table::rbindlist(stop_time_update, use.names = T, fill = T)
# 	}else{
# 		dt_stop_time_udpate <- data.table::data.table()
# 	}
#
# 	dt_trip_info <- data.table::data.table(trip_id = trip_id,
# 														 start_time = start_time,
# 														 start_date = start_date,
# 														 route_id = route_id)
#
# 	return(list(dt_trip_info = dt_trip_info,
# 							dt_stop_time_update = dt_stop_time_update))
#
# })



