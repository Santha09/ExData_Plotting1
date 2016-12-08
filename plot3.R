# memory to be used if I download the entire dataset
nrows <- 2075259
ncols <- 9
sizemb <- nrows * ncols * 8/2^20
# I don't want to download that big dataset (142.5 mb), so I am going to download only a subset of data

#Set the working directory
setwd("/Users/GPR/Learning/JohnHopkins - DS/ExploratoryAnalysis")
if (!file.exists("./Data")){dir.create("./Data")}
setwd("/Users/GPR/Learning/JohnHopkins - DS/ExploratoryAnalysis/Data")
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download the zip file into the data directory
if (!file.exists("powerconsum.zip")){
  download.file(fileurl,"powerconsum.zip",method="curl")
  unzip("powerconsum.zip")
}
filename <- "household_power_consumption.txt"
#get the column names after reading one row to avoid mistakes in typing
colname <- read.csv(filename,nrows=1,sep=";")
#subset the data from the file based on the feb 1 and feb 2 data
Feb1t2Data<-read.table(text = grep('^[1|2]/2/2007',readLines(filename),value=TRUE),
                       col.names = names(colname),sep=";",na.strings = '?')

#format the date and then concatenate the date with time and finally convert that into POSIXct
library(dplyr)
Feb1t2Data <- Feb1t2Data %>% mutate(DateTime = paste(as.Date(Date,format='%d/%m/%Y'),Time)) %>%
  mutate(DateTime=as.POSIXct(DateTime))

#plot multiple line chart onto a png graphic device
png("plot3.png",bg="transparent")
with(Feb1t2Data,{plot(DateTime,Sub_metering_1,col="black",type="l",ylab="Energy sub metering",xlab="")
  lines(DateTime,Sub_metering_2,col="red")
  lines(DateTime,Sub_metering_3, col="blue")})
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=1,lwd=2)
dev.off()