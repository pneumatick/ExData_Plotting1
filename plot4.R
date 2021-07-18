# Download data if necessary, prepare it for plotting
if (!file.exists("data/household_power_consumption.txt")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "data/household_power_consumption.zip")
  unzip("data/household_power_consumption.zip", exdir = "data/")
}

powerData <- read.csv("data/household_power_consumption.txt", sep = ";")
powerData <- powerData[powerData$Date == "1/2/2007" |  powerData$Date == "2/2/2007", ]
powerData <- powerData[powerData$Global_active_power != "?", ]
powerData$Global_active_power <- as.numeric(powerData$Global_active_power)
powerData$Sub_metering_1 <- as.numeric(powerData$Sub_metering_1)
powerData$Sub_metering_2 <- as.numeric(powerData$Sub_metering_2)
powerData$Voltage <- as.numeric(powerData$Voltage)
powerData$Global_reactive_power <- as.numeric(powerData$Global_reactive_power)

# Create the plots
date <- paste(powerData$Date, powerData$Time)
time <- as.numeric(as.POSIXct(strptime(date, "%d/%m/%Y %H:%M:%S")))
par(mfrow = c(2,2), mar = c(5, 4, 3, 2), oma = c(0, 0, 0, 0), bg = NA)
with(powerData, {
  plot(time, Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power")
  axis(1, at = c(1170306000, 1170392370, 1170478740), labels = c("Thu", "Fri", "Sat"))
  plot(time, Voltage, type = "l", xaxt = "n", xlab = "datetime", ylab = "Voltage")
  axis(1, at = c(1170306000, 1170392370, 1170478740), labels = c("Thu", "Fri", "Sat"))
  plot(time, Sub_metering_1, type = "l", xaxt = "n", xlab = "", ylab = "Energy sub metering")
  points(time, Sub_metering_2, type = "l", col = "red")
  points(time, Sub_metering_3, type = "l", col = "blue")
  axis(1, at = c(1170306000, 1170392370, 1170478740), labels = c("Thu", "Fri", "Sat"))
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), y.intersp = 0.25, bty = "n")
  plot(time, Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime")
  axis(1, at = c(1170306000, 1170392370, 1170478740), labels = c("Thu", "Fri", "Sat"))
  })

# Export the plot as a PNG
dev.copy(png, file = "pics/plot4.png")
dev.off()