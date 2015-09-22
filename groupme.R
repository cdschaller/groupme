filename <- '~/Desktop/Hobbies/groupme-tools-master/transcript-8322711.json'
#filename <- '~/Desktop/groupme-tools-master/vegas_group.json'

library(rjson)
library(dplyr)

group <- fromJSON(file = filename)
favs <- lapply(group, function(x) {
  paste(unlist(x$favorited_by), collapse = ', ')})
group <- lapply(group, function(x) {
  x[sapply(x, is.null)] <- NA
  x <- unlist(x)
  x <- x[!grepl('favorited_by', names(x))]
  return(x)
})
group <- do.call("rbind", group)
group <- as.data.frame(group)
group$favorited_by <- unlist(favs)
group$datetime <- as.POSIXct(as.numeric(as.character(group$created_at)), origin="1970-01-01")

