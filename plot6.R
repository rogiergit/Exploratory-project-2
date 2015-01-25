# 6 Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes 
# over time in motor vehicle emissions?

# Set defaults, load libraries
par(mfrow=c(1,1)) # Set the default for graphs
library(ggplot2)  # Load package
library(dplyr)    # Load package

# Reading the data. The script file is in the same directory as the data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Convert the dataframe table using dplyr
NEIdt <- tbl_df(NEI)
SCCdt <- tbl_df(SCC)

# Merge the datasets together on the field SCC
NEImerged <- merge(NEIdt, SCCdt, by="SCC") #This merge takes a while

# Motor vehicle sources can be found in the EI.Sector field containing the value Mobile
# Subset data to Sector descriptions containing Mobile
NEIfilter <- subset(NEImerged, grepl('Mobile', EI.Sector))

# Summarize the data for the plot
NEImobilebaltla <- 
        NEIfilter %>%
        filter(fips == "24510" | fips == "06037") %>%                           # Filter the data on Baltimore and Los Angeles County
        mutate(county = ifelse(fips=="24510", "Baltimore", "Los Angeles")) %>%  # Create a county field
        group_by(county, year) %>%                                              # Group by county and year
        summarize(PM2.5total = sum(Emissions))                                  # Create a total per county and year

NEImobilebaltla
# Plot a chart for each type
qplot(data = NEImobilebaltla, x=year, y=PM2.5total, facets = . ~ county)

# Write plot to file
dev.copy(png, file= "plot6.png")
dev.off() #close png device