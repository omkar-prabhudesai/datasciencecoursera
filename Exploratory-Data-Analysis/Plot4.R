# 1. Read the table data between dates 2007-02-01 and 2007-02-02.
file <- "./power_consumption/household_power_consumption.txt"
mainTable <- read.table(file,header = TRUE, sep = ';', stringsAsFactors = FALSE, dec = '.')
subTable <- mainTable[mainTable$Date %in% c("1/2/2007","2/2/2007"),]

#2. Plot the 4 graphs
datetime <- strptime(paste(subTable$Date, subTable$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
gap <- as.numeric(subTable$Global_active_power)
grp <- as.numeric(subTable$Global_reactive_power)
volt <- as.numeric(subTable$Voltage)
sub_m1 <- as.numeric(subTable$Sub_metering_1)
sub_m2 <- as.numeric(subTable$Sub_metering_2)
sub_m3 <- as.numeric(subTable$Sub_metering_3)
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, gap, type="l", xlab="", ylab="Global Active Power")

plot(datetime, volt, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, sub_m1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, sub_m2, type="l", col="red")
lines(datetime, sub_m3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=, lwd=2.5, col=c("black", "red", "blue"))

plot(datetime, grp, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()