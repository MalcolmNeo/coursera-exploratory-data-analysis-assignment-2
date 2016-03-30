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

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# 24510 is Baltimore, see plot2.R
# Searching for ON-ROAD type in NEI

subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

TotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)



png("C:/R/Exploratory_Data_Analysis/Assignment2/plot5.png")
g <- ggplot(TotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (Baltimore City, Maryland)')
print(g)
dev.off()