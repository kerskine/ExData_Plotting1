# Plot 4
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

# Now - plot it, but first, set up for 4 graphs - column fillplot.new()
png(filename = "plot4.png", height = 480, width = 480)
par(mfcol = c(2,2))

# Plot


# Upper Left Plot
        with(housepwr, plot(DateTime, Global_active_power, type="l", 
                            ylab = "Global Active Power (kilowatts)"))

# Lower Left Plot
        hp <- melt(housepwr, id.vars = "DateTime", measure.vars = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        with(hp, plot(DateTime, value, type="n", ylim = c(0,38), ylab = "Energy Sub Metering"))

        # Add the lines with proper colors

        with(subset(hp, variable == "Sub_metering_1"), lines(DateTime, value))

        with(subset(hp, variable == "Sub_metering_2"), lines(DateTime, value, col = "red"))
        with(subset(hp, variable == "Sub_metering_3"), lines(DateTime, value, col = "blue"))

        legend("topright", names(housepwr)[6:8], col = c("black", "red", "blue"), lty = c(1,1,1))
        
# Upper and Lower Right Plots

        with(housepwr, {
                plot(DateTime, Voltage, type="l")

        # Lower Right
                plot(DateTime, Global_reactive_power, type="l")
       
})

# Copy plot to png file
        dev.off()
        print("Plot complete. Look for plot4.png in your working directory")
        
