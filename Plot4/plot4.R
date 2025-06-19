# Producing Plot 4
library(dplyr)
data <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", sep = ";", header = TRUE,)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Date <- as.Date(data$Date, format = "%Y-%m-%d")
names(data) <- gsub("_"," ", names(data))
final_data <- data %>% filter(Date == "2007-02-01"| Date == "2007-02-02")
final_data$`Global active power` <- as.numeric(final_data$`Global active power`)
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
final_data$DateTime <- as.POSIXct(paste(final_data$Date, final_data$Time), format = "%Y-%m-%d %H:%M:%S")
days_to_show <- as.POSIXct(seq(as.Date("2007-02-01"), as.Date("2007-02-03"), by = "day"))
xlabel <- format(days_to_show, "%a")

plot(final_data$DateTime, final_data$`Global active power`, type = "l", xaxt = "n", xlim =  range(days_to_show), ylab = "Global Active Power", xlab = "")
axis(1, at = days_to_show, labels = xlabel)

plot(final_data$DateTime, final_data$Voltage, type = "l", lwd = 1, col = "black", xaxt="n",xlim =  range(days_to_show), xlab = "datetime", ylab = "Voltage")
axis(1, at = days_to_show, labels = xlabel)

plot(final_data$DateTime,final_data$`Sub metering 1`, col = "black", type = "l", lwd = 1, xaxt = "n", xlim = range(days_to_show), ylab = "Energy sub metering", xlab = "")
lines(final_data$DateTime, final_data$`Sub metering 2`, col = "red", lwd = 1)
lines(final_data$DateTime, final_data$`Sub metering 3`, col = "blue", lwd = 1)
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 1)
axis(1, at = days_to_show, labels = xlabel)

plot(final_data$DateTime, final_data$`Global reactive power`, type = "l", lwd = 1, col = "black", xaxt="n",xlim =  range(days_to_show), xlab = "datetime", ylab = "Global_reactive_power")
axis(1, at = days_to_show, labels = xlabel)

dev.off()
