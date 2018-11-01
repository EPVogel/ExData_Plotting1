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


#Build the timeseries plot
png(filename = "plot2.png",width = 480, height = 480)
plot(df_consumption_red$Datetime, df_consumption_red$Global_active_power, type= "l",xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()


