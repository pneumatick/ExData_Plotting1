# Download data if necessary, prepare it for plotting
if (!file.exists("data/household_power_consumption.txt")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "data/household_power_consumption.zip")
  unzip("data/household_power_consumption.zip", exdir = "data/")
}

powerData <- read.csv("data/household_power_consumption.txt", sep = ";")
powerData <- powerData[powerData$Date == "1/2/2007" |  powerData$Date == "2/2/2007", ]
powerData$Sub_metering_1 <- as.numeric(powerData$Sub_metering_1)
powerData$Sub_metering_2 <- as.numeric(powerData$Sub_metering_2)

# Create the plot
date <- paste(powerData$Date, powerData$Time)
time <- as.numeric(as.POSIXct(strptime(date, "%d/%m/%Y %H:%M:%S")))
with(powerData, plot(time, Sub_metering_1, type = "l", xaxt = "n", xlab = "", ylab = "Energy sub metering"))
with(powerData, points(time, Sub_metering_2, type = "l", col = "red"))
with(powerData, points(time, Sub_metering_3, type = "l", col = "blue"))
axis(1, at = c(1170306000, 1170392370, 1170478740), labels = c("Thu", "Fri", "Sat"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
par(bg = NA)

# Export the plot as a PNG
dev.copy(png, file = "pics/plot3.png")
dev.off()
