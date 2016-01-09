setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\exploratory_data_analysis\\course_project_two')

library(ggplot2)

## This first line will likely take a few seconds. Be patient!
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

# MOTOR VEHICLE:
# EPA report at http://www.epa.gov/ttn/chief/net/2008report.pdf Page 11
# defines Motor Vehicle sources as having "ON-ROAD" type.

filter_motor_vehicle <- function(data) {
  motor_vehicle_data <- data[data$type == 'ON-ROAD', ]
  motor_vehicle_data
}

filter_city <- function(data, fips, name) {
  # grab only baltimore emissions
  city <- subset(data[data$fips == fips, ], select=c('year', 'Emissions'))
  city$City <- name
  colnames(city) <- c('Year', 'Emissions', 'City')
  city$Year <- as.factor(city$Year)
  city$City <- as.factor(city$City)
  city
}

vehicles <- filter_motor_vehicle(NEI)

bmore_motor_vehicles <- filter_city(vehicles, '24510', 'Baltimore')
la_motor_vehicles <- filter_city(vehicles, '06037', 'LA')

# combine the two
combined_motor_vehicles <- rbind(bmore_motor_vehicles, la_motor_vehicles)

# aggregate (sum) by year
yearly_totals <- aggregate(combined_motor_vehicles$Emissions,
                           list(combined_motor_vehicles$Year, combined_motor_vehicles$City),
                           sum)
colnames(yearly_totals) <- c('Year', 'City', 'Emissions')

# plot a bar graph to show that they are decreasing
#png('plot6.png')
p <- ggplot(yearly_totals) + 
  aes(x=Year, y=Emissions) +
  facet_grid(. ~ City) +
  geom_bar(stat='identity') +
  ggtitle('Yearly PM2.5 Emissions from Motor Vehicles')
ggsave(p, file='plot6.png', width=8, height=8, dpi=100)
dev.off()
