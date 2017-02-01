
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
#
# library(data.table)
# gtfs_url <- "https://transitfeeds.com/p/translink/21/latest/download"
# lst_gtfs <- get_gtfs(gtfs_url, extract = TRUE)
#
#
# url <- "https://gtfsrt.api.translink.com.au/Feed/SEQ"
# response <- httr::GET(url)
#
# FeedMessage <- gtfs_realtime(response)
# lst <- gtfs_tripUpdates(FeedMessage)
#
# lst[[45]]


# url <- "https://gtfsrt.api.translink.com.au/Feed/SEQ"
# response <- httr::GET(url)
#
#
#
# fm <-	gtfs_realtime(response, content = "Alert")
#
# str(fm)
#
# fm@type
#
# lst <- gtfs_tripUpdates(fm)








