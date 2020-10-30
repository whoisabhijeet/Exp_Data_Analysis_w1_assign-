m_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

m_data$Date <- as.Date(m_data$Date, "%d/%m/%Y")

m_data<- subset(m_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

m_data <- m_data[complete.cases(m_data),]

date_time <- paste(m_data$Date, m_data$Time)

date_time <- setNames(date_time, "DateTime")

m_data <- m_data[ ,!(names(m_data) %in% c("Date","Time"))]

m_data <- cbind(date_time, m_data)

m_data$date_time <- as.POSIXct(date_time)

hist(m_data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.copy(png,"plot1.png", width=480, height=480)

dev.off()