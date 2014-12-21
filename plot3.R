# Basic Settings 
#url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
#download.file(url, 'PA2.zip', method ='curl')
#unzip('PA2.zip')
#setwd('./PA2')

# Importing Data (This first line will likely take a few seconds)
if(!exists("NEI")){
	NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
	SCC <- readRDS("Source_Classification_Code.rds")
}
NET_24510  <- NEI[NEI$fips=="24510", ]
ans3 <- aggregate(Emissions ~ year + type, NET_24510, sum)

library(ggplot2)

png("plot3.png", width=500, height=500)

plot <- ggplot(ans3, aes(year, Emissions, colour = type)) + 
		geom_smooth(alpha=1, size=1, method="loess") + 
		xlab("year") + 
		ylab(expression('Total PM'[2.5]*" Emissions")) +
		ggtitle('Total Emissions in Baltimore City, Maryland')

print(plot)
dev.off()