# Plot 2
library(dplyr)
library(readr)
library(lubridate)

# You should have already downloaded and unzipped household_power_consumption.zip

# Check to see if you've run "housepwr" exists (tidy dataset), and if not, create it

if(!exists("housepwr")) {
        
        housepwr <- fread("household_power_consumption.txt", na.strings = "?")
        
        # Use parse_date_time to 'mutate' the screwball dates to POSIXct format
        
        housepwr <- mutate(housepwr, DateTime = parse_date_time(paste(Date, Time), "d/m/y HMS"))
        
        # Clean it up, putting DateTime in first column
        
        housepwr <- housepwr[, c(10, 3:9) ]
        
        # Now filter the date to get the dates we want: 
        
        housepwr <- filter(housepwr, DateTime >= as.Date("2007-02-01") & DateTime < as.Date("2007-02-03") )
        
}

# Now - plot it
png(filename = "plot2.png", height = 480, width = 480)
with(housepwr, plot(DateTime, Global_active_power, type="l", ylab = "Global Active Power (kilowatts)"))



# Copy to png file

dev.off()
print("Plot complete. Look for plot2.png in your working directory")