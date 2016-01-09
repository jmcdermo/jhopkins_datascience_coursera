setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\exploratory_data_analysis\\course_project_two')

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# grab only baltimore emissions
baltimore <- NEI[NEI$fips == "24510", ]

years <- unique(baltimore$year)
yearly_totals <- aggregate(baltimore$Emissions, list(baltimore$year), sum)

png('plot2.png')
barplot(yearly_totals$x,
        names.arg=yearly_totals$Group.1,
        xlab="Year",
        ylab="Total Emissions",
        col='darkcyan')
title('Yearly PM2.5 Emissions in Baltimore')
dev.off()