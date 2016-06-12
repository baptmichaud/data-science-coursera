library(ggplot2)

if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions
# from 1999-2008 for Baltimore City? Which have seen increases 
# in emissions from 1999-2008? Use the ggplot2 plotting system 
# to make a plot answer this question.

pm.baltimore <- subset(NEI, fips == "24510")
pm.baltimore.grouped <- aggregate(Emissions ~ year + type, pm.baltimore, FUN=sum)

g <- ggplot(pm.baltimore.grouped, aes(year, Emissions))

g <- g + geom_line(aes(color = type)) 
g <- g + ggtitle(expression('PM'[2.5]*' emission by year for the Baltimore City by Type')) 
g <- g + ylab("Emissions (tons)")

png(filename = "plot3.png")
print(g)
dev.off()