# 3 Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a 
# plot answer this question.

# Set defaults, load libraries
par(mfrow=c(1,1)) # Set the default for graphs
library(ggplot2)  # Load package
library(dplyr)    # Load package

# Reading the data. The script file is in the same directory as the data files
setwd("E:\\Dev\\R\\Coursera\\4 Exploratory Analysis\\project2\\")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Convert the dataframe table using dplyr
NEIdt <- tbl_df(NEI)

# Summarize the data for the plot
NEItype <-
        NEIdt %>%
        filter(fips == "24510") %>%             # Filter the data on fips = 24510 which is Baltimore
        group_by(type, year) %>%                # Group by type and year
        summarize(PM2.5total = sum(Emissions))  # Create a total per type, per year


# Plot a chart for each type
qplot(data = NEItype, x=year, y=PM2.5total, facets = . ~ type)

# Write plot to file
dev.copy(png, file= "plot3.png")
dev.off() #close png device