

library(dplyr)


################   temple    #################
#library(shiny)
#ui
#ui=fluidPage("hello world")

#server
#server=function(input,output){}

#run
#shinyApp(ui=ui,server = server)

###################   a+b=z shiny app ##############
library(shiny)
#ui
ui=fluidPage(titlePanel("Hello Shiny!"),                                                   # title 
             sidebarLayout(                                                                # type of layout
               sidebarPanel(                                                               # left side panel
                 numericInput(inputId = 'a','first number',0),                             # numericInput into a and defalt is 0 
                 numericInput(inputId = 'b','second number',0),                            # numericInput into b and defalt is 0 
                 sliderInput(inputId = 'c','third number',min = 1,max = 50,value = 30),    # numericInput into c and defalt is 30
                 checkboxInput(inputId ='d','add 10',FALSE),                               # 1/0 into d and defalt is 0 
                 dateInput(inputId='e', 'input date','2017-01-01'),                        # date input to e
                 dateRangeInput('f',label = 'Date range input: yyyy-mm-dd',                # date range to f
                                start = Sys.Date() - 2, end = Sys.Date() + 2),
                 selectInput('g',label='select cyl',c(999,unique(mtcars$cyl)))                    # selectInput to g
               ),
               mainPanel(                                        # right main panel
                 textOutput('z1'),                                   # output  z1
                 verbatimTextOutput("z2"),                        #  output  z2
                 verbatimTextOutput("z3"),                        #  output  z3
                 tableOutput("z4"),                                #  output table  z4
                 plotOutput('z5')                                   # output chart z5
               )
             )
)

#server
server=function(input,output){ 
  output$z1=renderText({input$a+input$b+input$c+input$d*10})           # output  number (z1 =a+b+c+d) as text 
  output$z2=renderText({as.character(input$e)})                         # output date z2 as text
  output$z3=renderText({as.character(input$f)})                         # output date z3 as text
  output$z4=renderTable({mtcars%>%filter(cyl==input$g)})                # output date z4 as table
  output$z5=renderPlot({ggplot(mtcars%>%filter(cyl==input$g),aes(mpg,wt))+geom_point()})                # output date z4 as table
}

#run
shinyApp(ui=ui,server = server)

##################################################################################


glimpse(mtcars)

###################  one way reactive  shiny app ##############
library(shiny)
library(ggplot2)
#ui
ui=fluidPage(titlePanel("Hello Shiny!"),                                                   # title 
             sidebarLayout(                                                                # type of layout
               sidebarPanel(                                                               # left side panel
                 numericInput(inputId = 'a','first number',0),                             # numericInput into a and defalt is 0 
                 numericInput(inputId = 'b','second number',0),                            # numericInput into b and defalt is 0 
                 sliderInput(inputId = 'c','third number',min = 1,max = 50,value = 30),    # sliderInput into c and defalt is 30
                 checkboxInput(inputId ='d','add 10',FALSE),                               # 1/0 into d and defalt is 0 
                 dateInput(inputId='e', 'input date','2017-01-01'),                        # date input to e
                 dateRangeInput('f',label = 'Date range input: yyyy-mm-dd',                # date range to f
                                start = Sys.Date() - 2, end = Sys.Date() + 2),
                 selectInput('g',label='select cyl',c(999,unique(mtcars$cyl))),                    # selectInput cyl to g
                 sliderInput('h',label='select hp', min(mtcars$hp),max(mtcars$hp),median(mtcars$hp)),    # sliderInput hp to h
                 radioButtons('i',label='choose vs',unique(mtcars$vs))         # radioButtons vs to i
               ),
               mainPanel(                                        # right main panel
                 textOutput('z1'),                                   # output  z1
                 verbatimTextOutput("z2"),                        #  output  z2
                 verbatimTextOutput("z3"),                        #  output  z3
                 tableOutput("z4"),                                #  output table  z4
                 plotOutput('z5'),                                   # output chart z5
                 verbatimTextOutput('z6') ,                       # output summary z6
                 tableOutput('z7')                        # output head data z7
               )
             )
)

#server
server=function(input,output){
  
  data001=reactive({mtcars%>%filter(vs==input$i)})
  
  
  output$z1=renderText({input$a+input$b+input$c+input$d*10})           # output  number (z1 =a+b+c+d) as text 
  output$z2=renderText({as.character(input$e)})                         # output date to z2 as text
  output$z3=renderText({as.character(input$f)})                         # output date to z3 as text
  output$z4=renderTable({mtcars%>%filter(cyl==input$g)})                # output date to z4 as table
  output$z5=renderPlot({ggplot(mtcars%>%filter(cyl==input$g),aes(mpg,wt))+geom_point()})     # output date z4 as table
  output$z6=renderPrint({summary(data001())})                           #output summary to z6 as print
  output$z7=renderTable({head(data001())})                             #output head to z7 as print
  }

#run
shinyApp(ui=ui,server = server)

##################################################################################


