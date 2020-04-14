# !/bin/bash

# Final Project- Creating a Professional 3-D Figure Using GGplot within R
# Contributors- Tori Coutts, Kaitlyn Murphy, and Megan Roberts

# This script will be used to set up the R atmosphere in which GGplot will be ran.

# Starting up R
R

# Sets current working directory
setwd("~/user/Desktop")

# Reading the CSV file
data <- read.csv("input.csv")

# Choosing the plotting type
print("1- Bar Graph")
print("2- Point Graph")
print("3- Line Graph")
print("Enter plot type preference: ") plotnumber
