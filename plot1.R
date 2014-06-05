rm(list=ls(all=TRUE)) 
gc()

wdir<-"C:/Users/Michael/Documents/GitHub/ExData_Plotting1"
setwd(wdir)

df <- read.table('household_power_consumption.txt',header=TRUE,sep=";",stringsAsFactors=FALSE)
df<-subset(df,((df$Date=="1/2/2007")|(df$Date=="2/2/2007")))
gc()

cols_with_miss<-c("Global_active_power","Global_reactive_power","Voltage",
                  "Global_intensity","Sub_metering_1","Sub_metering_2")

for (col in cols_with_miss) {
  df[,col]<-as.numeric(df[,col])
}

apply(df, 2, function (x) sum(is.na(x)))
#there seem to be no nans left

#process dates and times
str_dates<-as.character(df$Date)
str_times<-as.character(df$Time)
str_date_time<-paste(df$Date,df$Time,sep=", ")
date_times<-strptime(str_date_time,format="%d/%m/%Y, %H:%M:%S")
df$datetime<-date_times

#plot 1
png(filename='plot1.png') #the requested 480-by-480 is the default option
hist(df$Global_active_power,col='red',main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()