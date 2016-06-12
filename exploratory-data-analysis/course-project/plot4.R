library(ggplot2)

if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

# filter coal SCC
scc.coal <- grepl("coal", SCC$Short.Name, ignore.case = TRUE)
scc.coal.code <- SCC[scc.coal,1]

# filter value to keep only coal values.
pm.coal <- subset(NEI, SCC %in% scc.coal.code)

pm.coal.grouped <- aggregate(Emissions ~ year, pm.coal, FUN=sum)

g <- ggplot(pm.coal.grouped, aes(factor(year), Emissions, fill= factor(year))) 
g <- g + geom_bar(stat ="identity") 
g <- g + scale_fill_brewer(palette = "RdBu")
g <- g + labs(x = "Year")
g <- g + labs(y = "Emissions (tons)")
g <- g + labs(title = expression('PM'[2.5]*' emission for coal combustion related source (1999-2008)'))

png(filename = "plot4.png")
print(g)
dev.off()