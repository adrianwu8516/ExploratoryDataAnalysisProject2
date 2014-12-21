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
ans2 <- aggregate(Emissions ~ year, NET_24510, sum)

png('plot2.png')
barplot(height=ans2$Emissions, 
		names.arg=ans2$year,
		col = "skyblue", 
		xlab="years", 
		ylab=expression('total PM'[2.5]*' emission'), 
		main=expression('Total PM'[2.5]*' emissions in Baltimore City, Maryland'))
dev.off()