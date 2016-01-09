setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\exploratory_data_analysis\\course_project_two')

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# grab the list of years
years <- unique(NEI$year)
# aggregate (sum) by year
yearly_totals <- aggregate(NEI$Emissions, list(NEI$year), sum)

# plot a bar graph to show that they are decreasing
png('plot1.png')
barplot(yearly_totals$x / 1000,
        names.arg=yearly_totals$Group.1,
        xlab="Year",
        ylab="Total Emissions (k)",
        col='darkcyan')
title('Yearly PM2.5 Emissions in USA')
dev.off()