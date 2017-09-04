library(shiny)
library(plotly)
library(formattable)
setwd('C:/Users/User/Desktop/Mission/R/R_code/interactive infographic/Shiny')
getwd()








server <- function(input, output) {
  
  datasetInput <- reactive({
    switch(input$dataset,
           "a" = a,
           "b" = b
           )
  })
  
  
  # renderPlotly() also understands ggplot2 objects!
  output$plot001 <- renderPlotly({
    plot_ly(datasetInput(), x = ~gmv2, y = ~city, type = 'bar', name = 'gmv',orientation = 'h'
      ) %>%
      add_trace(x=~good,y = ~city, name = 'good',orientation = 'h',text=~rate,textposition='inside'
                ) %>%
      layout(
        title='EGD',
        xaxis = list(title = 'USD'),
        yaxis = list(title = 'City'), 
        barmode = 'stack'
      )
  })
    output$plot002 <- renderPlotly({
      plot_ly(datasetInput(), x = ~gmv2, y = ~city, type = 'bar', name = 'gmv',orientation = 'h'
      ) %>%
        add_trace(x=~good,y = ~city, name = 'good',orientation = 'h',text=~rate,textposition='inside'
        ) %>%
        layout(
          title='GMV',
          xaxis = list(title = 'USD'),
          yaxis = list(title = 'City'), 
          barmode = 'stack'
        )
  
  })
  
  #output$event <- renderPrint({
  #  d <- event_data("plotly_hover")
  #  if (is.null(d)) "Hover on a point!" else d
  #})
}

shinyApp(ui, server)

#plotly_example("shiny", "event_data")

