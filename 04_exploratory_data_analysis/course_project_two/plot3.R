setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\exploratory_data_analysis\\course_project_two')

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load ggplot + reshape2
library(ggplot2)
library(reshape2)

# grab only baltimore emissions
baltimore <- subset(NEI[NEI$fips == "24510", ], select=c('year', 'type', 'Emissions'))
melted <- melt(baltimore, c('year', 'type'))
tidy <- dcast(melted, ... ~ variable, fun.aggregate = sum)
colnames(tidy) <- c('Year', 'Type', 'Emissions')
tidy$Type <- as.factor(tidy$Type)
tidy$Year <- as.factor(tidy$Year)

p <- ggplot(tidy ) + 
  aes(x=Year, y=Emissions) +
  facet_grid(. ~ Type) +
  geom_bar(stat='identity') +
  ggtitle('Yearly PM2.5 Emissions in Baltimore by Type')
ggsave(p, file='plot3.png', width=8, height=8, dpi=100)
dev.off()
