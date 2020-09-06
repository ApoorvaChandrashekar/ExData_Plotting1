library(lubridate)

#Download the file and unzip it
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "HouseholdPowerConsumption.zip", method = "curl")

unzip("HouseholdPowerConsumption.zip")

#Read in the data
powerconsumptiondata <- read.table("household_power_consumption.txt",
                                   na.strings = "?", sep = ";", header = TRUE)

#Convert the Date column to Date format
powerconsumptiondata$Date <- dmy(powerconsumptiondata$Date)

#Subset the data to only include the first two days of Feb in 2007
powerconsumptiondata <- subset(powerconsumptiondata, 
                               Date == "2007-02-01" | Date == "2007-02-02")

#Combine the date and time columns to create a column DateTime
powerconsumptiondata$datetime <- as.POSIXct(paste(powerconsumptiondata$Date, 
                                                  powerconsumptiondata$Time), 
                                            format = "%Y-%m-%d %H:%M:%S")

par(mfcol = c(2,2))

#Create the plot for Global_active_power vs DateTime 
with(powerconsumptiondata, plot(datetime, Global_active_power, type="n", 
                                xlab = "", 
                                ylab = "Global Active Power"))
points(powerconsumptiondata$datetime, powerconsumptiondata$Global_active_power, 
       type = "l")

#Create the plot for Energy sub metering vs DateTime 
#Create the basic plot layout
with(powerconsumptiondata, plot(datetime, Sub_metering_1, type="n", 
                                xlab = "", 
                                ylab = "Energy sub metering"))
#Add the Sub_metering_1 graph
points(powerconsumptiondata$datetime, powerconsumptiondata$Sub_metering_1, 
       type = "l")
#Add the Sub_metering_2 graph
points(powerconsumptiondata$datetime, powerconsumptiondata$Sub_metering_2, 
       type = "l", col = "red")
#Add the Sub_metering_3 graph
points(powerconsumptiondata$datetime, powerconsumptiondata$Sub_metering_3, 
       type = "l", col = "blue")
#Add the legend
legend("topright", lty=c(1,1,1), col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       xjust = 1, yjust = 1, y.intersp = 0.55, x.intersp = 0.4, 
       text.width = strwidth("Sub_metering_1")/1.5, bty = "n")

#Create the plot for Voltage vs DateTime 
with(powerconsumptiondata, plot(datetime, Voltage, type="n"))
points(powerconsumptiondata$datetime, powerconsumptiondata$Voltage, 
       type = "l")

#Create the plot for Global_reactive_power vs DateTime 
with(powerconsumptiondata, plot(datetime, Global_reactive_power, type="n"))
points(powerconsumptiondata$datetime, 
       powerconsumptiondata$Global_reactive_power, 
       type = "l")

#Write the plot to png file
dev.copy(png, "plot4.png")
dev.off()


