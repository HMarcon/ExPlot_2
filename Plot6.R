#Load data if not already loaded
if (!"neiData" %in% ls()) {
        neiData <- readRDS("./data/summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
        sccData <- readRDS("./data/Source_Classification_Code.rds")
}

subset_Baltimore_LA <- neiData[neiData$fips == "24510"|neiData$fips == "06037", ]

motor <- grep("motor", sccData$Short.Name, ignore.case = TRUE)
motor <- sccData[motor,]
motor_Baltimore_LA <- subset_Baltimore_LA[subset_Baltimore_LA$SCC %in% motor$SCC ,]


library(ggplot2)
png(filename = "plot6.png", width = 480, height = 480, units = "px")
g <- ggplot(motor_Baltimore_LA, aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun = "sum") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle("Comparison of Total Emissions From Motor Vehicle Sources in 
                Baltimore City and Los Angeles County from 1999 to 2008") +
        scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))


dev.off()