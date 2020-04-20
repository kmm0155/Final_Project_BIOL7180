BIOL 7180: Scripting for Biologists
FINAL PROJECT
By Kaitlyn Murphy, Tori Coutts, and Megan Roberts

GOALS: This page will describe an efficient and useful way to create manuscript-ready graphs using GGplot. These scripts would preferentially work the best in R/RStudio. 

GGplot: grammar of graphics! It is a package within R that generates figures. It is widely used amongst anyone who creates professional figures for presentations or manuscripts.

INCLUDED:
1) R Script using GGplot function with 3 different outputs (.tiff, .jpeg, .png) for each graph type: line plot, point plot, bar plot
2) Manuscript format of how to use script
3) Presentation format of how to use script

NOTE: R is generally run line by line, only calling on the script you need to use at a certain point in your analyses. We have given you 2 options for running the script utilizing Ggplot 1) run via the command line (not usually recommended), but can be powerful as well or 2) run within R itself. 

DOWNLOAD R: https://rstudio.com/products/rstudio/download/

TO USE THIS SCRIPT ON THE COMMAND LINE:
1. Clone the repository
2. Download the Example_data_modified.csv file and Configuration_script.sh
3. Modify the Configuration_script.sh script to set your working directory to your own desktop
4. Download R onto your personal desktop
5. Use the prompt R CMB BATCH 
6. Highlight the whole Configuration_script.sh file and run it in R 
7. Select the output you want (graph type and file type)
8. Hit enter, you now have a graph. 

TO USE THIS SCRIPT IN R:
1. Clone the repository
2. Download the Example_data_modified.csv file and Configuration_script.sh
3. Modify the Configuration_script.sh script to set your working directory to your own desktop
4. Download R onto your personal desktop
5. Highlight the whole Configuration_script.sh file and run it in R 
6. Select the output you want (graph type and file type)
7. Hit enter, you now have a graph.

######THIS SCRIPT######

1. Github page: https://github.com/kmm0155/Final_Project_BIOL7180
2. Set your working directory (where you want to load your data)
3. setwd(“working directory you want”)
4. getwd()
5. Upload your data: datum=read.csv(file.choose())
6. Ensure these data were properly uploaded: head(datum)

7. Install the GGPLOT package in R: install.packages('ggplot2')
8. Load the GGPLOT library in R: library(ggplot2)

9. Basic ggplot structure: ggplot(data= .csv, aes(x= x-value, y= y-value))

Using this structure, you can then add on the specifics of the graph you want!
ggplot(data= .csv, aes(x= x-value, y= y-value))
geom_point(aes(color=black))
theme_classic()

10. Call on the tiff function to begin saving a figure: tiff("BodyCondition.tiff", width = 8, height = 6, units = 'in', res = 300)
11. Insert your script for your graph
12. End with to save to your working directory: dev.off()



