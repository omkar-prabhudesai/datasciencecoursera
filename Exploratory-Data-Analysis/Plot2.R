# 1. Read the table data between dates 2007-02-01 and 2007-02-02.
file <- "./power_consumption/household_power_consumption.txt"
mainTable <- read.table(file,header = TRUE, sep = ';', stringsAsFactors = FALSE, dec = '.')
subTable <- mainTable[mainTable$Date %in% c("1/2/2007","2/2/2007"),]

# 2. Plot lineplot as Global Active Powers vs Frequency
datetime <- strptime(paste(subTable$Date,subTable$Time, sep = ' '), '%d/%m/%Y %H:%M:%S')
gap <- as.numeric(subTable$Global_active_power)
png("Plot2.png",width = 480, height = 480)
plot(datetime,gap,
     xlab = "", 
     ylab = "Global Active Power(killowatts)",
     type = "l")
dev.off()