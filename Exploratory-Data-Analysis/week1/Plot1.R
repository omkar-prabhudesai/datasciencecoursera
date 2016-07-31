# 1. Read the table data between dates 2007-02-01 and 2007-02-02.
file <- "./power_consumption/household_power_consumption.txt"
mainTable <- read.table(file,header = TRUE, sep = ';', stringsAsFactors = FALSE, dec = '.')
subTable <- mainTable[mainTable$Date %in% c("1/2/2007","2/2/2007"),]

# 2. Plot histogram as Global Active Powers vs Frequency
gap <- as.numeric(subTable$Global_active_power)
png("Plot1.png",width = 480, height = 480)
hist(gap, col = 'red', 
     main = 'Global Active Power' , 
     xlab = "Global Active Power (kilowatts)")
dev.off()