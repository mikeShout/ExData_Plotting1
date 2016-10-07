# install.packages("sqldf")

library(sqldf)

setwd("C:/Users/Mike/Documents/Projects/ExData_Plotting1")

# If data is not in working directory, then download and unzip... 

if(!file.exists("household_power_consumption.txt")) {
      download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip")
      unzip("household_power_consumption.zip")
}

#Import data from file where the dates are  2007-02-01 and 2007-02-02. This will be more efficient than importing all data and filtering later... 

power <- read.csv.sql("household_power_consumption.txt", sep=";", sql = "select * from file where Date IN ('1/2/2007','2/2/2007')") #2/1/2007
closeAllConnections()

# combine date and time variables...
power$DT <- paste(power$Date, power$Time)
power$DT <- strptime(power$DT, format="%d/%m/%Y %H:%M:%S")


#initiate png file for the graph and build the line graph...
png("plot2.png", width = 480, height =480)

plot(power$DT, power$Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)")

dev.off()


print("Graph created, enjoy")