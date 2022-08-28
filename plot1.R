# Use sqldf to read only the selected records
# https://stackoverflow.com/questions/23197243/how-to-read-only-lines-that-fulfil-a-condition-from-a-csv-into-r
library(sqldf)
power_data <- sqldf::read.csv2.sql("data/household_power_consumption.txt",
                            sql = "select * from file where `Date` = '1/2/2007' or `Date` = '2/2/2007' order by `Date`, `Time`")

# Create the PNG image
png("plot1.png", width = 480, height = 480)

# Draw the graph
hist(
  power_data$Global_active_power,
  col = "red",
  xlab = "Global Active Power (kilowatts)",
  ylab = "Frequency",
  main = "Global Active Power"
)

# Close the file
dev.off()