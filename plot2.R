## Exploratory Data Analysis Week 1. Course Project 1.


## Step 0. Estimate memory required to read entire file

# Prior to loading the dataset into R, determine how much memory is required to read the entire file.
# Formula: memory required = no. of column * no. of rows * 8 bytes/numeric
# One gigabyte has 10^9 bytes
# The dataset has 2,075,259 rows and 9 columns.
giga_memory_req <- (9 * 2075259 * 8) / (10^9)


## Step 1. Stage the directory and get the data

#clear console
cat("\014")

#find out what the current directory is
getwd()

#set to the desired working directory using:
setwd()

#check if folder "data" exists in current directory. if it does not, a folder "data" will be created in current directory.
if(!file.exists("./data")){dir.create("./data")}

#create a new variable fileURL to store the URL
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#download file from fileURL and store it in folder "data" under filename "dataset.zip", specify method = "curl" to workaround the https component of the URL
download.file(fileURL, destfile = "./data/dataset.zip", method = "curl")

#unzip the zip file and stores files in the same folder as folder "data"
unzip("./data/dataset.zip")

#lists the files in the working directory
list.files()

#preview the data using a text editor such as Visual Studio Code


## Step 2. Read the data

# From course project question, "We will only be using data from the dates 2007-02-01 and 2007-02-02"  
#the first column of the dataset are dates in dd-mm-yyyy format
# Note that in this dataset missing values are coded as "?"
#from preview of data in text editor, obtain the row number that contains data for 2007-02-01
#since these data are obtained per minute, and there are 1440 minutes in a day, we need 2800 rows to cover data from 2007-02-01 to 2007-02-02
mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", row.names = NULL, na.strings = "?", skip = 66637, nrows = 2880)

#view the first 6 rows
head(mydata)

#add back column names
x <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colnames(mydata) <- x

#check classes of each column
str(mydata)


## 3. Make the required plots

## Plot 2. Scatterplot of datetime versus Global active power (kilowatts)

#open up graphic file png
png(filename = "plot2.png", width = 480, height = 480, units = "px")

#create additional column of date-time in order to create continuous data
mydata$datetime <- strptime(paste(mydata$Date, mydata$Time), format = "%d/%m/%Y %H:%M:%S")

#create the plot of "datetime" versus "Global_active_power"
with(mydata, plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))

#close off the graphical device
dev.off()
