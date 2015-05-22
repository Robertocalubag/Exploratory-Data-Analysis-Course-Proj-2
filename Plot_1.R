#Extract the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#Getting desired samples 
NEIsample <- NEI[sample(nrow(NEI), size = 1000, replace = F), ]

#aggregates
Emissions <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)
Emissions$PM <- round(Emissions[, 2] / 1000, 2)

#creating png file
png(filename = "plot1.png")
barplot(Emissions$PM, names.arg = Emissions$Group.1, main = expression('Total Emission of PM'[2.5]), xlab = 'Year', 
		ylab = expression(paste('PM', ''[2.5], ' in Kilotons')), col ="green")
dev.off()
		