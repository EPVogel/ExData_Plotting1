library(dplyr)
library(readr)
library(lubridate)

#Set the working directory to where the data is stored. Plot will be created in this directory
#setwd()

#Set locale to English (I am using a German computer)
Sys.setlocale("LC_ALL","English")

df_raw <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings = "?") %>% tbl_df()
#convert date and time variables into a single datetime variable 
df_consumption <- df_raw %>% mutate(Datetime = dmy_hms(paste(Date,Time))) %>% select(-Date,-Time)
df_consumption <- df_consumption[,c(8,1,2,3,4,5,6,7)]

#filter dataset for the two dates we are considering
df_consumption_red <- df_consumption %>% filter(date(Datetime) == "2007-02-01" | date(Datetime) == "2007-02-02")

#Build the mixed plot
png(filename = "plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))

#4.1
plot(df_consumption_red$Datetime, df_consumption_red$Global_active_power, type= "l",xlab = "", ylab = "Global Active Power")

#4.2
plot(df_consumption_red$Datetime, df_consumption_red$Voltage, type= "l",xlab = "datetime", ylab = "Voltage")

#4.3
plot(df_consumption_red$Datetime, df_consumption_red$Sub_metering_1, type= "l",xlab = "", ylab = "Energy sub metering")
lines(df_consumption_red$Datetime, df_consumption_red$Sub_metering_2, col = "red")
lines(df_consumption_red$Datetime, df_consumption_red$Sub_metering_3, col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black", "red", "blue"),lty=1)

#4.4
plot(df_consumption_red$Datetime, df_consumption_red$Global_reactive_power, type= "l",xlab = "datetime", ylab = "Global_relative_power")
dev.off()

