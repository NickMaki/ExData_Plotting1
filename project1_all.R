setwd("C:/COURSERA/Exploratory_data_analysis/Project1/ExData_Plotting1")

library(dplyr) 
library(data.table)

data<-read.table("household_power_consumption.txt", header=TRUE,sep=";",na.strings="?")

#Remove NAs
check_na<-complete.cases(data)
data<-data[check_na,]
# Check class of each variable
sapply(data,class)

#Create one date variable using 
data$Date<-paste(data$Date,data$Time) #concatenate Date and Time objects into a character variable
data$Date<-strptime(data$Date,"%d/%m/%Y %H:%M:%S")
data$Time <- NULL #remove Time variable since this is now stored in Date variable

#Filter selected dates and put them in frame called test
test<-data
test$Date<-as.Date(test$Date) #set Date variable from POSIXlt back to date...helped me to filter
date1 <- grepl('2007-02-01', test$Date)
date2<-grepl("2007-02-02",test$Date)
mydates<-date1|date2 #create logical vector of dates I want
test<-test[mydates,] #create my final data frame

#Plot 1
png("plot1.png", width=480, height=480)
hist(test$Global_active_power,xlab="Global Active Power (Kilowatts)", main="Global Active Power", col="red", include.lowest=TRUE)
dev.off()

#Plot 2-4 I need the POSIXlt format of original data 
test1<-data
test1<-test1[mydates,]

#Plot 2
png("plot2.png", width=480, height=480)
plot(test1$Date,test1$Global_active_power, type="l", ylab="Global Active Power (kilowatts)")
dev.off()

#Plot 3
png("plot3.png", width=480, height=480)
with(test1,{
  
  plot(Date,Sub_metering_1,ylab="Energy sub metering",type="n")
  lines(Date,Sub_metering_1)
  lines(Date,Sub_metering_2, col="red")
  lines(Date,Sub_metering_3, col="blue")
  legend("topright",lwd=1,col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),cex=0.65)
} 
)
dev.off()

#Plot 4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
par(mar=c(3.8,3.8,2.1,2.1))
with(test1,{
  
  plot(Date,Global_active_power,type="l",ylab="Global Active Power",xlab="")
  plot(Date,Voltage,type="l",ylab="Voltage", xlab="datetime")
  #3rd plot 2nd row first column
  plot(Date,Sub_metering_1,ylab="Energy sub metering",xlab="",type="n")
  lines(Date,Sub_metering_1)
  lines(Date,Sub_metering_2, col="red")
  lines(Date,Sub_metering_3, col="blue")
  legend("topright",lwd=1,col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),cex=0.5)
  plot(Date,Global_reactive_power,type="l",ylab="Global_reactive_power", xlab="datetime")
} 
)
dev.off()
