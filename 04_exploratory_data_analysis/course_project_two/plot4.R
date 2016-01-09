setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\exploratory_data_analysis\\course_project_two')

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# after examing the SCC data in Excel and some wikipedia reading about coal
# going with the following assumptions for coal combustion
# -- SCC.Level.Three must be in the following:
#      - Bituminous/Subbituminous Coal
#      - Bituminous Coal
#      - Lignite
#      - Lignite Coal
#      - Gasified Coal
#      - Coke
level_three <- c('Bituminous/Subbituminous Coal',
                 'Bituminous Coal',
                 'Lignite',
                 'Lignite Coal',
                 'Gasified Coal',
                 'Coke')

# get US data that matches these SCC codes
SCC_coal_codes <- as.character(SCC[SCC$SCC.Level.Three %in% level_three, ]$SCC)
baltimore_cars <- NEI[NEI$SCC %in% SCC_coal_codes, ]

# get US data that matches these SCC codes
us_coal <- NEI[NEI$SCC == SCC_codes, ]

# grab the list of years
years <- unique(us_coal$year)
# aggregate (sum) by year
yearly_totals <- aggregate(us_coal$Emissions, list(us_coal$year), sum)

# plot a bar graph to show that they are decreasing
png('plot4.png')
barplot(yearly_totals$x / 1000,
        names.arg=yearly_totals$Group.1,
        xlab="Year",
        ylab="Total Emissions (k)",
        col='thistle1')
title('Yearly PM2.5 Emissions in USA Caused by Coal')
dev.off()