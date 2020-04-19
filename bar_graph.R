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

#selecting which graph you would like
cat("Choose which graph and file type you would like:
	1-1: Bar graph, tiff
	1-2: Bar graph, png
	1-3: Bar graph, jpg \n")
response = select.list(c("1-1", "1-2", "1-3", "2-1", "2-2", "2-3", "3-1", "3-2", "3-3"), preselect=NULL, multiple=FALSE)

#1-1: bar graph saved as a tiff
if(response == "1-1") {
MomVsEggMass <- ggplot(data=datum,aes(x=MOM,y=AVGEGGMASS)) +
    geom_bar(stat="identity",fill="steelblue") +
    theme_minimal() +
    labs(title="", x="Mom ID", y="Average Egg Mass (g)")
    theme(axis.title.x = element_text(size=10,vjust=0),
         axis.text.x = element_text(size=8,color="black"),
         axis.title.y = element_text(size=10,vjust=3),
         axis.text.y = element_text(size=8,color="black"))
MomVsEggMass
ggsave(file="MomVsEggMass.tiff")
}

#1-2: bar graph saved as a png
if(response == "1-2") {
MomVsEggMass <- ggplot(data=datum,aes(x=MOM,y=AVGEGGMASS)) +
    geom_bar(stat="identity",fill="steelblue") +
    theme_minimal() +
    labs(title="", x="Mom ID", y="Average Egg Mass (g)")
    theme(axis.title.x = element_text(size=10,vjust=0),
         axis.text.x = element_text(size=8,color="black"),
         axis.title.y = element_text(size=10,vjust=3),
         axis.text.y = element_text(size=8,color="black"))
MomVsEggMass
ggsave(file="MomVsEggMass.png")
}

#1-3: bar graph saved as a jpg
if(response == "1-3") {
MomVsEggMass <- ggplot(data=datum,aes(x=MOM,y=AVGEGGMASS)) +
    geom_bar(stat="identity",fill="steelblue") +
    theme_minimal() +
    labs(title="", x="Mom ID", y="Average Egg Mass (g)")
    theme(axis.title.x = element_text(size=10,vjust=0),
         axis.text.x = element_text(size=8,color="black"),
         axis.title.y = element_text(size=10,vjust=3),
         axis.text.y = element_text(size=8,color="black"))
MomVsEggMass
ggsave(file="MomVsEggMass.jpg")
}

