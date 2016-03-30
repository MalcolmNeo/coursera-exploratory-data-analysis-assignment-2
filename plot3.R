## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

library(ggplot2)
## Aggregate data
subsetNEI  <- NEI[NEI$fips=="24510", ]
yearlyTotal<-aggregate(subsetNEI$Emissions,by=list(Type=subsetNEI$type,Year=subsetNEI$year),sum)

## Output to png 
png(filename='C:/R/Exploratory_Data_Analysis/Assignment2/plot3.png')

## Plot graph
g <- ggplot(yearlyTotal, aes(Year, x, color = Type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland')
print(g)

dev.off()