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

data1 <- read.xlsx2('EsperancaVida.xlsx',  sheetIndex = 1, startRow = 8 , endRow = 70) #Read the data section of the first sheet
names(data1)[1] <- "Anos"
filtereddata <- subset(data1, Anos>2001 & Anos<2020 | Anos=="") #filter dataframe in order to only have the required years
filtereddata = subset(filtereddata, select = -c(Total))
print(filtereddata)
yeardata  = subset(filtereddata, select = c(Anos))
filtereddata <- filtereddata[,(filtereddata[1,]=="FI - Finlândia" |filtereddata[1,]=="LT - Lituânia" |filtereddata[1,]=="IE - Irlanda")] 
filtereddata$Anos  <- yeardata$Anos
filtereddata <- filtereddata[-c(1),]
filtereddata = subset(filtereddata, select = -c(X..14)) #remove parasitic Total
filtereddata = subset(filtereddata, select = -c(X..18))
filtereddata = subset(filtereddata, select = -c(X..21))
colnames(filtereddata)=c("Finlândia_Homens","Irlanda_Homens","Lituânia_Homens","Finlândia_Mulheres","Irlanda_Mulheres","Lituânia_Mulheres", "Anos")
filtereddata[] <- lapply(filtereddata, as.numeric)
print(filtereddata)
plot <- ggplot(filtereddata, aes(x=Anos))
plot <- plot+ scale_colour_manual("", 
                      breaks = c("Finlândia-Homens", "Finlândia-Mulheres", "Irlanda-Homens", "Irlanda-Mulheres","Lituânia-Homens","Lituânia-Mulheres"),
                      values = c("Finlândia-Homens"="blue", "Finlândia-Mulheres"="grey", "Irlanda-Homens"="green", "Irlanda-Mulheres"="orange","Lituânia-Homens"="red","Lituânia-Mulheres"="yellow"))
plot  <-plot + geom_line(aes(y=Finlândia_Homens, colour="Finlândia-Homens")) + geom_line(aes(y=Finlândia_Mulheres, colour="Finlândia-Mulheres"))
plot  <-plot + geom_line(aes(y=Irlanda_Homens, colour="Irlanda-Homens")) + geom_line(aes(y=Irlanda_Mulheres, colour="Irlanda-Mulheres"))
plot  <-plot + geom_line(aes(y=Lituânia_Homens, colour="Lituânia-Homens")) + geom_line(aes(y=Lituânia_Mulheres, colour="Lituânia-Mulheres"))
plot <- plot + ggtitle("Esperança média de vida, por país, entre 2002 e 2019") + ylab("Esperança média de vida") + xlab("Anos")
print(plot)
ggsave("module2.png", plot = plot, device=png, width=14) #save plo

