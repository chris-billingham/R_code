
#https://bookdown.org/yihui/blogdown/

#https://themes.gohugo.io/

#https://www.netlify.com/


#install.packages('blogdown')

library(blogdown)

blogdown::install_hugo()

getwd()

setwd('C:/Users/tduan/Desktop/Mission/R/Blogdown/Bdown001')
blogdown::new_site()




library(readxl)
library(plotly)
excel_df1=read_xlsx("./static/Book1.xlsx", 1)            
excel_df1

p <- plot_ly(excel_df1, x = ~year ,y = ~Shanghai, type = 'scatter', mode = 'lines')%>%
  add_trace(y = ~Beijing,name='Beijing',mode = 'lines')%>%
  add_trace(y = ~ Guangzhou, name='Guangzhou',mode = 'lines')%>%
  add_trace(y = ~ Shenzhen,name='Shenzhen', mode = 'lines')%>%
  add_trace(y = ~ Tianjin, name='Tianjin',mode = 'lines')%>%
  add_trace(y = ~ Chongqing, name='Chongqing',mode = 'lines')%>%
  layout(title = "China Top cities GDP",
         xaxis = list(title = "year"),
         yaxis = list (title = "GDP in 100M RMB"))
p
