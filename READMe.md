#This page will describe an efficient and useful way to create manuscript-ready graphs using GGplot.
#The below script would be run in R/R Studio.

#Library#

library(nlme)
library(lme4)
library(ggplot2)
library(emmeans)
library(grid)
library(gridExtra)

#Data Loaded#

datum=read.csv(file.choose())
head(datum)

setwd("/Users/kaitlynmurphy/Desktop/JD")
getwd()

#plot- body condition
  
  resultshatchmass2=lme(log(MASSBEF)~log(SVL),data=datum,random=~1|MOM,na.action=na.omit)

datum4 <- datum[complete.cases(datum[,"MASSBEF"]),]

  datum4$resids <- resid(resultshatchmass2)
  
  boxplot(resids~YOLKREM,datum4)
  plot(resids~EMASSBEF,datum4)
  
rem <- datum4[datum4$YOLKREM=="YES",]
summary(rem)
Nrem <- datum4[datum4$YOLKREM=="NO",]
summary(Nrem)

#how to insert an annotation

annotate(geom="text",x=0.95,
         y=0.05,label="Treatment", color="black") +

#body condition graph
  
  tiff("BodyCondition.tiff", width = 8, height = 6, units = 'in', res = 300)

bodycondition <- ggplot() +
    geom_point(data=rem, aes(x=EMASSBEF, y=resids), shape=1) +
    geom_point(data=Nrem, aes(x=EMASSBEF, y=resids)) +
    geom_smooth(data=rem, aes(x=EMASSBEF, y=resids), method=lm,se=FALSE, color="black", linetype="dashed") +
    geom_smooth(data=Nrem, aes(x=EMASSBEF, y=resids), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling body condition") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black"))
  
dev.off()

  #hatchling mass graph
  
  rem1 <- datum[datum$YOLKREM=="YES",]
  Nrem1 <- datum[datum$YOLKREM=="NO",]
  
  tiff("Hatchlingmass.tiff", width = 8, height = 6, units = 'in', res = 300)
  
hatchlingmass <- ggplot() +
    geom_point(data=rem1, aes(x=EMASSBEF, y=MASSBEF), shape=1) +
    geom_point(data=Nrem1, aes(x=EMASSBEF, y=MASSBEF)) +
    geom_smooth(data=rem1, aes(x=EMASSBEF, y=MASSBEF), method=lm,se=FALSE, color="black",linetype="dashed") +
    geom_smooth(data=Nrem1, aes(x=EMASSBEF, y=MASSBEF), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling mass (g)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black")) 
  
  dev.off()
  
  #hatchling svl graph
  
  tiff("hatchlingsvl.tiff", width = 8, height = 6, units = 'in', res = 300)
  
hatchlingsvl <- ggplot() +
    geom_point(data=rem1, aes(x=EMASSBEF, y=SVL), shape=1) +
    geom_point(data=Nrem1, aes(x=EMASSBEF, y=SVL)) +
    geom_smooth(data=rem1, aes(x=EMASSBEF, y=SVL), method=lm,se=FALSE, color="black", linetype="dashed") +
    geom_smooth(data=Nrem1, aes(x=EMASSBEF, y=SVL), method=lm,se=FALSE, color="black") +
    theme_classic() +
    labs(title="", x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.25)) +
    theme(axis.title.x = element_text(size=10,vjust=0),
          axis.text.x  = element_text(size=8,color="black"),
          axis.title.y = element_text(size=10,vjust=3),
          axis.text.y  = element_text(size=8,color="black")) 
  
  dev.off()
  
  #add them all to 1 figure!
  
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
  
  grid.arrange(hatchlingmass1, hatchlingsvl1, bodycondition1, ncol = 1)
  
  dev.off()
