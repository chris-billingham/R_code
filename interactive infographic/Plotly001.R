# https://www.youtube.com/watch?v=v_kK5c0QUnU
# https://plotly-book.cpsievert.me/
#install.packages('plotly')
library(plotly)
library(dplyr)
setwd('C:/Users/User/Desktop/Mission/R/R_code/interactive infographic/')
getwd()

a=data.frame(city=c('tw','hk','cn'),gmv=c(30,10,1),rate=c(0.5,0.1,0.5),good=c(15,1,0.5),share=c(0.7,0.2,0.1))
a$gmv2=a$gmv-a$good
a002=a$city2=paste(a$city,' with ',as.character(a$share),' of GMV share',sep='')

#a$city <- factor(a$city, levels = c('cn','hk','tw'))


glimpse(mtcars)

############   Scatter plot ###########################  

plot_ly(mtcars,x=mtcars$wt,y=mtcars$mpg,mode='markers')

###########  Bar chart from summary data ###############


plot_ly(a, x = ~gmv2, y = ~city, type = 'bar', name = 'gmv',orientation = 'h'
             ) %>%
  add_trace(x=~good,y = ~city, name = 'good',orientation = 'h',text=~rate,textposition='auto') %>%
  add_text(x=~good,y = ~city,text=~share2,orientation = 'h',textposition='middle  right')%>%
  layout(
    title='GMV',
    xaxis = list(title = 'USD'),
    yaxis = list(title = 'City'), 
    barmode = 'stack'
    )



