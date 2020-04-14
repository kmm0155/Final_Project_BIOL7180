#!usr/bin/R #whatever the she-bang line is supposed to be

#this is a script that will create a bar graph from example qPCR data.
#this script is one part of a larger script that will incorporate several
#different graph options.

#first, designate where you want to save your graphs
setwd("C:\Users\Tori Coutts\Desktop")
getwd()

#create a tiff file for your graph
tiff("EEF2.tiff",width=8,height=6,units='in',res=300)

#add the data and axes to the graph

#turn the development of the tiff graph off
dev.off()

