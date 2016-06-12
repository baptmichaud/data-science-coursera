if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Have total emissions from PM2.5 decreased in the United States
# from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

png(filename = "plot1.png")

# Sum by year
pm.year <- with(NEI, tapply(Emissions, year, sum))

# Create the barplot with basic system
barplot(pm.year, main = expression('PM'[2.5]*' emission by year in the USA'), xlab="Year", ylab="Emissions (tons)")

# Close the PNG file
dev.off()