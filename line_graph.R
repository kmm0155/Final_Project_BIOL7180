# This script will be used as a piece of the whole, but is for the creation of a 3-D Line Graph in GGplot within R.
# This script is also set up to be ran individually if desired

# Set working directory and where to save your graph
setwd("/home/aubcls98/Final_Project_BIOL7180")

# Installing GGplot if needed
print("Do you have GGplot previously installed? (Y/N)")
response1 = select.list(c("Y","N"), preselect=NULL, multiple=FALSE)
if (response1=="N") {install.packages('ggplot2')}

# Open GGplot
library(ggplot2)

# Upload your CSV file containing data
datum=read.csv(file.choose()))

# View data to make sure it was uploaded correctly 
head(datum)


# Choose output type
cat("Choose which graph and file type you would like:
    3-1: line graph, tiff
    3-2: line graph, png
    3-3: line graph, jpg \n")
response2 = select.list(c("3-1", "3-2", "3-3"), preselect=NULL, multiple=FALSE)


# Using GGplot, add the data and axes to the graph
# data= the variable name that you chose for your data (datum)
# aes= the names of the columns that your data is in
# labs= where you title your graph and each axis
# theme= where you specify your font sizes and color

# First graph selection is 3-1- line graph with tiff output
if (response2 == "3-1") {
Line_Graph = ggplot() +
    geom_line(data=datum, aes(x=EGGMASS,y=SVL)) +
    theme_minimal() +
    labs(title="",x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.0)) +
ggsave(file="line_graph.tiff")
}

# Second graph selection is 3-2- line graph with png output
if (response2 == "3-2") {
Line_Graph = ggplot() +
    geom_line(data=datum, aes(x=EGGMASS,y=SVL)) +
    theme_minimal() +
    labs(title="",x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.0)) +
ggsave(file="line_graph.png")
}

# Third graph selection is 3-3- line graph with jpeg output
if (response2 == "3-3") {
Line_Graph = ggplot() +
    geom_line(data=datum, aes(x=EGGMASS,y=SVL)) +
    theme_minimal() +
    labs(title="",x="Egg mass (g) at oviposition", y="Hatchling SVL (mm)") +
    scale_x_continuous(breaks=seq(0.85,1.25,0.05), limits=c(0.85,1.0)) +
ggsave(file="line_graph.jpg")
}

# Turn off the graphing device
dev.off()
