# Author: Lucas Roesler
# Date: 2014-07-12
# Purpose: generate a histogram plot of Global Active Power 
#          for the dates of 2007-02-01 and 2007-02-02.  The 
#          will download and extrac the dataset and it will 
#          also install and use the data.table library.

if(!require("data.table", character.only=T)){
    install.packages("data.table")
    require(data.table)
}

if(!file.exists("household_power_consumption.zip")){
    download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip",method="curl")
}

unzip("household_power_consumption.zip")

# load the data
f <- file.path(getwd(), 'household_power_consumption.txt')
d <- fread(f, sep=";", na.strings=c('?'))
# subset the data to just between 2007-02-01 -- 2007-02-02
d <- d[Date %in% c('1/2/2007',  '2/2/2007')]

png(file="plot1.png", width=480, height=480, units="px")
hist(as.numeric(d$Global_active_power), 
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()

