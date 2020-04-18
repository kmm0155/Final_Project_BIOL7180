#This page will describe an efficient and useful way to create manuscript-ready graphs using GGplot.
#The below script would be run in R/R Studio.

#Set your working directory for where files will save. You will need to insert your own preferred directory.
#setwd("/Users/kaitlynmurphy/Desktop/JD")
#getwd()

#Install these packages!

install.packages('nlme')
install.packages('lme4')
install.packages('ggplot2')
install.packages('grid')
install.pacakges('gridExtra')

#Call on the libraries we will be using in this script.

library(nlme)
library(lme4)
library(ggplot2)
library(grid)
library(gridExtra)

#Load your data (in CSV format) and check to make sure R uploaded it correctly.

datum=read.csv(file.choose())
head(datum)

#Begin by running a basic linear mixed-effects model and call on the summary to see the results.
#Here I am analyzing the log of hatchling mass to hatchling snout-vent length (SVL).
  
resultshatchmass=lme(log(MASS)~log(SVL),data=datum,random=~1|MOM,na.action=na.omit)
summary(resultshatchmass)

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
