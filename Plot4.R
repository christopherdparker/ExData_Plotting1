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
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2), mar = c(4,4,1,1))
with (power, {
    # Top left
    plot(Datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
    
    # Top Right
    plot(Datetime, Voltage, type = "l")
    
    # Bottom Left
    with(power, plot(Datetime, Sub_metering_1,
                     type = "l", 
                     ylab = "Energy sub metering",
                     xlab = ""))
    with(power, lines(Datetime, Sub_metering_2,
                      col = "red"))
    with(power, lines(Datetime, Sub_metering_3,
                      col = "blue"))
    legend("topright", lwd = 1, col = c("black", "red", "blue"),
           legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           box.lwd = 0)
    
    # Bottom Right
    plot(Datetime, Global_reactive_power, type = "l")
})
dev.off()
