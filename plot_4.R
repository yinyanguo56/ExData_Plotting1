
## create data folder
if(!file.exists("./data")){
  dir.create("data")
}

#download file if not exist
filename = "./data/household_power_consumption.zip"
if (!file.exists(filename)) {
## download url and destination file
file.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
file.dest <- './data/household_power_consumption.zip'
## download from the URL
download.file(file.url, file.dest)
}

#unzip and read file
power_consum <-  read.csv(unz(filename, "household_power_consumption.txt"), header=T,
                      sep=";", stringsAsFactors=F, na.strings="?",
                      colClasses=c("character", "character", "numeric",
                                   "numeric", "numeric", "numeric",
                                   "numeric", "numeric", "numeric"))

## Formatting the date and subseting the data only on 2007-02-01 and 2007-02-02
power_consum$Date = as.Date(power_consum$Date, format="%d/%m/%Y")
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")
power_consum = power_consum[power_consum$Date >= startDate & power_consum$Date <= endDate, ]

#put date and time together
power_consum$daytime <- as.POSIXct(paste(power_consum$Date, power_consum$Time), format="%Y-%m-%d %H:%M:%S")

## create result folder if not exist
if(!file.exists("./result")){
  dir.create("result")
}

png("./result/plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
par(mar=c(5,5,3,1))
plot(power_consum$daytime, power_consum$Global_active_power, type="l", xlab="", ylab="Global Active Power (in kilowatt)", cex=0.2)

plot(power_consum$daytime, power_consum$Voltage, type="l", xlab="datetime", ylab="Voltage (in volt)")

plot(power_consum$daytime, power_consum$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(power_consum$daytime, power_consum$Sub_metering_2, type="l", col="red")
lines(power_consum$daytime, power_consum$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  col=c("black", "red", "blue"),lty=NULL, lwd=2.5,bty="n")

plot(power_consum$daytime, power_consum$Global_reactive_power, type="l", xlab="datetime", ylab="Global reactive power(in kilowatt)")

dev.off()


