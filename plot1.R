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
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

# Plot
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "Red")

# Save file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
