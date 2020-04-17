# !/bin/bash

# Final Project- Creating a Professional 3-D Figure Using GGplot within R
# Contributors- Tori Coutts, Kaitlyn Murphy, and Megan Roberts

# This script will be used to set up the R atmosphere in which GGplot will be ran.

# Starting up R
R

# Sets current working directory to where R will be ran and graphs will be saved
setwd("/Users/Desktop")

# Installing GGplot, if needed
print("Do you have GGplot previously installed? (Y/N)") response
If "Y" 
    then install.packages('ggplot2')
fi
If "N"
    then
fi

# Starting up GGplot
library(ggplot2)

# Reading the CSV file and making sure R uploaded it correctly
datum=read.csv(file.choose())
head (datum)

# Choosing the plotting type
print("1- Bar Graph")
print("2- Point Graph")
print("3- Line Graph")
print("Enter plot type preference: ") plotnumber


# If Option 1- Bar Graph is chosen:

# If Option 2- Point Graph is chosen:

# If Option 3- Line Graph is chosen:


# Choose Output (.png, tiff, .jpeg) 
