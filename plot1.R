# Download data if necessary, prepare it for plotting
if (!file.exists("data/household_power_consumption.txt")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "data/household_power_consumption.zip")
  unzip("data/household_power_consumption.zip", exdir = "data/")
}

powerData <- read.csv("data/household_power_consumption.txt", sep = ";")
powerData <- powerData[powerData$Date == "1/2/2007" |  powerData$Date == "2/2/2007", ]
powerData$Global_active_power <- as.numeric(powerData$Global_active_power)

# Create plot (histogram)
hist(powerData$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# Export the plot as a PNG file
dev.copy(png, file = "pics/plot1.png")
dev.off()