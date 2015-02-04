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
png(filename = "plot3.png", width = 480, height = 480, units = "px")
par(mar = c(3, 4, 1, 1))
with(power, plot(Datetime, Sub_metering_1,
                 type = "l", 
                 ylab = "Energy sub metering",
                 xlab = ""))
with(power, lines(Datetime, Sub_metering_2,
                 col = "red"))
with(power, lines(Datetime, Sub_metering_3,
                  col = "blue"))
legend("topright", lwd = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

