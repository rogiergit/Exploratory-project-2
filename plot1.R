# 1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all 
# sources for each of the years 1999, 2002, 2005, and 2008.

# Set defaults, load libraries
library(dplyr)    # Load package
par(mfrow=c(1,1)) # Set the default for graphs

# Reading the data. The script file is in the same directory as the data files
setwd("E:\\Dev\\R\\Coursera\\4 Exploratory Analysis\\project2\\")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Convert the dataframe table using dplyr
NEIdt <- tbl_df(NEI)

# Group the data by year and create a total per year using sum()
NEIgb <-
        NEIdt %>%
        group_by(year) %>%
        summarize(PM2.5total = sum(Emissions))

# Create a plot showing year versus tot PM2.5 total
plot(x=NEIgb$year, y=NEIgb$PM2.5total)

# Write plot to file
dev.copy(png, file= "plot1.png")
dev.off() #close png device