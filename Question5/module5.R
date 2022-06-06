observations=110
filteredobs<- 0
set.seed(1672)
experimentalsetup=rexp(observations, 0.16)
for (i in 1:observations){
	if(experimentalsetup[i]>3) filteredobs = filteredobs +1
}
experimental = filteredobs/observations

theoretical = 1-pexp(3, 0.16)
answer= theoretical - experimental
print(answer)


