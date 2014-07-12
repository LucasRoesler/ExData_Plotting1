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
# Convert the Date and Time into a Timestamp column
d$Timestamp <- paste(d$Date, d$Time)
d$Timestamp <- as.POSIXct(d$Timestamp, format="%d/%m/%Y %H:%M:%S")
# coerce data into numeric formats
d$Global_active_power <- as.numeric(d$Global_active_power)
d$Global_reactive_power <- as.numeric(d$Global_reactive_power)
d$Voltage <- as.numeric(d$Voltage)
d$Global_intensity <- as.numeric(d$Global_intensity)
d$Sub_metering_1 <- as.numeric(d$Sub_metering_1)
d$Sub_metering_2 <- as.numeric(d$Sub_metering_2)
d$Sub_metering_3 <- as.numeric(d$Sub_metering_3)



png(file="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
# top left plot, timeseries of Global active power
plot(d$Global_active_power ~ d$Timestamp, 
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

# top right, timeseries of Voltage
plot(d$Voltage ~ d$Timestamp,
     type="l",
     xlab="datetime",
     ylab="Voltage")

# bottom left, timeseries of Sub metering 
plot(d$Sub_metering_1 ~ d$Timestamp,
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering")

lines(d$Sub_metering_2 ~ d$Timestamp,
      col="red")

lines(d$Sub_metering_3 ~ d$Timestamp,
      col="blue")

legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty=1, # use colored lines in the legend
       bty='n' # remove the legen border
    )

# bottom right, global reactive power timeseries
plot(d$Global_reactive_power ~ d$Timestamp,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()
