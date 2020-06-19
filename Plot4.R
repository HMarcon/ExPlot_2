#Load data if not already loaded
if (!"neiData" %in% ls()) {
        neiData <- readRDS("./data/summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
        sccData <- readRDS("./data/Source_Classification_Code.rds")
}

subset_Baltimore <- neiData[neiData$fips == "24510" , ]

coal <- grep("coal", sccData$Short.Name, ignore.case = TRUE)
coal <- sccData[coal,]
coal <- neiData[neiData$SCC %in% coal$SCC ,]

coalEmissions <- aggregate(coal$Emissions, list(coal$year), FUN = "sum")

png(filename = "plot4.png", width = 480, height = 480, units = "px")

plot(coalEmissions, type = "l", xlab = "year",
     ylab = expression('Total PM'[2.5]*" Emission"),
     main = "Total emissions from Coal Combustion from 1999 to 2008")


dev.off()