## Retrieve and unzip dataset

fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile=paste0(getwd(),"/Power_consumption.zip"),method = "curl")
unzip("Power_consumption.zip")

## Read dataset first 5 rows

first_read <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 5)

View(first_read)

## Read dataset into table

housepc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", skip = 66630, 
                      nrows = 2900, col.names = names(first_read), na.strings = c("?"),
                      colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))


## Convert times

housepc$Date<-as.Date(housepc$Date, format = "%d/%m/%Y")
housepc$Time<-strptime(paste(housepc$Date,housepc$Time),"%F %T")

## Pull only needed dataset into new table of dates 2007-02-01 and 2007-02-02

housepc <- subset(housepc, housepc$Date %in% as.Date(c("2007-02-01","2007-02-02")))



## Plot Combination of 4 plots: global active power, energy sub metering, voltage over time, global reactive power over time

par(mfcol = c(2,2), mar = c(4.5,5,2,2))


plot(housepc$Time, housepc$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", pch = ".", type = "l")


plot(housepc$Time, housepc$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l", col = "black")
points(housepc$Time, housepc$Sub_metering_2, col = "red", type = "l")
points(housepc$Time, housepc$Sub_metering_3, col = "blue", type = "l")
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = names(housepc[,7:9]), bty = "n")


plot(housepc$Time, housepc$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")


plot(housepc$Time, housepc$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type="l")


png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2), mar = c(4.5,5,2,2))

plot(housepc$Time, housepc$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", pch = ".", type = "l")

plot(housepc$Time, housepc$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l", col = "black")
points(housepc$Time, housepc$Sub_metering_2, col = "red", type = "l")
points(housepc$Time, housepc$Sub_metering_3, col = "blue", type = "l")
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = names(housepc[,7:9]), bty = "n")

plot(housepc$Time, housepc$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")

plot(housepc$Time, housepc$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type="l")

dev.off()

## Done