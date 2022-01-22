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



## Plot Histogram of Global active power consumption

par(mfrow = c(1,1), mar = c(5,4.5,4,2))
hist(housepc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

png("plot1.png", width = 480, height = 480)
par(mfrow = c(1,1),mar = c(5,4.5,4,2))
hist(housepc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

## Done

