
set.seed(95)
m = 500
minn=100
maxnn=5000
lambda = 4.29
mean0=rep(0,m)
amplitude=rep(0,m)
amplitudemean=rep(minn-1,maxnn)

for(n in minn:maxnn){
	for (i in 1:m){
  		mean0[i]= mean(rexp(n,lambda))
		s=mean0[i]
		amplitude[i] <- qt(.995,df=n-1)*s/sqrt(n)
	}
	amplitudemean[n]=mean(amplitude)
	print(n)
	print(amplitudemean[n])
}
df.amplitudemean=as.data.frame(amplitudemean)

