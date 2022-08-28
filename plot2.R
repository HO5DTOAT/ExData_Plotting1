# Use sqldf to read only the selected records
# https://stackoverflow.com/questions/23197243/how-to-read-only-lines-that-fulfil-a-condition-from-a-csv-into-r
library(sqldf)
power_data <-
  sqldf::read.csv2.sql("data/household_power_consumption.txt",
                       sql = "select * from file where `Date` = '1/2/2007' or `Date` = '2/2/2007' order by `Date`, `Time`")

# Combine the date and time into a time stamp field
power_data[, "Timestamp"] <-
  as.POSIXct(paste(power_data[, "Date"], power_data[, "Time"], sep = " "),
             format = "%d/%m/%Y %T")

# Create the PNG image
png("plot2.png", width = 480, height = 480)

# Draw the graph
plot(
  power_data$Timestamp,
  power_data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

# Close the file
dev.off()