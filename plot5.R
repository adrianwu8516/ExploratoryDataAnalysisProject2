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

NET_24510_ONROAD <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
ans5 <- aggregate(Emissions ~ year, NET_24510_ONROAD, sum)


library(ggplot2)

png('plot5.png', width=500, height=500)

plot <- ggplot(data=ans5, aes(x=year, y=Emissions)) + 
		geom_bar(stat="identity", fill = "Skyblue") +
		ggtitle('Total Emissions form Motor Vehicle in Baltimore City, Maryland') + 
    	ylab(expression('Total PM'[2.5]*" Emissions")) + 
    	xlab('Year') 
print(plot)
dev.off()