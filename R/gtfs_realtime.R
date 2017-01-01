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
	Position <- read(transit_realtime.Position, b)
	TimeRange <- read(transit_realtime.TimeRange, b)
	TranslatedString <- read(transit_realtime.TranslatedString, b)
	TripDescriptor <- read(transit_realtime.TripDescriptor, b)
	TripUpdate <- read(transit_realtime.TripUpdate, b)
	TripUpdate.StopTimeEvent <- read(transit_realtime.TripUpdate.StopTimeEvent, b)
	TripUpdate.StopTimeUpdate <- read(transit_realtime.TripUpdate.StopTimeUpdate, b)
	VehicleDescriptor <- read(transit_realtime.VehicleDescriptor, b)
	VehiclePosition <- read(transit_realtime.VehiclePosition, b)

}
