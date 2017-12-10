library(shiny)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  #############   data001 
  output$data001=renderTable(track_data_001)
  ############    plot001
  output$plot001=renderPlotly(
{
  g=ggplot(data=track_data_001, aes(date, weight)) + geom_line()
  p=ggplotly(g)
  p
        
  })
  ###########################################################
}



  
