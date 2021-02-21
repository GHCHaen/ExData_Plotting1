## Coursera - Exploratory Data Analysis - Course Project 1
## Plot 1 (Global Active Power)

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

## Create histogram
hist(powerData$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

## Export the plot to png
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()