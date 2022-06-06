
set.seed(299)
for (i in 1:4180)
{
  z = rbinom(152,38,0.09)
  
  y = mean(z)
  if (i == 1)
    x = y
  else
    x = c(x,y)
}
x = mean(x)
E_teor = 38*0.09

print(x - E_teor)
