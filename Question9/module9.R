install.packages("ggplot2") #Install packages, using Netherlands CRAN mirror
library("ggplot2") #Link library
set.seed(95)
m = 500
minn=100
maxnn=5000
lambda = 4.29
alpha=0.01
alphapercentile=alpha/2 #1-alpha=0.99 therefore we can be assure we are in the 99.5 th percentile
mean0=rep(0,m)
amplitude=rep(0,m)
amplitudemean=rep(0, 50)
ninterval=seq(from = minn, to= maxnn, by =100)
for(n in ninterval){
	for (i in 1:m){
  		mean0[i]= mean(rexp(n,lambda))
		s=mean0[i]
		amplitude[i] <- qt(1-alphapercentile,df=n-1)/(s*sqrt(n))
	}
	amplitudemean[n/100]=mean(amplitude)
	print(n) #Added in order to be sure the script was indeed running
	print(amplitudemean[n/100])
}

df.amplitudemean=as.data.frame(amplitudemean)
print(df.amplitudemean)
plot <- ggplot(df.amplitudemean, aes(x=ninterval, y=amplitudemean))
plot <- plot + geom_point(colour=1, fill="#CD0000")+geom_smooth(method="auto", se=FALSE)
plot <- plot + ggtitle("Média das amplitudes dos intervalos de confiança das 500 observações em função de n") + ylab("Média das Amplitudes dos intervalos de confiança obtidos") + xlab("Dimensão das amostras (n)") #add title and rename y and x axis
ggsave("module9.png", plot = plot, device=png, width=14) #save plot
