#Load data if not already loaded
if (!"neiData" %in% ls()) {
        neiData <- readRDS("./data/summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
        sccData <- readRDS("./data/Source_Classification_Code.rds")
}

totalEmissions <- aggregate(neiData$Emissions, list(neiData$year), FUN = "sum")

png(filename = "plot1.png", width = 480, height = 480, units = "px")

plot(totalEmissions, type = "l", 
     xlab = "Year", 
     main = "Total Emissions of Particulate Matter in the US from 1999 to 2008", 
     ylab = expression('PM'[2.5]*" Emission (ton)"))
dev.off()