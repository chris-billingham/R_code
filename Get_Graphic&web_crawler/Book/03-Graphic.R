# Graphic

## Base

## ggplot


#################qplot#############
library(ggplot2)
head(mpg)

#Scatter
qplot(displ,hwy,data=mpg)
qplot(displ,hwy,data=mpg,color=drv)
qplot(displ,hwy,data=mpg,shape=drv)

#Scatter and line
qplot(displ,hwy,data=mpg,geom=c('point','smooth'))

### Histogram
qplot(hwy,data=mpg)
qplot(hwy,data=mpg,fill=drv)

#facets
qplot(hwy,data=mpg,facets = .~drv,binwidth=2)

qplot(displ,hwy,data=mpg,facets = .~drv)



############# ggplot #################################
http://tutorials.iq.harvard.edu/R/Rgraphics/Rgraphics.html

g=ggplot(mpg,aes(displ,hwy))
summary(g)

#Scatter
g+geom_point()



glimpse(mpg)
tail(mpg)

#Scatter and line

### Histogram






## plotly

## bokeh



