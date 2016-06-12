library(ggplot2)

if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}


# filter coal SCC
scc.motor <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
scc.motor.code <- SCC[scc.motor,1]

# filter value to keep only motor vehicles values.
pm.motor <- subset(NEI, SCC %in% scc.motor.code & fips %in% c("24510","06037"))
pm.motor$city <- ifelse(pm.motor$fips == "24510", "Baltimore City", "Los Angeles City")

pm.motor.grouped <- aggregate(Emissions ~ year + city, pm.motor, FUN=sum)

g <- ggplot(pm.motor.grouped, aes(factor(year), Emissions, fill= factor(year))) 
g <- g + geom_bar(stat ="identity") 
g <- g + facet_grid(. ~ city)
g <- g + scale_fill_brewer(palette = "RdBu") + guides(fill=FALSE)
g <- g + labs(x = "Year")
g <- g + labs(y = "Emissions (tons)")
g <- g + labs(title = expression('PM'[2.5]*' emission for motor vehicle in Baltimore vs LA (1999-2008)'))

png(filename = "plot6.png")
print(g)
dev.off()