N <- 5000000
x <- rnorm(N,0,1)
x.df <- data.frame(val=x)
x.df$group <- factor(ifelse(x.df$val<1.96,1,2))

library(ggplot2)
g <- ggplot(data=x.df,aes(x=val,group=group,fill=group))
g <- g + geom_histogram(binwidth=0.05)
g
