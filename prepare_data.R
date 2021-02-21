## Coursera - Exploratory Data Analysis - Course Project 1
## This script will load and prepare the data for use by the plotting scripts.

## Load & verify version for Library dependencies
library(tidyverse)
if(packageVersion("tidyverse") < "1.3.0")
{
    warning("Library tidyverse v1.3.0 expected. Script may not run properly.")
}
library(anytime)
if(packageVersion("anytime") < "0.3.9")
{
    warning("Library anytime v0.3.9 expected. Script may not run properly.")
}

## Verify data exists in expected location
dataFile <- "./data/household_power_consumption.txt"
if(!file.exists(dataFile))
{
    stop(c("Data not found. Expecting: ", dataFile))
}

## For course purposes, not necessary to read in entire data file. For sake of
## efficiency, only get what is needed.

## Read one row just to get the header names
dataNames <- names(read_delim(dataFile, ";", col_names = TRUE, n_max=1))

## Read again with skip so that only the desired records are read from the file
## Desired records are dates 2007-02-01 through 2007-02-02, these records start
## at line 66638 and there are 1440 recorded observations per day. These values
## were determined via initial examination of the dataset.
startRecord <- 66637
recordCount <- 2880 #Data recorded 1 sample / minute (60mins * 24hrs * 2days)
powerData <- read_delim(dataFile, ";", col_names = FALSE, na = "?",
                        col_types = list(
                            col_date(format="%d/%m/%Y"),
                            col_time(format="%H:%M:%S"),
                            col_double(), col_double(), col_double(), 
                            col_double(), col_double(), col_double(), 
                            col_double()),
                        skip=startRecord, n_max=recordCount)
names(powerData) <- dataNames

## Tidy the data by merging the date and time columns into a single DateTime
## object column called Date_time
powerData <- powerData %>%
    ## Add date_time column by pasting Date and Time together with anytime
    mutate(Date_time = anytime(paste(Date, Time))) %>%
    ## Remove original Date and Time columns
    select(-Date, -Time) %>%
    ## Move Date_time to the front
    select(Date_time, everything())