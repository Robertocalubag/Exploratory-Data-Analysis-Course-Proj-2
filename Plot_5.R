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



# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)


## Creating .png file
png("plot5.png", width=840, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity", fill="#66FF66") +
	xlab("year") +
	ylab(expression('Total PM'[2.5]*" Emissions")) +
	ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()