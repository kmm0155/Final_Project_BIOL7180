#!/usr/bin/Rscript

#this is a script that will create a bar graph from example qPCR data.
#this script is one part of a larger script that will incorporate several
#different graph options.

#first, designate where you want to save your graphs
setwd("/Users/Tori Coutts/Desktop")
getwd()

#upload the file containing the data you want to plot
#MUST be a csv file
datum=read.csv(file.choose())

#make sure the data was properly uploaded by seeing just a few rows
head(datum)

response = select.list(c("1-1", "1-2", "1-3", "2-1", "2-2", "2-3", "3-1", "3-2", "3-3"), preselect=NULL, multiple=FALSE)
if(response == "1-1") {
tiff("MomVsEggMass.tiff",width=8,height=6,units='in',res=300)
MomVsEggMass <- ggplot(data=datum,aes(x=MOM,y=AVGEGGMASS)) +
    geom_bar(stat="identity",fill="steelblue") +
    theme_minimal() +
    labs(title="", x="Mom ID", y="Average Egg Mass (g)")
    theme(axis.title.x = element_text(size=10,vjust=0),
         axis.text.x = element_text(size=8,color="black"),
         axis.title.y = element_text(size=10,vjust=3),
         axis.text.y = element_text(size=8,color="black"))
MomVsEggMass
dev.off()
}
#create a tiff file for your graph
#tiff("MomVsEggMass.tiff",width=8,height=6,units='in',res=300)

#add the data and axes to the graph
#MomVsEggMass <- ggplot(data=datum,aes(x=MOM,y=AVGEGGMASS)) +
#    geom_bar(stat="identity",fill="steelblue") +
#    theme_minimal() +
#    labs(title="", x="Mom ID", y="Average Egg Mass (g)")
#    theme(axis.title.x = element_text(size=10,vjust=0),
#          axis.text.x = element_text(size=8,color="black"),
#          axis.title.y = element_text(size=10,vjust=3),
#          axis.text.y = element_text(size=8,color="black"))
#MomVsEggMass

#turn the development of the tiff graph off
#dev.off()

