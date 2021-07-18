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

# Create the plot
date <- paste(powerData$Date, powerData$Time)
time <- as.numeric(as.POSIXct(strptime(date, "%d/%m/%Y %H:%M:%S")))
with(powerData, plot(time, Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
axis(1, at = c(1170306000, 1170392370, 1170478740), labels = c("Thu", "Fri", "Sat"))
par(bg = NA)

# Export the plot as a PNG
dev.copy(png, file = "pics/plot2.png")
dev.off()

