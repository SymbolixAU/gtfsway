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
