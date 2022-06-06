#install required libraries, I've been using the Netherlands CRAN mirror,
#Uncomment if needed
#install.packages("rJava")
#install.packages("ggplot2")
#install.packages("xlsxjars")
#install.packages("xlsx")
#install.packages("tidyr")

#Link libraries
library("rJava")
library("ggplot2")
library("xlsxjars")
library("xlsx")
library("tidyr")


data1 <- read.xlsx2('Utentes.xlsx',  sheetIndex = 1, startRow = 1 , endRow = 77) #Read the data section of the first sheet from ResiduosPerCapita.xlsx
filtereddata = subset(data1, select = c(IMC,TAD))
filtereddata$IMC <- as.numeric(as.character(filtereddata$IMC)) #convert parasite strings into numeric values
filtereddata$TAD <- as.numeric(as.character(filtereddata$TAD))

#Start plotting sequence
plot <- ggplot(filtereddata, aes(IMC,TAD))
plot <- plot + geom_point()+geom_smooth(method="auto", se=FALSE)
plot <- plot + ggtitle("Tensão Arterial Diastólica em função do Índice de massa corporal em 76 utentes") + ylab ("Tensão Arterial Diastólica / mmHg") + xlab("Índice de Massa Corporal/ kg/m²") #add title and rename y and x axis
print(plot) #display plot


ggsave("module4.png", plot = plot, device=png) #save plot

