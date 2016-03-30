## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate data
yearlyTotal<-aggregate(NEI$Emissions,by=list(Year=NEI$year),sum)

## Scale data
yearlyTotal$y <- round(yearlyTotal$x/1000,2)

## Output to png formate
png(filename='C:/R/Exploratory_Data_Analysis/Assignment2/plot1.png')

## Plot bar chart
barplot(yearlyTotal$y,
     xlab="Year",
     ylab=expression(paste('PM', ''[2.5], ' in Kilotons')),
     main=expression(paste('Total Emission of PM'[2.5])),
     names.arg = yearlyTotal$Year)
dev.off()