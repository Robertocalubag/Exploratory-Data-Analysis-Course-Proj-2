#Extract the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#Getting desired samples 
NEIsample <- NEI[sample(nrow(NEI), size = 5000, replace = F), ]

#subset test data
MD <- subset(NEI, fips == '24510')

#creating png file
png(filename = "plot2.png")
barplot(tapply(X = MD$Emissions, INDEX = MD$year, FUN = sum), 
		main = 'Total Emission in Baltimore City, MD', 
		xlab = 'Year', ylab = expression('PM'[2.5]), col='green')
dev.off()
		