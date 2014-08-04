## Reading the txt file and convert date and time
data <- read.table("household_power_consumption.txt", header = TRUE, quote = "\"", nrows = 2075259, sep = ";", dec = ".", comment.char="", na.strings="?", colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
data[["dat"]] <- as.POSIXlt(strptime(paste(data[,1], data[,2], sep = " "), "%d/%m/%Y %X"))

## Subsetting the data, only using data from 2007-02-01 and 2007-02-02
data_red <- subset(data,(format(data$dat,"%Y") == "2007") & (format(data$dat,"%m") == "02") & ((format(data$dat,"%d") == "01") | (format(data$dat,"%d") == "02")), select = c(Sub_metering_1,Sub_metering_2,Sub_metering_3))

weekday <- seq(0,2880,1440)
weekday_name <- c("Thu","Fri","Sat")
line_col = c("black","red","blue")

## plot line graph  into a png file
png(file = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(data_red$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering",xaxt = "n", col = line_col[1])
axis(1, at = weekday, labels = weekday_name)
lines(data_red$Sub_metering_2, type = "l", col = line_col[2])
lines(data_red$Sub_metering_3, type = "l", col = line_col[3])
legend("topright", lty = 1, col = line_col, legend = names(data_red))
dev.off()
