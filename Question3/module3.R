#install required libraries, I've been using the Netherlands CRAN mirror,
#install.packages("rJava")
#install.packages("ggplot2")
#install.packages("xlsxjars")
#install.packages("xlsx")
#install.packages("tidyr")
#install.packages("tidyverse")
#Link libraries
library("rJava")
library("ggplot2")
library("xlsxjars")
library("xlsx")
library("tidyr")
library("dplyr")
library("tidyverse")

data1 <- read.xlsx2('QualidadeARO3.xlsx',  sheetIndex = 1, startRow =1  , endRow = 8785) #Read the data section of the first sheet
filtereddata = subset(data1, select = c(Estarreja,Mem.Martins))
print(filtereddata)
filtereddata[] <- lapply(filtereddata, as.numeric)
Estarreja <- as.data.frame(table(filtereddata$Estarreja))
Estarreja  <- cbind(Estarreja, zona="Estarreja") #identify data frame in order to union
Mem.Martins <- as.data.frame(table(filtereddata$Mem.Martins))
Mem.Martins  <- cbind(Mem.Martins, zona="Mem.Martins")
compactdata  <- union(Estarreja,Mem.Martins)#union into a single dataframe
print(compactdata)
colnames(compactdata)=c("OzoneLevel","Occurences","Região")
compactdata$OzoneLevel <- as.numeric(as.character(compactdata$OzoneLevel))
print(compactdata)
plot <- ggplot(compactdata, aes(OzoneLevel,Occurences, color=Região, fill=Região))+ylim(0,200)
plot <- plot + geom_bar(stat="identity") #we have effectivelly treated our data as if it were a histogram so we can plot it in a geom_bar
plot <- plot + ggtitle("Número de ocorrências por nível de Ozono em Estarreja e Mem-Martins") + ylab ("Número de ocorrências")+xlab("Nível de Ozono") #add title and rename y axis
print(plot) #display plot

ggsave("module3.png", plot = plot, device=png) #save plot
