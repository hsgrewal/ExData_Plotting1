## Download dataset
filename <- "dataset.zip"

# Check if dataset already download, If not, download it
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}

text_file <- "household_power_consumption.txt"
# Check if dataset unzipped, If not, unzip it
if (!file.exists(text_file)){
  unzip(filename)
}

## Read dataset
data <- read.table(text_file, header = T, sep = ";", na.strings = "?")
# Convert Date column format to date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset the data for date 2007-02-01 and 2007-02-02
data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# Convert Date and Time variables to Date/Time class in R
data$DateTime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
data$DateTime <- as.POSIXct(data$DateTime)

# Plot
with(data, plot(Sub_metering_1 ~ DateTime, type="l", xlab = "",
       ylab = "Energy sub metering"))
with(data, lines(Sub_metering_2 ~ DateTime, col = "red"))
with(data, lines(Sub_metering_3 ~ DateTime, col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save file
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
