## Reading the txt file and convert date and time
data <- read.table("household_power_consumption.txt", header = TRUE, quote = "\"", nrows = 2075259, sep = ";", dec = ".", comment.char="", na.strings="?", colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
data[["dat"]] <- as.POSIXlt(strptime(paste(data[,1], data[,2], sep = " "), "%d/%m/%Y %X"))

## Subsetting the data, only using data from 2007-02-01 and 2007-02-02
data_red <- subset(data,(format(data$dat,"%Y") == "2007") & (format(data$dat,"%m") == "02") & ((format(data$dat,"%d") == "01") | (format(data$dat,"%d") == "02")), select = Global_active_power)

## plot histogram  into a png file
png(file = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(data_red$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red", main = "Global Active Power", yaxt = "n")
axis(2,at = seq(0,1200,200), labels = seq(0,1200,200))
dev.off()
