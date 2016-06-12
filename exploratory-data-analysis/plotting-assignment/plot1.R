# Load Data
unzip(zipfile = "exdata-data-household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE, na.strings = "?")

# Keep only interesting data
data <- subset(data, data$Date %in% c("1/2/2007", "2/2/2007"))

# Format columns
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Open PNG file
png(filename = "plot1.png")

# Generate the plot
hist(data$Global_active_power, col= "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close PNG file