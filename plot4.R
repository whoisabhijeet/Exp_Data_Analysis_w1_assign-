m_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

m_data$Date <- as.Date(m_data$Date, "%d/%m/%Y")

m_data<- subset(m_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

m_data <- m_data[complete.cases(m_data),]

date_time <- paste(m_data$Date, m_data$Time)

date_time <- setNames(date_time, "DateTime")

m_data <- m_data[ ,!(names(m_data) %in% c("Date","Time"))]

m_data <- cbind(date_time, m_data)

m_data$date_time <- as.POSIXct(date_time)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(m_data, {
  plot(Global_active_power~date_time, type="l",ylab="Global Active Power (kilowatts)", xlab="")
  
  plot(Voltage~date_time, type="l",ylab="Voltage (volt)", xlab="")
  
  plot(Sub_metering_1~date_time, type="l",ylab="Global Active Power (kilowatts)", xlab="")
  
  lines(Sub_metering_2~date_time,col='Red')
  
  lines(Sub_metering_3~date_time,col='Blue')
  
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power~date_time, type="l",ylab="Global Rective Power (kilowatts)",xlab="")})

dev.copy(png, file="plot4.png", height=480, width=480)

dev.off()