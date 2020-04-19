# Final Project- Creating a Professional 3-D Figure Using GGplot within R
# Contributors- Tori Coutts, Kaitlyn Murphy, and Megan Roberts

# This script will be used after starting up the R atmosphere in which GGplot will be ran.

# Sets current working directory to where R will be ran and graphs will be saved
#setwd("/Users/Desktop")

# Starting up GGplot
library(ggplot2)
library(lme4)

# Reading the CSV file and making sure R uploaded it correctly
datum=read.csv("Example_Data_Modified.csv")
head (datum)

#Bar graph saved as a Tiff
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

#Bar graph saved as a PNG
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

#Bar graph saved as a JPEG
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

#Point graph saved as a Tiff
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

#Point graph saved as a PNG
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

#Point graph saved as a JPEG
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

#Line graph with tiff output
Line_Graph <- ggplot(data=datum,aes(x=EGGMASS,y=SVL)) +
    geom_line(stat="identity") +
    theme_minimal() +
    labs(title="",x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.0)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
    axis.title.x = element_text(size=8,color="black"),
    axis.title.y = element_text(size=10,vjust=3),
    axis.title.y = element_text(size=8,color="black"))
Line_Graph
ggsave(file="Line_Graph.tiff")

#Line graph with png output
Line_Graph <- ggplot(data=datum,aes(x=EGGMASS,y=SVL)) +
    geom_line(stat="identity") +
    theme_minimal() +
    labs(title="",x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.0)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
    axis.title.x = element_text(size=8,color="black"),
    axis.title.y = element_text(size=10,vjust=3),
    axis.title.y = element_text(size=8,color="black"))
Line_Graph
ggsave(file="Line_Graph.png")

#Line graph with jpeg output
Line_Graph <- ggplot(data=datum,aes(x=EGGMASS,y=SVL)) +
    geom_line(stat="identity") +
    theme_minimal() +
    labs(title="",x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.0)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
    axis.title.x = element_text(size=8,color="black"),
    axis.title.y = element_text(size=10,vjust=3),
    axis.title.y = element_text(size=8,color="black"))
Line_Graph
ggsave(file="Line_Graph.jpeg")
