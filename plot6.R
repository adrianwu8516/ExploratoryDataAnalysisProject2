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

NEI_obj <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]
ans6 <- aggregate(Emissions ~ year + fips, NEI_obj, sum)
ans6$fips[ans6$fips=="24510"] <- "Baltimore"
ans6$fips[ans6$fips=="06037"] <- "Los Angeles"

library(ggplot2)

png('plot6.png', width=800, height=500)

plot <- ggplot(data=ans6, aes(x=year, y=Emissions)) + 
		facet_grid(. ~ fips) + 
		geom_bar(stat="identity", fill = "Skyblue") +
		ggtitle('Total Emissions from motor vehicle in Baltimore City & LA') + 
    	ylab(expression('Total PM'[2.5]*" Emissions")) + 
    	xlab('Year') 
print(plot)
dev.off()