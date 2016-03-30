## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

# 24510 is Baltimore, 06037 is LA CA
# Searching for ON-ROAD type in NEI
subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

TotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
TotalByYearAndFips$fips[TotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
TotalByYearAndFips$fips[TotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("C:/R/Exploratory_Data_Analysis/Assignment2/plot6.png", width=1040, height=480)
g <- ggplot(TotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (Baltimore City, MD vs Los Angeles, CA)')
print(g)
dev.off()