library(ggplot2)

## This file is for loading the large dataset.
## Create directory "data" if not exists
if (!file.exists("data")) {
  dir.create("data")
}
## Download&unzip dataset if no exists
if (!file.exists("data/summarySCC_PM25.rds") || !file.exists("data/Source_Classification_Code.rds")) {
  if(!file.exists("data/exdata_data_NEI_data.zip")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL, destfile = "data/exdata_data_NEI_data.zip")
  }
  unzip(zipfile = "data/exdata_data_NEI_data.zip", exdir = "data")
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")

png(filename = "plot3.png", width = 480, height = 480, units = "px")

NEI <- NEI[NEI$fips=="24510", ]

totalEmissions <- aggregate(NEI$Emissions, by=list(year = NEI$year, sources = NEI$type), FUN=sum)

g <- ggplot(totalEmissions, aes( year, x , color = sources))
g + geom_line() +
    labs( title = expression("Total "* PM[2.5]* " emissions in Baltimore from 1999 to 2008")) +
    labs( y = expression(PM[2.5]*" Emissions (tons)")) +
    labs( x = "Year")

dev.off()