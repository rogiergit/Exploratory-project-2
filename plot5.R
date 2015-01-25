# 5 How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Set defaults, load libraries
par(mfrow=c(1,1)) # Set the default for graphs
library(ggplot2)  # Load package
library(dplyr)    # Load package

# Reading the data. The script file is in the same directory as the data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Convert the dataframe table using dplyr
setwd("E:\\Dev\\R\\Coursera\\4 Exploratory Analysis\\project2\\")
NEIdt <- tbl_df(NEI)
SCCdt <- tbl_df(SCC)

# Merge the datasets together on the field SCC
NEImerged <- merge(NEIdt, SCCdt, by="SCC") #This merge takes a while

# Motor vehicle sources can be found in the EI.Sector field containing the value Mobile
# Subset data to Sector descriptions containing Mobile
NEIfilter <- subset(NEImerged, grepl('Mobile', EI.Sector))

# Summarize the data for the plot
NEImobilebalt <- 
        NEIfilter %>%
        filter(fips == "24510") %>%             # Filter the data on fips = 24510 which is Baltimore
        group_by(year) %>%                      # Group by year
        summarize(PM2.5total = sum(Emissions))  # Create a total per year

# Plot a chart for each type
qplot(data = NEImobilebalt, x=year, y=PM2.5total)

# Write plot to file
dev.copy(png, file= "plot5.png")
dev.off() #close png device
