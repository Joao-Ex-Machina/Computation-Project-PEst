#install.packages("ggplot2") #Install packages, using Netherlands CRAN mirror
#install.packages("dplyr")
library("dplyr")
library("ggplot2") #Link library
set.seed(341)
m = 800
minn=100
maxnn=2500
lambda = 5.54
lambdac= 0.51
alpha=0.001
alphapercentile=alpha/2 #1-alpha=0.999 therefore we can be assure we are in the 99.5 th percentile
mean0=rep(0,m)
amplitude=rep(0,m)
amplitudemean=rep(0, 25)
cmean0=rep(0,m)
camplitude=rep(0,m)
camplitudemean=rep(0, 25)
ninterval=seq(from = minn, to= maxnn, by =100)
for(n in ninterval){
	for (i in 1:m){ #generate regular observations
		normal=rexp(n,lambda)
		fullycontaminated=rexp(n,lambdac)
		partialcontaminated=normal
		for(a in 1:n*0.15){
			partialcontaminated[a]=fullycontaminated[a]	
		}
	
		mean0[i]=mean(normal)
                cmean0[i]=mean(partialcontaminated)
	}
	s=mean0
	cs=cmean0
        amplitude <- qt(1-alphapercentile,df=n-1)/(s*sqrt(n))
	camplitude <- qt(1-alphapercentile,df=n-1)/(cs*sqrt(n))
	amplitudemean[n/100]=mean(amplitude)
	camplitudemean[n/100]=mean(camplitude)
	print(n) #Added in order to be sure the script was indeed running
	print(amplitudemean[n/100])
}

df.amplitudemean <- as.data.frame(amplitudemean)
print(df.amplitudemean)
df.amplitudemean  <- cbind(df.amplitudemean, Contaminação="Não Contaminado") #label dataframe
df.amplitudemean  <- cbind(df.amplitudemean, n=ninterval)
df.camplitudemean <- as.data.frame(camplitudemean)
print(df.camplitudemean)
df.camplitudemean  <- cbind(df.camplitudemean, Contaminação="Contaminado")
df.camplitudemean  <- cbind(df.camplitudemean, n=ninterval)
print(df.camplitudemean)
colnames(df.camplitudemean)=c("amplitudemean","Contaminação", "n")
print(df.camplitudemean)
print(df.amplitudemean)
df.compact <- union(df.amplitudemean, df.camplitudemean) 
print(df.compact)
plot <- ggplot(df.compact, aes(x=n, y=amplitudemean, colour=Contaminação))
plot <- plot + geom_point()+stat_smooth(method="auto", se=FALSE, fullrange=TRUE)
plot <- plot + ggtitle("Média das amplitudes dos intervalos de confiança das 800 observações em função de n") + ylab("Média das Amplitudes dos intervalos de confiança obtidos") + xlab("Dimensão das amostras (n)") #add title and rename y and x axis
print(plot)
ggsave("module10.png", plot = plot, device=png, width=14) #save plot
