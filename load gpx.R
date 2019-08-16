# load gpx
#tiny helper function
matchtimes <- function(t1, t2) {
# t1, t2 are numeric
	findInterval(t1, c(-Inf, head(t2, -1)) + c(0, diff(t2)/2))
}


library(plotKML)

fname <- file.choose()
a1 <- readGPX(fname)

tracks <- as.data.frame(a1$tracks)
names(tracks) <- c("lon", "lat", "elevation", "time")
head(tracks)

# library(rworldmap)
# worldmap <- getMap(resolution = "high")
# plot(tracks$lon, tracks$lat, type = 'n', xlab = "", ylab = "")
# plotlims <- par()$usr
# dev.off()

# plot(worldmap, xlim = c(plotlims[1], plotlims[2]), ylim = c(plotlims[3], plotlims[4]))
# col <- rainbow(nrow(tracks))
# points(tracks$lon, tracks$lat, col = "red", pch = 16, cex = .2)

# a2 <- readGPX("file2.gpx")
# tracks2 <- as.data.frame(a2$tracks)
# names(tracks2) <- c("lon", "lat", "elevation", "time")
# head(tracks2)

# points(tracks2$lon, tracks2$lat, pch = 16, cex = .2, col = "blue")


# search for specific times
getdatetime <- function(tt) {
	datetime <- strsplit(tt, "T")
	date <- sapply(datetime, '[[', 1)
	time <- sapply(datetime, '[[', 2)
	time <- gsub("Z", "", time)
	
	datetime1 <- paste(date, time, "UTC")
	as.numeric(as.POSIXct(datetime1, tz = "UTC"))
}
t1 <- getdatetime(tracks$time)
# t2 <- getdatetime(tracks2$time)


searchtime1 <- as.numeric(as.POSIXct("2019-08-11 17:05:30", tz = "UTC"))
dis1 <- matchtimes(searchtime1, t1)
tracks[dis1, ]

# # searchtime2 <- as.numeric(as.POSIXct("2017-06-03 17:56:00 UTC", tz = "UTC"))
# dis2 <- matchtimes(searchtime2, t2)


# tracks2[dis2, ]

# points(tracks$lon[dis1], tracks$lat[dis1], col = "Purple", pch = 0)
# points(tracks2$lon[dis2], tracks2$lat[dis2], col = "Purple", pch = 0)


# # plot with speed
# source("distance.R")
# n <- nrow(tracks)
# distances <- c(NA, latlond(tracks$lat[1:(n-1)], tracks$lon[1:(n-1)], tracks$lat[2:n], tracks$lon[2:n]))
# timediffs <- c(NA, diff(t1))
# speeds <- distances / (timediffs/60/60)

# tz1 <- tracks
# cond <- tz1$lon > -74.6 & tz1$lon < -74.56 & tz1$lat > 35.45 & tz1$lat < 35.5
# col <- rainbow(length(which(cond)))
# plot(tz1$lon[cond], tz1$lat[cond], col = col)


# it <- read.table("imagetimes_20170602_s4.csv", header = TRUE, sep = ',', stringsAsFactors = TRUE)
# it <- it[-6, ]
# ct <- function(t) as.numeric(as.POSIXct(t, tz = "UTC"))
# m <- matchtimes(ct(it$DateTimeOriginal), t1)

# points(tz1$lon[m], tz1$lat[m], pch = 0, cex = 2)