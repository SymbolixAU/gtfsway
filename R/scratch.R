
# # ## sydney
# url <- "http://transitfeeds.com/p/transport-for-nsw/237/latest/download"
# lst <- gtfsway:::get_gtfs(url)
#
#
# #system.file("proto", package = "gtfsway", mustWork = T)
#
# proto.dir <- system.file("proto", package = "gtfsway", mustWork = T)
# proto.file <- file.path(proto.dir, "gtfs-realtime.proto")
#
# dir( proto.dir, pattern = "\\.proto$", full.names = TRUE )
#
#
# ## put the readProtoFiles in onLoad
# readProtoFiles(package = "gtfsway")
# ls( "RProtoBuf:DescriptorPool" )
#
#
#url <- "https://api.transport.nsw.gov.au/v1/gtfs/realtime/nswtrains"
#url <- "https://api.transport.nsw.gov.au/v1/gtfs/realtime/sydneytrains"
#
# key <- read.dcf("~/Documents/.gtfsrealtime", field = "API_TFNSW")
#
# ## Cairnes
# url <- "https://gtfsrt.api.translink.com.au/Feed/MCS"
#
#
# ## South-East Queensland
# url <- "https://gtfsrt.api.translink.com.au/Feed/SEQ"
#
# response <- httr::GET(url,
# 											httr::accept_json(),
# 											httr::add_headers('Authorization' = ''))
#
#
# b <- readBin(response$content, raw(0), length(response$content) )
#
# Alert <- read(transit_realtime.Alert, b)
# EntitySelector <- read(transit_realtime.EntitySelector, b)
# FeedEntity <- read(transit_realtime.FeedEntity, b)
# FeedHeader <- read(transit_realtime.FeedHeader, b)
# FeedMessage <- read(transit_realtime.FeedMessage, b)
# Position <- read(transit_realtime.Position, b)
# TimeRange <- read(transit_realtime.TimeRange, b)
# TranslatedString <- read(transit_realtime.TranslatedString, b)
# TripDescriptor <- read(transit_realtime.TripDescriptor, b)
# TripUpdate <- read(transit_realtime.TripUpdate, b)
# TripUpdate.StopTimeEvent <- read(transit_realtime.TripUpdate.StopTimeEvent, b)
# TripUpdate.StopTimeUpdate <- read(transit_realtime.TripUpdate.StopTimeUpdate, b)
# VehicleDescriptor <- read(transit_realtime.VehicleDescriptor, b)
# VehiclePosition <- read(transit_realtime.VehiclePosition, b)
#
# writeLines(as.character(Alert))
# writeLines(as.character(EntitySelector))
# writeLines(as.character(FeedHeader))
# writeLines(as.character(FeedMessage))
# writeLines(as.character(Position))
# writeLines(as.character(TimeRange))
# writeLines(as.character(TranslatedString))
# writeLines(as.character(TripDescriptor))
# writeLines(as.character(TripUpdate))
# writeLines(as.character(TripUpdate.StopTimeEvent))
# writeLines(as.character(TripUpdate.StopTimeUpdate))
# writeLines(as.character(VehicleDescriptor))
# writeLines(as.character(VehiclePosition))
#
# lapply(FeedMessage$entity, as.character)[[1]]
#
# writeLines(as.character(FeedMessage$entity[[10]]$trip_update))
#
# FeedMessage$entity[[5]]$trip_update$trip$trip_id
# FeedMessage$entity[[5]]$trip_update$stop_time_update[[1]]$departure[[3]]
#
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
#
#
#
#
# str(message)
#
# writeLines( as.character( message ) )
#
# writeLines(as.character(message$stop_time_update[[1]]))
#
# message$stop_time_update[[129]]$stop_id
#
# message$stop_time_update[[2]]$schedule_relationship
# message$stop_time_update[[2]]$stop_sequence
# message$stop_time_update[[2]]$stop_id
# message$stop_time_update[[2]]$arrival
# message$stop_time_update[[2]]$departure
#
# length(message$stop_time_update)
#
# message$stop_time_update[[240]]$departure
#
# length(message$stop_time_update)
#
# writeLines(as.character(message$stop_time_update[[251]]$departure))
#
# message$stop_time_update[[251]]$departure
#
# message$as.character()
#
# writeLines(message$toString())
#
# message$toString()
#
# transit_realtime.TripUpdate$as.list()
#
# transit_realtime.TripUpdate$StopTimeUpdate$toString()


#
# ## http://transitfeeds.com/p/ptv/497
#
# ## melbourne
# url <- "http://transitfeeds.com/p/ptv/497/latest/download"
#
#
# ## portland
# url <- "http://developer.trimet.org/schedule/gtfs.zip"
#
# ## orange county
# url <- "http://www.octa.net/current/google_transit.zip"
#
#
# ## sydney
# url <- "http://transitfeeds.com/p/transport-for-nsw/237/latest/download"
#
#
# lst <- get_gtfs(url)
#
#
# library(data.table)
#
# ## Melbourne
# dt_routes <- lst[[4]]$data
# setDT(dt_routes)
#
#
# ## sydney
# sapply(lst, function(x) x["file"])
#
# dt_agency <- lst[[1]]$data
# setDT(dt_agency)
#
# dt_stops <- lst[[2]]$data
# setDT(dt_stops)
#
# dt_routes <- lst[[3]]$data
# setDT(dt_routes)
#
# dt_calendar <- lst[[4]]$data
# setDT(dt_calendar)
#
# dt_trips <- lst[[7]]$data
# setDT(dt_trips)
#
# dt_stoptimes <- lst[[8]]$data
# setDT(dt_stoptimes)
#
