set.seed(416)
m = 1450
n = 579
lambda = 1.89
data0 = 0
for (i in 1:m){
  data0[i] = mean(rexp(n,lambda))
}
gama = 0.999 
data1 = qnorm((1+gama)/2)
amplitude = (2*data1)/(data0*sqrt(n))
result = mean(amplitude)
print(result)
