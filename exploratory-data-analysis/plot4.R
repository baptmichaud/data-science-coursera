# Set language to English (if not set, date appear in french)
Sys.setlocale(category = "LC_ALL", locale = "english")

# Load Data
#unzip(zipfile = "exdata-data-household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE, na.strings = "?")

# Keep only interesting data
data <- subset(data, data$Date %in% c("1/2/2007", "2/2/2007"))

# Format columns
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Open PNG file
png(filename = "plot4.png")


# Generate plots

par(mfrow = c(2,2))

# Plot 1
with(data, plot(DateTime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# Plot 2
with(data, plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type="l"))

# Plot 3
with(data, plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering"))
points(data$DateTime, data$Sub_metering_1, type = "l", col = "black")
points(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
points(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), legend =  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = "solid")

# Plot 4
with(data, plot(DateTime, Global_reactive_power, xlab = "datetime", type="l"))

# Close PNG file
dev.off()