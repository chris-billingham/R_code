library(shiny)
library(ggplot2)
library(plotly)

ui <- fluidPage(
  
  # App title ----
  titlePanel("GYM!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      h1("this is the GYM workout tracking!"),
      h2("this is the GYM workout tracking!")   
      ##########################################################
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      tabsetPanel(
        tabPanel("Plot",plotlyOutput("plot001")),
        tabPanel("Summary"),
        tabPanel("Table",tableOutput("data001")),
        tabPanel("TEST")
      )

      
    )
  )
)