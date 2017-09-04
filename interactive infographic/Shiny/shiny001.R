
# https://shiny.rstudio.com/tutorial/
# https://rstudio.github.io/shiny/tutorial/
# http://deanattali.com/blog/building-shiny-apps-tutorial/
# https://www.youtube.com/watch?v=_0ORRJqctHE


# https://www.youtube.com/watch?v=0rjS-_rWrJ0
# https://www.youtube.com/watch?v=J_rQOYRy0SM
# https://www.youtube.com/watch?v=cDdDMYKS6HY
# https://www.youtube.com/watch?v=Ensx1gEXYY8


#uber movement
#https://www.youtube.com/watch?v=yqs2wqBoPPU

#install.packages('formattable')
library(shiny)
library(plotly)
library(dplyr)
library(formattable)
setwd('C:/Users/User/Desktop/Mission/R/R_code/interactive infographic/Shiny')
getwd()

a=data.frame(set=c('a','a','a'),city=c('tw','hk','cn'),gmv=c(30,10,1),rate=c(0.5,0.2,0.5),good=c(15,2,0.5),share=c(0.7,0.2,0.1))
a$gmv2=a$gmv-a$good
a$rate=as.character(percent(a$rate,0))
a$share2=paste(a$share,' of GMV share',sep='')

a
b=data.frame(set=c('b','b'),city=c('tw2','hk3'),gmv=c(40,14),rate=c(0.5,0.2),good=c(15,2),share=c(0.75,0.15))
b$gmv2=b$gmv-b$good
b$rate=as.character(percent(b$rate,0))
b$share2=paste(b$share,' of GMV share',sep='')
c=rbind(a,b)
c



###########################################
library(shiny)
shinyApp(
  ui = fluidPage(titlePanel("Title"),
                 mainPanel(htmlOutput("video"))),
  server = function(input, output, session) {
    output$video <- renderUI({
      tags$iframe(src = "https://www.baidu.com")
    })
  }
)

