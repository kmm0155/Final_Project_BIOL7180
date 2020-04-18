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

# Using GGplot, add the data and axes to the graph
Body_Condition <- ggplot() +
    geom_line(data=datum2, aes(x=EGGMASS,y=resids)) +
    theme_minimal() +
    labs(title="",x="Egg mass (g) at oviposition", y="Hatchling body condition") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.0)) +
    theme(axis.title.x = element_test(size=10,vjust=0),
    axis.title.x = element_text(size=8,color="black"),
    axis.title.y = element_text(size=10,vjust=3),
    axis.title.y = element_text(size=8,color="black"))
    
