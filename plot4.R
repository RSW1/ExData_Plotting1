## Reading the txt file and convert date and time
data <- read.table("household_power_consumption.txt", header = TRUE, quote = "\"", nrows = 2075259, sep = ";", dec = ".", comment.char="", na.strings="?", colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
data[["dat"]] <- as.POSIXlt(strptime(paste(data[,1], data[,2], sep = " "), "%d/%m/%Y %X"))

## Subsetting the data, only using data from 2007-02-01 and 2007-02-02
data_red <- subset(data,(format(data$dat,"%Y") == "2007") & (format(data$dat,"%m") == "02") & ((format(data$dat,"%d") == "01") | (format(data$dat,"%d") == "02")))

weekday <- seq(0,2880,1440)
weekday_name <- c("Thu","Fri","Sat")
line_col = c("black","red","blue")

## plot 2x2 graphs into a png file
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
with(data_red, {
  plot(Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")
  axis(1, at = weekday, labels = weekday_name)
  plot(Voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n")
  axis(1, at = weekday, labels = weekday_name)
  plot(Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering",xaxt = "n", col = line_col[1])
  axis(1, at = weekday, labels = weekday_name)
  lines(Sub_metering_2, type = "l", col = line_col[2])
  lines(Sub_metering_3, type = "l", col = line_col[3])
  legend("topright", lty = 1, col = line_col, legend = names(data_red)[7:9])
  plot(Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_powe", xaxt = "n")
  axis(1, at = weekday, labels = weekday_name)  
})
dev.off()
