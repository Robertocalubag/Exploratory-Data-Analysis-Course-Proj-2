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

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# fetch all NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)

## Creating .png file
png("plot4.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity", fill="#66FF66") +
	xlab("year") +
	ylab(expression('Total PM'[2.5]*" Emissions")) +
	ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()