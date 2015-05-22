## Extraction the file

if(!exists("NEI")){
	NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
	SCC <- readRDS("./data/Source_Classification_Code.rds")
}

## combining the 2 data sets
if(!exists("NEISCC")){
	NEISCC <- merge(NEI, SCC, by="SCC")
}

## required ggplot2, make sure that this was downloaded before running the skript
library(ggplot2)



# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]
aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
##aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
##aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"



## Creating .png file
png("plot6.png", width=1040, height=480)
g <- ggplot(aggregatedTotalByYear, aes(year, Emissions, color = type))
##g <- g + facet_grid(. ~ fips)
##g <- g + geom_bar(stat="identity", fill="#66FF66") +
g <- g + geom_line() +
	xlab("year") +
	ylab(expression('Total PM'[2.5]*" Emissions")) +
	ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, 
			MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()