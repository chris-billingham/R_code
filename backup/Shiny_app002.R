#install.packages("shiny")
library(shiny)
# https://www.youtube.com/watch?v=Ido56dwDTg8&list=PL9HYL-VRX0oTAHdR62i2YaLNmJhFiiwaO
ui="Hello World by Tony D 20170408"

ui=fluidPage(
  h1("Shiny Text"), 
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", 
        choices = ls("package:datasets"),
        selected="pressure")
    ),
    mainPanel(
      verbatimTextOutput("dump"),
      plotOutput("plot")
    )
  )
)


server=function(input,output,session){
  output$dump=renderPrint({
    dataset=get(input$dataset,"package:datasets",inherits = FALSE)
    str(dataset)
  }) 
  output$plot=renderPlot({
    dataset=get(input$dataset,"package:datasets",inherits = FALSE)
    plot(dataset)
  }) 
}


shinyApp(ui,server)
