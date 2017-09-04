library(shiny)
library(plotly)
setwd('C:/Users/User/Desktop/Mission/R/R_code/interactive infographic/Shiny')
getwd()


ui=shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Hello Shiny!"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    dateInput("date", label = h3("Date input"), value = "2014-01-01"),
    selectInput("dataset", "Choose a dataset:", 
                choices = unique(c$set))
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Plot",br(),
    plotlyOutput("plot001", width = "100%", height = "300px"),
    br(),
    br(),
    plotlyOutput("plot002", width = "100%", height = "300px"),
    verbatimTextOutput("event")
    ),
    tabPanel("Opt-in"),
    tabPanel("whitelist"),
    tabPanel("video",tags$iframe(src = "https://www.youtube.com/embed/H2xaRA-rUnE"))
   
    )
  )
))



