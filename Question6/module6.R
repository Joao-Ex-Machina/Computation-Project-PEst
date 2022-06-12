install.packages("ggplot2") #Install package
install.packages("cowplot")
library("ggplot2") #Link library
library("cowplot")
#---------------------------------------------------------------------------------------------------------------+
# Name: gen.observations                                                                                        |
# Input: four integers(n, a [lbound], b[ubound] parameters of Uniform Distribution), number of observations (sz)|
# Output: one plot (means of calculated Uniform Distributions)                                                  |
# Definition:Generate sz number of Uniform distributions, calculate mean of said observations                   |
#---------------------------------------------------------------------------------------------------------------+
gen.observations<-function(n, sz, lbound, ubound){
	data0=rep(0,sz)
	mean0=rep(0,sz)
	for(i in 1:sz){
		data0=runif(n, min = lbound, max = ubound)
		mean0[i]=mean(data0)
		
	}
	meanX=as.data.frame(mean0)
	print(meanX)
	#Theoretical values calculation sequence
	expected.value=(lbound+ubound)/2 #Expected value of a Uniform distribution
	variance=(ubound-lbound)^2/12 #Uniform distribution
	variance.n=variance/n
	if(n==3){ #choose colour
		filler="#CD0000"
	}else if(n==23){
		filler="#511190"
	}
	else if(n==77){
		filler="#13AAAA"
	}
	plot <- ggplot(meanX)
	plot <- plot + geom_histogram(aes(x=mean0 ,y=..density..),colour=1, fill=filler, bins=20)
	plot <- plot + stat_function(fun=dnorm, args=list(mean=expected.value,sd=sqrt(variance.n))) #create a normal distribution curve with expected value and sqrt(variance/n) parameters in order to compare with the generated uniform distributions
	plot <- plot + ggtitle("Frequência relativa associado aos valores obtidos da média da distribuição com",bquote(list(n==.(n)))) + ylab("Densidade da distribuição") + xlab("Média da Distribuição Uniforme") #add title and rename y axis
	return(plot)
}

#Specific parameters
sz= 1790
lbound=6
ubound=10
set.seed(1283)

#n=3 Sequence
plot3=gen.observations(3,sz,lbound,ubound)

#n=23 Sequence
plot23=gen.observations(23,sz,lbound,ubound)

#n=77 Sequence
plot77=gen.observations(77,sz,lbound,ubound)

super.plot=plot_grid(plot3, plot23, plot77, nrow=1, ncol=3) #grid all plots
ggsave("module6.png", plot = super.plot, device=png, width=21) #save super.plot
