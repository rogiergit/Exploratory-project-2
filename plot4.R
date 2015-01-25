# 4 Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999-2008?

# The field [EI.Sector] in the SCC classification dataset contains the coal combustion grouping

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
SCCdt <- tbl_df(SCC)

# Merge the datasets together on the field SCC
NEImerged <- merge(NEIdt, SCCdt, by="SCC") #This merge takes a while

# Subset data to Sector descriptions containing coal
NEIfilter <- subset(NEImerged, grepl('Coal', EI.Sector))

# Summarize the data for the plot
NEIcoal <- 
        NEIfilter %>%
        group_by(year) %>%                      # Group by year
        summarize(PM2.5total = sum(Emissions))  # Create a total per year

# Plot a chart for each type
qplot(data = NEIcoal, x=year, y=PM2.5total)

# Write plot to file
dev.copy(png, file= "plot4.png")
dev.off() #close png device