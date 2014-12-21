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

merge <- merge(x=NEI, y=SCC, by='SCC')
merge_coal <- merge[grepl("coal", merge$Short.Name, ignore.case=TRUE), ]
ans4 <- aggregate(Emissions ~ year, merge_coal, sum)


library(ggplot2)

png('plot4.png', width=500, height=500)
plot <- ggplot(ans4, aes(x=year, y=Emissions)) +
    	geom_point(alpha=.3) +
    	geom_histogram(stat="identity", fill = "skyblue") + 
    	ggtitle("Total Emissions from coal sources in the US") +
    	xlab("year") +
		ylab(expression('Total PM'[2.5]*" Emissions"))
print(plot)
dev.off()