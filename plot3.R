## Coursera - Exploratory Data Analysis - Course Project 1
## Plot 3 (Energy sub metering over Time)

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

## Set to single plot in graph
par(mfrow=c(1,1))

## Create base plot of sub meter energy over time with black line for meter 1
plot(powerData$Date_time, powerData$Sub_metering_1, type="l", lty=1,
     col="black", xlab = "", ylab = "Energy sub metering")
## Add additional red line for meter 2
lines(powerData$Date_time, powerData$Sub_metering_2, type="l", lty=1,
      col="red")
## Add additional blue line for meter 3
lines(powerData$Date_time, powerData$Sub_metering_3, type="l", lty=1,
      col="blue")
## Add legend identifying meter by line color
legend("topright", lty=1, col=c("black", "red", "blue"), bty="n",
       legend=c(str_pad("Sub_metering_1", 23, side="right", pad=" "),
                str_pad("Sub_metering_2", 23, side="right", pad=" "),
                str_pad("Sub_metering_3", 23, side="right", pad=" ")))

## Export the plot to png
dev.copy(png, "plot3.png", width=480, height=480)
dev.off()