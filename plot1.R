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

## Plot 1 - Histogram of global active power
# -- file device --
png(filename="plot1.png", width = 480, height = 480, units = "px")
hist(dataset_of_interest$Global_active_power, xlab = "Global Active Power (kilowatts)", col="red", main = "Global Active Power")
mtext("plotted by: Chenghao", side=1, line=4)
dev.off()