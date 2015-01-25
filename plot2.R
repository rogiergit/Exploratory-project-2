# 2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Set defaults, load libraries
par(mfrow=c(1,1)) # Set the default for graphs
library(dplyr)    # Load package

# Reading the data. The script file is in the same directory as the data files
setwd("E:\\Dev\\R\\Coursera\\4 Exploratory Analysis\\project2\\")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Convert the dataframe table using dplyr
NEIdt <- tbl_df(NEI)

# Summarize the data for the plot
NEIbalt <-
        NEIdt %>%
        filter(fips == "24510") %>%             # Filter the data on fips = 24510
        group_by(year) %>%                      # Group by year
        summarize(PM2.5total = sum(Emissions))  # Create a total per year

# Create a plot showing year versus tot PM2.5 total for Baltimore
plot(x=NEIbalt$year, y=NEIbalt$PM2.5total)


# Write plot to file
dev.copy(png, file= "plot2.png")
dev.off() #close png device
