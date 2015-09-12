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

#Filter selected dates and put them in frame called test 1
test1<-data
test1$Date<-as.Date(test1$Date) #set Date variable from POSIXlt back to date...helped me to filter
date1 <- grepl('2007-02-01', test$Date)
date2<-grepl("2007-02-02",test$Date)
mydates<-date1|date2 #create logical vector of dates I want

test1<-test1[mydates,]

#Plot 2
png("plot2.png", width=480, height=480)
plot(test1$Date,test1$Global_active_power, type="l", ylab="Global Active Power (kilowatts)")
dev.off()
