
## create data folder
if(!file.exists("./data")){
  dir.create("data")
}

#download file 
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

## create result folder
if(!file.exists("./result")){
  dir.create("result")
}
png("./result/plot1.png", width=480, height=480)
hist(power_consum$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

