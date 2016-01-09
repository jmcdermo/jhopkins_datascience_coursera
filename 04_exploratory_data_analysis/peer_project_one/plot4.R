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

do_gap <- function(dat) {
  plot(dat$datetime, dat$Global.Active.Power,
       type='l',
       xlab='',
       ylab='Global Active Power')
}

do_subm <- function(dat) {
  plot(dat$datetime, dat$Sub.metering.1,
       type='l',
       xlab='',
       ylab='Energy sub metering')
  lines(x=dat$datetime, y=dat$Sub.metering.2, col='red')
  lines(x=dat$datetime, y=dat$Sub.metering.3, col='blue')
  legend('topright',
         legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
         lty=c(1,1,1), 
         lwd=c(2.5,2.5),col=c('black', 'red', 'blue'))
}

do_volt <- function(dat) {
  plot(dat$datetime, dat$Voltage,
       type='l',
       xlab='datetime',
       ylab='Voltage')
}

do_grp <- function(dat) {
  plot(dat$datetime, dat$Global.Reactive.Power,
       type='l',
       xlab='datetime',
       ylab='Global_reactive_power')
}

plot_result <- function() {
  dat <- load_data()
  png('plot4.png')

  par(mfrow=c(2,2))
  do_gap(dat)
  do_volt(dat)
  do_subm(dat)
  do_grp(dat)
  
  dev.off()
}

plot_result()