#install required libraries, I've been using the Netherlands CRAN mirror,
install.packages("rJava")
install.packages("ggplot2")
install.packages("xlsxjars")
install.packages("xlsx")
install.packages("tidyr")

#Link libraries
library("rJava")
library("ggplot2")
library("xlsxjars")
library("xlsx")
library("tidyr")


data1 <- read.xlsx2('ResiduosPerCapita.xlsx',  sheetIndex = 1, startRow = 12 , endRow = 43) #Read the data section of the first sheet from ResiduosPerCapita.xlsx

colnames(data1) <- c("Países","2004","2008") #rename data frame colummns for easier comprehension

filtereddata <- subset(data1, Países=="LV - Letónia" | Países=="EE - Estónia"| Países=="SE - Suécia") #filter dataframe in order to only have the required countries

plotdata <- gather(filtereddata,Ano,ResiduosPerCapita, 2:3) #convert make the year (2004 or 2008) a new variable stored in the Ano colummn, transfer contents of old 2004 and 2008 colummns into a new variable stored in ResiduosPerCapita, making it easier to plot without using fill 

#Start the graph plotting sequence
#based on: https://rpubs.com/dvdunne/ggplot_two_bars

plot <- ggplot(plotdata, aes(Países, ResiduosPerCapita, fill=Ano))
plot <- plot + geom_bar(stat = "identity", position = 'dodge')
plot <- plot + ggtitle("Resíduos per capita em toneladas na Letónia, Estónia e Suécia em 2004 e 2008") + ylab ("Resíduos per capita / toneladas") #add title and rename y axis
print(plot) #display plot


ggsave("module1.png", plot = plot, device=png) #save plot


