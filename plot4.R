## Coursera - Exploratory Data Analysis - Course Project 1
## Plot 4 (Grid of four plots)

## Call data preparation script. Reads data in from file, filters the data to
## only the subset of observations we are interested in and tidies the data up.
prepareScript <- "./prepare_data.R"
if(!file.exists(prepareScript))
{
    stop("The prepare_data.R is required for reading and preparing the data as
         expected by this script.")
}
source(prepareScript)

## Verify the expected dataset exists after running the script.
if(!"powerData" %in% ls())
{
    stop("The data preparation script did not run properly.")
}

## Create the plot using R base plotting system

## Set to 2x2 plot grid in graph, filling rows first
par(mfrow=c(2,2))

## Create first plot of Global Active Power over time
plot(powerData$Date_time, powerData$Global_active_power, type="l", lty=1,
     col="black", xlab = "", ylab = "Global Active Power")
## Create second plot of Voltage over time
plot(powerData$Date_time, powerData$Voltage, type="l", lty=1,
     col="black", xlab = "datetime", ylab = "Voltage")
## Create third plot of Sub metering over time, include first line for meter 1
plot(powerData$Date_time, powerData$Sub_metering_1, type="l", lty=1,
     col="black", xlab = "", ylab = "Energy sub metering")
## Add additional red line to third plot for meter 2
lines(powerData$Date_time, powerData$Sub_metering_2, type="l", lty=1,
      col="red")
## Add additional blue line to third plot for meter 3
lines(powerData$Date_time, powerData$Sub_metering_3, type="l", lty=1,
      col="blue")
## Add legend to third plot identifying meter by line color
legend("topright", lty=1, col=c("black", "red", "blue"), bty="n",
       legend=c(str_pad("Sub_metering_1", 23, side="right", pad=" "),
                str_pad("Sub_metering_2", 23, side="right", pad=" "),
                str_pad("Sub_metering_3", 23, side="right", pad=" ")))
## Create fourth plot of Global Reactive Power over Time
plot(powerData$Date_time, powerData$Global_reactive_power, type="l", lty=1,
     col="black", xlab = "datetime", ylab = "Global_reactive_power")

## Export the plot to png
dev.copy(png, "plot4.png", width=480, height=480)
dev.off()
