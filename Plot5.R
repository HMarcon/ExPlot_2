#Load data if not already loaded
if (!"neiData" %in% ls()) {
        neiData <- readRDS("./data/summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
        sccData <- readRDS("./data/Source_Classification_Code.rds")
}

subset_Baltimore <- neiData[neiData$fips == "24510" , ]

motor <- grep("motor", sccData$Short.Name, ignore.case = TRUE)
motor <- sccData[motor,]
motor <- subset_Baltimore[subset_Baltimore$SCC %in% motor$SCC ,]

motorEmissions <- aggregate(motor$Emissions, list(motor$year), FUN = "sum")

png(filename = "plot5.png", width = 480, height = 480, units = "px")

plot(motorEmissions, type = "l", xlab = "year",
     ylab = expression('Total PM'[2.5]*" Emission"),
     main = "Total emissions from Motor Vehicles Combustion from 1999 to 2008")


dev.off()