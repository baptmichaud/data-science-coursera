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
png(filename = "plot2.png")

# Generate the plot
with(data, plot(DateTime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# Close PNG file
dev.off()