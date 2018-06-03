rm(list=ls())
setwd("~/Coursera/R/Exploratory data analysis/assignment1")

library(dplyr)
library(lubridate)

## loading dataset
dataset <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)
dataset <- dataset %>% na.omit
dataset$date_time <- paste(dataset$Date, dataset$Time, sep=" ")
dataset <- select(dataset, -Date, -Time)
dataset$date_time <- dmy_hms(dataset$date_time)
dataset <- select(dataset, date_time, Global_active_power:Sub_metering_3)

## seleting the data in date range of interest
dataset_of_interest <- filter(dataset, date_time >= ymd("2007-02-01") & date_time < ymd("2007-02-03"))

## Plot 3 - Line graph of energy sub_metering
# -- file device --
png(filename="plot3.png", width = 480, height = 480, units = "px")
with(dataset_of_interest, plot(date_time, Sub_metering_1, type="n", ylab="energy sub metering",
                               xlab="Days of the Week"))
with(dataset_of_interest, points(date_time, Sub_metering_1, type="l", col="black"))
with(dataset_of_interest, points(date_time, Sub_metering_2, type="l", col="red"))
with(dataset_of_interest, points(date_time, Sub_metering_3, type="l", col="blue"))
legend("topright", legend=c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5),
       col=c("black", "red", "blue"))
mtext("plotted by: Chenghao", side=1, line=4)
dev.off()