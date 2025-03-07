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
png("plot4.png", width = 480, height = 480)

# Partition into 4 regions
par( mfrow = c(2, 2) )

# Draw the first plot (top left)
plot(
  power_data$Timestamp,
  power_data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power"
)

# Draw the second plot (top right)
plot(
  power_data$Timestamp,
  power_data$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Global Active Power"
)

# Draw the third plot (bottom left)
# Draw the graph and set the labels
plot(
  power_data$Timestamp,
  power_data$Sub_metering_1,
  xlab = "",
  ylab = "Energy sub metering",
  type = "n",
)

# Plot the graph for sub metering 1
lines(power_data$Timestamp,
      power_data$Sub_metering_1,
      col = "black")

# Plot the graph for sub metering 2
lines(power_data$Timestamp,
      power_data$Sub_metering_2,
      col = "red")

# Plot the graph for sub metering 3
lines(power_data$Timestamp,
      power_data$Sub_metering_3,
      col = "blue")

# Draw the legend
legend(
  x = "topright",
  lty = 1,
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue")
)

# Draw the fourth plot (bottom right)
plot(
  power_data$Timestamp,
  power_data$Global_reactive_power,
  type = "l",
  xlab = "datetime",
  ylab = "Global_reactive_power"
)

# Close the file
dev.off()