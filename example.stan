data{
int y[100];}
parameters{
real<lower=0,upper=1> theta;
}
model{
for(i in 1:100){
y[i]~bernoulli(theta);
}
theta~beta(2,5);
}


