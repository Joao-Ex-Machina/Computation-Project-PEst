#install required libraries, I've been using the Netherlands CRAN mirror,
#install.packages("rJava")
install.packages("libjvm")
install.packages("ggplot2")
install.packages("xlsxjars")
install.packages("xlsx")
install.packages("tidyr")
install.packages("tidyverse")
#Link libraries
library("rJava")
library("ggplot2")
library("xlsxjars")
library("xlsx")
library("tidyr")
library("dplyr")


data1 <- read.xlsx2('EsperancaVida.xlsx',  sheetIndex = 1, startRow = 8 , endRow = 70) #Read the data section of the first sheet
names(data1)[1] <- "Anos"
filtereddata <- subset(data1, Anos>2001 & Anos<2020 | Anos=="") #filter dataframe in order to only have the required years
filtereddata = subset(filtereddata, select = -c(Total))
print(filtereddata)

#plotdata <- gather(filtereddata,Ano,ResiduosPerCapita, 2:3) #convert make the year (2004 or 2008) a new variable stored in the Ano colummn, transfer contents of old 2004 and 2008 colummns into a new variable stored in ResiduosPerCapita, making it easier to plot without using fill 

#Start the graph plotting sequence
#based on: https://rpubs.com/dvdunne/ggplot_two_bars

#plot <- ggplot(plotdata, aes(Países, ResiduosPerCapita, fill=Ano))
#plot <- plot + geom_bar(stat = "identity", position = 'dodge')
#plot <- plot + ggtitle("Resíduos per capita em toneladas na Letónia, Estónia e Suécia em 2004 e 2008") + ylab ("Resíduos per capita / toneladas") #add title and rename y axis
#print(plot) #display plot


#ggsave("module2.png", plot = plot, device=png) #save plot


