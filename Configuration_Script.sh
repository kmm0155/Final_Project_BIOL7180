#!/opt/asn/apps/R_3.6.1/bin/R

# Final Project- Creating a Professional 3-D Figure Using GGplot within R
# Contributors- Tori Coutts, Kaitlyn Murphy, and Megan Roberts

# This script will be used after starting up the R atmosphere in which GGplot will be ran.

# Sets current working directory to where R will be ran and graphs will be saved
#setwd("/Users/Desktop")

# Installing GGplot, if needed
print("Do you have GGplot previously installed? (Y/N)")
response1 = select.list(c("Y","N"), preselect=NULL, multiple=FALSE)
if(response1=="N") {install.packages('ggplot2')}

# Starting up GGplot
library(ggplot2)

# Reading the CSV file and making sure R uploaded it correctly
datum=read.csv(file.choose())
head (datum)

# Choosing the plotting and output type
cat("Choose which graph and file type you would like:
	1-1: Bar graph/Tiff
	1-2: Bar graph/PNG
	1-3: Bar graph/JPEG
  	2-1: Point graph/Tiff
  	2-2: Point graph/PNG
  	2-3: Point graph/JPEG
  	3-1: Line graph/Tiff
 	3-2: Line graph/PNG
  	3-3: Line graph/JPEG\n")
response2 = select.list(c("1-1", "1-2", "1-3", "2-1", "2-2", "2-3", "3-1", "3-2", "3-3"), preselect=NULL, multiple=FALSE)

#Bar graph saved as a Tiff
if(response2 == "1-1") {
MomVsEggMass <- ggplot(data=datum,aes(x=MOM,y=AVGEGGMASS)) +
     geom_bar(stat="identity",fill="steelblue") +
     theme_minimal() +
     labs(title="", x="Mom ID", y="Average Egg Mass (g)") +
     theme(axis.title.x = element_text(size=10,vjust=0),
           axis.text.x = element_text(size=8,color="black"),
           axis.title.y = element_text(size=10,vjust=3),
           axis.text.y = element_text(size=8,color="black"))
MomVsEggMass
ggsave(file="MomVsEggMass.tiff")
}

#Bar graph saved as a PNG
if(response2 == "1-2") {
MomVsEggMass <- ggplot(data=datum,aes(x=MOM,y=AVGEGGMASS)) +
     geom_bar(stat="identity",fill="steelblue") +
     theme_minimal() +
     labs(title="", x="Mom ID", y="Average Egg Mass (g)") +
     theme(axis.title.x = element_text(size=10,vjust=0),
           axis.text.x = element_text(size=8,color="black"),
           axis.title.y = element_text(size=10,vjust=3),
           axis.text.y = element_text(size=8,color="black"))
MomVsEggMass
ggsave(file="MomVsEggMass.png")
}

#Bar graph saved as a JPEG
if(response2 == "1-3") {
MomVsEggMass <- ggplot(data=datum,aes(x=MOM,y=AVGEGGMASS)) +
     geom_bar(stat="identity",fill="steelblue") +
     theme_minimal() +
     labs(title="", x="Mom ID", y="Average Egg Mass (g)") +
     theme(axis.title.x = element_text(size=10,vjust=0),
           axis.text.x = element_text(size=8,color="black"),
           axis.title.y = element_text(size=10,vjust=3),
           axis.text.y = element_text(size=8,color="black"))
MomVsEggMass
ggsave(file="MomVsEggMass.jpg")
}

#Point graph saved as a Tiff
if (response2 == "2-1") {
#Begin by running a basic linear mixed-effects model and call on the summary to see the results.
#Here I am analyzing the log of hatchling mass to hatchling snout-vent length (SVL).
  
resultshatchmass=lme(log(MASS)~log(SVL),data=datum,random=~1|MOM,na.action=na.omit)

#Next, we need to convert these values into residuals that we can plot. Do this first by creating a new dataset (datum4)
datum4 <- datum[complete.cases(datum[,"MASS"]),]

#Next, add a column wihtin the dataset that is the residuals of the linear mixed-effects model. 
datum4$resids <- resid(resultshatchmass)

#Check out a very basic boxplot of these data.
plot(resids~EGGMASS,datum4)

#Now let's graph this with GGPLOT! I will be making three graphs in one figure. 

#Create the varibale that will be section (A) in our figure.

bodycondition <- ggplot() +
    geom_point(data=datum4, aes(x=EGGMASS, y=resids), shape=1) +
    geom_smooth(data=datum4, aes(x=EGGMASS, y=resids), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling body condition") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black"))

#Now, let's create section (B) for our figure! Again, begin by calling on the tiff function
#Here we are plotting hatchling mass against eff mass
  
hatchlingmass <- ggplot() +
    geom_point(data=datum4, aes(x=EGGMASS, y=MASS), shape=1) +
    geom_smooth(data=datum4, aes(x=EGGMASS, y=MASS), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling mass (g)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black")) 
  
#Lastly, make section (C) of our figure! This will show hatchling snout-vent length (SVL). 
  
hatchlingsvl <- ggplot() +
    geom_point(data=datum4, aes(x=EGGMASS, y=SVL), shape=1) +
    geom_smooth(data=datum4, aes(x=EGGMASS, y=SVL), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black")) 
  
#To combine them all to 1 figure, follow this script below.
  
hatchlingmass1 <- arrangeGrob(hatchlingmass, top = textGrob("a)", x = unit(0.10, "npc")
                                                 , y = unit(0, "npc"), just=c("left","top"),
                                                 gp=gpar(col="black", fontsize=15)))
  
hatchlingsvl1 <- arrangeGrob(hatchlingsvl, top = textGrob("b)", x = unit(0.10, "npc")
                                                 , y = unit(0, "npc"), just=c("left","top"),
                                                 gp=gpar(col="black", fontsize=15)))
  
bodycondition1 <- arrangeGrob(bodycondition, top = textGrob("c)", x = unit(0.10, "npc")
                                                  , y   = unit(0, "npc"), just=c("left","top"),
                                                  gp=gpar(col="black", fontsize=15)))
  
tiff("Figure1.tiff", width = 4, height = 6, units = 'in', res = 300)

#Arrange them in the figure using this command.
grid.arrange(hatchlingmass1, hatchlingsvl1, bodycondition1, ncol = 1)
  
#Run dev.off, and check out the cool figure in your working directory.
dev.off()
}

#Point graph saved as a PNG
if (response2 == "2-2") {
#Begin by running a basic linear mixed-effects model and call on the summary to see the results.
#Here I am analyzing the log of hatchling mass to hatchling snout-vent length (SVL).
  
resultshatchmass=lme(log(MASS)~log(SVL),data=datum,random=~1|MOM,na.action=na.omit)

#Next, we need to convert these values into residuals that we can plot. Do this first by creating a new dataset (datum4)
datum4 <- datum[complete.cases(datum[,"MASS"]),]

#Next, add a column wihtin the dataset that is the residuals of the linear mixed-effects model. 
datum4$resids <- resid(resultshatchmass)

#Check out a very basic boxplot of these data.
plot(resids~EGGMASS,datum4)

#Now let's graph this with GGPLOT! I will be making three graphs in one figure. 

#Create the varibale that will be section (A) in our figure.

bodycondition <- ggplot() +
    geom_point(data=datum4, aes(x=EGGMASS, y=resids), shape=1) +
    geom_smooth(data=datum4, aes(x=EGGMASS, y=resids), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling body condition") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black"))

#Now, let's create section (B) for our figure! Again, begin by calling on the tiff function
#Here we are plotting hatchling mass against eff mass
  
hatchlingmass <- ggplot() +
    geom_point(data=datum4, aes(x=EGGMASS, y=MASS), shape=1) +
    geom_smooth(data=datum4, aes(x=EGGMASS, y=MASS), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling mass (g)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black")) 
  
#Lastly, make section (C) of our figure! This will show hatchling snout-vent length (SVL). 
  
hatchlingsvl <- ggplot() +
    geom_point(data=datum4, aes(x=EGGMASS, y=SVL), shape=1) +
    geom_smooth(data=datum4, aes(x=EGGMASS, y=SVL), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black")) 
  
#To combine them all to 1 figure, follow this script below.
  
hatchlingmass1 <- arrangeGrob(hatchlingmass, top = textGrob("a)", x = unit(0.10, "npc")
                                                 , y = unit(0, "npc"), just=c("left","top"),
                                                 gp=gpar(col="black", fontsize=15)))
  
hatchlingsvl1 <- arrangeGrob(hatchlingsvl, top = textGrob("b)", x = unit(0.10, "npc")
                                                 , y = unit(0, "npc"), just=c("left","top"),
                                                 gp=gpar(col="black", fontsize=15)))
  
bodycondition1 <- arrangeGrob(bodycondition, top = textGrob("c)", x = unit(0.10, "npc")
                                                  , y   = unit(0, "npc"), just=c("left","top"),
                                                  gp=gpar(col="black", fontsize=15)))
  
png("Figure1.png", width = 4, height = 6, units = 'in', res = 300)
  
#Arrange them in the figure using this command.
grid.arrange(hatchlingmass1, hatchlingsvl1, bodycondition1, ncol = 1)
  
#Run dev.off, and check out the cool figure in your working directory.
dev.off()
}

if (response2 == "2-3") {
#Begin by running a basic linear mixed-effects model and call on the summary to see the results.
#Here I am analyzing the log of hatchling mass to hatchling snout-vent length (SVL).
  
resultshatchmass=lme(log(MASS)~log(SVL),data=datum,random=~1|MOM,na.action=na.omit)

#Next, we need to convert these values into residuals that we can plot. Do this first by creating a new dataset (datum4)
datum4 <- datum[complete.cases(datum[,"MASS"]),]

#Next, add a column wihtin the dataset that is the residuals of the linear mixed-effects model. 
datum4$resids <- resid(resultshatchmass)

#Check out a very basic boxplot of these data.
plot(resids~EGGMASS,datum4)

#Now let's graph this with GGPLOT! I will be making three graphs in one figure. 

#Create the varibale that will be section (A) in our figure.

bodycondition <- ggplot() +
    geom_point(data=datum4, aes(x=EGGMASS, y=resids), shape=1) +
    geom_smooth(data=datum4, aes(x=EGGMASS, y=resids), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling body condition") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black"))

#Now, let's create section (B) for our figure! Again, begin by calling on the tiff function
#Here we are plotting hatchling mass against eff mass
  
hatchlingmass <- ggplot() +
    geom_point(data=datum4, aes(x=EGGMASS, y=MASS), shape=1) +
    geom_smooth(data=datum4, aes(x=EGGMASS, y=MASS), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling mass (g)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black")) 
  
#Lastly, make section (C) of our figure! This will show hatchling snout-vent length (SVL). 
  
hatchlingsvl <- ggplot() +
    geom_point(data=datum4, aes(x=EGGMASS, y=SVL), shape=1) +
    geom_smooth(data=datum4, aes(x=EGGMASS, y=SVL), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black")) 
  
#To combine them all to 1 figure, follow this script below.
  
hatchlingmass1 <- arrangeGrob(hatchlingmass, top = textGrob("a)", x = unit(0.10, "npc")
                                                 , y = unit(0, "npc"), just=c("left","top"),
                                                 gp=gpar(col="black", fontsize=15)))
  
hatchlingsvl1 <- arrangeGrob(hatchlingsvl, top = textGrob("b)", x = unit(0.10, "npc")
                                                 , y = unit(0, "npc"), just=c("left","top"),
                                                 gp=gpar(col="black", fontsize=15)))
  
bodycondition1 <- arrangeGrob(bodycondition, top = textGrob("c)", x = unit(0.10, "npc")
                                                  , y   = unit(0, "npc"), just=c("left","top"),
                                                  gp=gpar(col="black", fontsize=15)))
  
jpeg("Figure1.jpeg", width = 4, height = 6, units = 'in', res = 300)
  
#Arrange them in the figure using this command.
grid.arrange(hatchlingmass1, hatchlingsvl1, bodycondition1, ncol = 1)
  
#Run dev.off, and check out the cool figure in your working directory.
dev.off()
}

#Line graph saved as a Tiff
if (response2 == "3-1") {
Line_Graph = ggplot() +
    geom_line(data=datum, aes(x=EGGMASS,y=SVL)) +
    theme_minimal() +
    labs(title="",x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.0)) +
ggsave(file="Line_Graph.tiff")
}

#Line graph saved as a PNG
if (response2 == "3-2") {
Line_Graph = ggplot() +
    geom_line(data=datum, aes(x=EGGMASS,y=SVL)) +
    theme_minimal() +
    labs(title="",x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.0)) +
ggsave(file="Line_Graph.png")
}

#Line graph saved as a JPEG
if (response2 == "3-3") {
Line_Graph = ggplot() +
    geom_line(data=datum, aes(x=EGGMASS,y=SVL)) +
    theme_minimal() +
    labs(title="",x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.0)) +
ggsave(file="Line_Graph.jpg")
}
