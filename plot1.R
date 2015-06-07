library(sqldf)

# If data is not in working directory, then download and unzip... 

if(!file.exists("household_power_consumption.txt")) {
      download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip")
      unzip("household_power_consumption.zip")
}

#Import dates of interest from the file...
power <- read.csv.sql("household_power_consumption.txt", sep=";", sql = "select * from file where Date IN ('1/2/2007','2/2/2007')") #2/1/2007
closeAllConnections()

# combine date and time variables...
power$DT <- paste(power$Date, power$Time)
power$DT <- strptime(power$DT, format="%d/%m/%Y %H:%M:%S")


#initiate png file for the graph and build the histogram...
png("plot1.png", width = 480, height =480)

hist(power$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")

dev.off()


print("Graph created, enjoy")