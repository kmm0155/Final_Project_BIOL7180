#!/usr/bin/Rscript

# This script will be used as a piece of the whole, but is for the creation of a 3-D Line Graph in GGplot within R.
# This script is also set up to be ran individually if desired

# Set working directory and where to save your graph
setwd("/home/aubcls98/Final_Project_BIOL7180")
getwd()

# Upload your CSV file containing data
datum=read.csv(file.choose()))


# View data to make sure it was uploaded correctly 
head(datum)

# Create a tiff file for your graph
tiff("Line_Graph.tiff",width=8,height=6,units='in',res=300)

# Using GGplot, add the data and axes to the graph
Line_Graph <- ggplot(data=datum, aes(x="Hatchling Mass (g)",y="Hatchling SVL (mm)")) +
    geom_line(stat=
    theme_minimal() +
    labs(title=
