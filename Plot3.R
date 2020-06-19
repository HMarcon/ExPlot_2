#Load data if not already loaded
if (!"neiData" %in% ls()) {
        neiData <- readRDS("./data/summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
        sccData <- readRDS("./data/Source_Classification_Code.rds")
}

subset_Baltimore <- neiData[neiData$fips == "24510" , ]

library(ggplot2)

totalEmissions <- aggregate(subset_Baltimore$Emissions, list(subset_Baltimore$year), FUN = "sum")

png(filename = "plot3.png", width = 480, height = 480, units = "px")


g <- ggplot(subset_Baltimore, aes(year, Emissions, color = type))
g + geom_line(stat = "summary", fun = "sum") + 
        ylab(expression('PM'[2.5]*" Emission (ton)")) + 
        ggtitle("Total Emissions in the Baltimore City from 1999 to 2008")
dev.off()