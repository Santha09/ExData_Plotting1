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

#draw the first histogram showing Global Active Power on to a png file
png("plot1.png")
with(Feb1t2Data,hist(Global_active_power,col="red",
                     xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power"))
dev.off()

