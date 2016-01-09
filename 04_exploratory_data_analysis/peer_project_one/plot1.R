load_data <- function() {
  setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\ExData_Plotting1')
  
  dat <- read.table('household_power_consumption.txt',
                    sep=";",
                    na.strings="?",
                    col.names=c("Date",
                                "Time",
                                "Global.Active.Power",
                                "Global.Reactive.Power",
                                "Voltage",
                                "Global.Intensity",
                                "Sub.metering.1",
                                "Sub.metering.2",
                                "Sub.metering.3"),
                    header=FALSE,
                    colClasses = c("Date"="character", "Time"="character"),
                    skip=66637,
                    nrows=2880)
  
  dat$datetime = strptime(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S")
  dat
}

do_hist <- function(dat) {
  hist(dat$Global.Active.Power,
       main="Global Active Power",
       xlab="Global Active Power (kilowatts)",
       col='red')
}

plot1 <- function() {
  dat <- load_data()
  png('plot1.png')
  do_hist(dat)
  dev.off()
}

plot1()