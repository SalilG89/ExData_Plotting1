##Code to produce Plot 4


##Code to download zip file and unzip
zipfile <- tempfile()
URL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, zipfile)
unzipped <- unzip(zipfile)
unlink(zipfile)

dfEPCAll <- read.table(unzipped, sep = ";", header = TRUE)
##Format Date and Subset for sequence of days we need
dfEPCAll$DateFormatted <- as.Date(dfEPCAll$Date, format = "%d/%m/%Y")

dfEPC <- dfEPCAll[(dfEPCAll$DateFormatted=="2007-02-01") | (dfEPCAll$DateFormatted=="2007-02-02"),]
dfEPC <- transform(dfEPC, timestamp=as.POSIXct(paste(DateFormatted, Time)), "%d/%m/%Y %H:%M:%S")
## Format Factor columns 2 numeric

colListFactor2Numeric <- c("Global_active_power", "Global_reactive_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" )

dfEPC[colListFactor2Numeric] <-
  lapply(dfEPC[colListFactor2Numeric], function(x) as.numeric(as.character(x)))


##PLOT 4
par(mfrow=c(2,2))
plot(dfEPC$timestamp,dfEPC$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(dfEPC$timestamp,dfEPC$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(dfEPC$timestamp,dfEPC$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(dfEPC$timestamp,dfEPC$Sub_metering_2,col="red")
lines(dfEPC$timestamp,dfEPC$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
plot(dfEPC$timestamp,dfEPC$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()

