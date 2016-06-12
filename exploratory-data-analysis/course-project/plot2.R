if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

png(filename = "plot2.png")

# Sum by year filtered for Baltimore
pm.baltimore <- with(subset(NEI, fips == "24510"), tapply(Emissions, year, sum))

# Create the barplot with basic system
barplot(pm.baltimore, main = expression('PM'[2.5]*' emission by year for the Baltimore City'), xlab="Year", ylab="Emissions (tons)")

# Close the PNG file
dev.off()