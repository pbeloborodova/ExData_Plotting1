# Submission for Week 1

setwd("/Users/polina/R/Coursera/DataScience/4_ExploratoryAnalysis/Week1")
library(readr)
library(dplyr)

# Part 1. Load the data

# (1) Calculate a rough estimate of how much memory the dataset will require
# Formula: memory required = no. of column * no. of rows * 8 bytes
(2075259*9*8)/1000000

# (2) Download and unzip data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "/Users/polina/R/Coursera/DataScience/4_ExploratoryAnalysis/Week1/household_power_consumption.zip",
              method = "curl")

unzip("household_power_consumption.zip")

# (3) Read file and subset data from the dates 2007-02-01 and 2007-02-02
household_power_consumption <-
  read.table("household_power_consumption.txt",
             header = TRUE, quote = "\"", sep = ";", na.strings = "?")

df <- subset(household_power_consumption,
             Date == "1/2/2007" | Date == "2/2/2007")

rm(household_power_consumption)  # Remove original df to free memory

colnames(df) <- tolower(colnames(df))  # Change column names to lower register
sum(is.na(df))  # Check if there are missing values

# (3) Add a joint date-time variable

df$date_time <- as.POSIXct(paste(df$date, df$time), format = "%d/%m/%Y %H:%M:%S")

# Part 2. Make plot

# 1. Open png file
png("plot2.png", width = 480, height = 480)

# 2. Make plot
plot(df$date_time, df$global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# 3. Close the file
dev.off()