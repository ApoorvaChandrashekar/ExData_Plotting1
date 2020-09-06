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
powerconsumptiondata$DateTime <- as.POSIXct(paste(powerconsumptiondata$Date, 
                                                  powerconsumptiondata$Time), 
                                            format = "%Y-%m-%d %H:%M:%S")

#Create the plot
with(powerconsumptiondata, plot(DateTime, Global_active_power, type="n", 
                                xlab = "", 
                                ylab = "Global Active Power (kilowatts)"))
points(powerconsumptiondata$DateTime, powerconsumptiondata$Global_active_power, 
       type = "l")

#Write the plot to png file
dev.copy(png, "plot2.png")
dev.off()


