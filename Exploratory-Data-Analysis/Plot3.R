# 1. Read the table data between dates 2007-02-01 and 2007-02-02.
file <- "./power_consumption/household_power_consumption.txt"
mainTable <- read.table(file,header = TRUE, sep = ';', stringsAsFactors = FALSE, dec = '.')
subTable <- mainTable[mainTable$Date %in% c("1/2/2007","2/2/2007"),]

# 2. Plot lineplot
datetime <- strptime(paste(subTable$Date,subTable$Time, sep = ' '), '%d/%m/%Y %H:%M:%S')
sub_m1 <- as.numeric(subTable$Sub_metering_1)
sub_m2 <- as.numeric(subTable$Sub_metering_2)
sub_m3 <- as.numeric(subTable$Sub_metering_3)
png("Plot3.png",width = 480, height = 480)
plot(datetime,sub_m1,
     xlab = "", 
     ylab = "Energy Sub metering",
     type = "l",col = 'black')
lines(datetime,sub_m2,col='red', type = 'l')
lines(datetime,sub_m3,col='blue', type = 'l')
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()