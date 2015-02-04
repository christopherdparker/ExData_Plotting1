# Packages need
require(dplyr)
require(lubridate)

# Read in data
power = read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", as.is = TRUE)

# Convert dates and times
power$Datetime = strptime(paste(power$Date, power$Time), format = "%d/%m/%Y %H:%M:%S")

# Filter data - only Feb 1 & 2, 2007
power = power[year(power$Datetime) == 2007,]
power = power[month(power$Datetime) == 2,]
power = power[day(power$Datetime) == 2 | day(power$Datetime) == 1,]

# Clear out original date and time variables - OCD
power = power[,!(names(power) %in% c("Date","Time"))]

# Create plot
png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(power, plot(Datetime, Global_active_power,
                 type = "l", 
                 ylab = "Global Active Power (kilowatts)",
                 xlab = ""))
dev.off()




