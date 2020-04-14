# !/bin/bash

# Final Project- Creating a Professional 3-D Figure Using GGplot within R
# Contributors- Tori Coutts, Kaitlyn Murphy, and Megan Roberts

# This script will be used to set up the R atmosphere in which GGplot will be ran.

# Starting up R
R

# Sets current working directory to where R will be ran and graphs will be saved
setwd("~/user/Desktop")

# Starting up GGplot

# Choosing the plotting type
print("1- Bar Graph")
print("2- Point Graph")
print("3- Line Graph")
print("Enter plot type preference: ") plotnumber

#Reading the CSV file
data <- read.csv(input.csv")

# If Option 1- Bar Graph is chosen:

# If Option 2- Point Graph is chosen:

# If Option 3- Line Graph is chosen:
