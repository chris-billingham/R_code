
#https://rstudio.github.io/shinydashboard/get_started.html
#https://www.youtube.com/watch?v=fUXBL5bk20M&list=PLH6mU1kedUy-aGYi-w1XqSiGtViFK9NpI&index=7


#Video
#Building Dashboards with Shiny – Tutorial
#https://www.rstudio.com/resources/videos/building-dashboards-with-shiny-tutorial/


#Dynamic Dashboards with Shiny
#https://www.rstudio.com/resources/webinars/dynamic-dashboards-with-shiny/


##########  package ################

#install.packages("shinydashboard")
#install.packages("FSA")


#remove.packages("RtutoR")

library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(dplyr)
library(readxl)
library(writexl)
library(RtutoR)
library(FSA)
#source('generate_ppt.R')

getwd()
#setwd("C:/Users/User/Desktop/Mission/R/R_code/Shinydashboard")
#########      ui      ##########################
ui <-function(request){dashboardPage(
  
dashboardHeader(title = "BM001 dashboard" )
##########################################################
                    
##########   side bar ######################################  
,dashboardSidebar(
    collapsed = TRUE,
    sidebarMenu(
      #############  side tab 1 
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      #############  side tab 2 
      menuItem("Widgets", icon = icon("th"), tabName = "widgets",
               badgeLabel = "new", badgeColor = "green"),
      #############  side tab 3
      menuItem("Source code", icon = icon("file-code-o"), 
               href = "https://github.com/rstudio/shinydashboard/")
      
      
    )
  )
###############  body #################################################
,dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("plot1", height = 250)
                    ,plotlyOutput("plot2", height = 250)
                    ,bookmarkButton()
                    ,actionButton("goButton", "Go!")
                    , fileInput("file1", "Choose CSV File",
                                  multiple = TRUE,
                                  accept = c("text/csv",
                                             "text/comma-separated-values,text/plain",
                                             ".xlsx",
                                             ".csv"))
                    
                    ,tableOutput("table001")
                )
                
                ,box(
                  title = "Controls"
                  ,sliderInput("slider", "Number of observations:", 1, 100, 50)
                  ,downloadButton('downloadData', 'Download')
                  ,downloadButton('downloadData2', label = 'Downloading ppt')
                  ,uiOutput("varselect")
                  ,textOutput("value")
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "widgets",
              h2("Widgets tab content")
      )
    )
)
)}

  
  
######   server ###############################
server <- function(input, output) {
  
    
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  output$plot2 <- renderPlotly({
    p <- plot_ly(x = ~rnorm(50), type = "histogram")
  })
  
  data001=reactive({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read_xlsx(inFile$datapath)
    
    
  })
  
  
  data002=reactive({
    df1 <- data.frame(
      A = 1:5, Source = "df1",
      stringsAsFactors = FALSE)
  })
  
  output$table001 <- renderTable({
 head(data001())
  })
  
  
  
  output$varselect <- renderUI({
    selectInput("variablex", "Select the First (X) variable", choices = names(data001()))
  })
  
  output$value <- renderText({
    paste("target is :",input$variablex)
  })
  
  observeEvent(input$goButton, {
    res = generate_exploratory_analysis_ppt(data001(),target_var = input$variablex,
                                            output_file_name = "aaa.pptx")
  })
  
  
  
  output$downloadOverall <- downloadHandler(
    filename = function() { "ACCT_INFO.xlsx" },
    content = function(file) {
      
      tempFile <- tempfile(fileext = ".xlsx")
      write_xlsx(data002(), tempFile)
      file.rename(tempFile, file)
      
    } ) 
  
  
  output$downloadData2 <- downloadHandler(
   
    #content <- function(file) {
    #tempFile <- tempfile(fileext = ".pptx")
    #file.copy("aaa.pptx", file)
    #file.copy("aaa.pptx", file)
    #file.rename("PPT","ACCT_INFO.pptx" ) 
    #},filename = function(file)  { "ACCT_INFO.pptx"}
    
    filename <- function() {
      paste("output", "zip", sep=".")
    },
    
    content <- function(file) {
      file.copy("df.zip", file)
      file.rename("output.zip" ) 
    },
    contentType = "application/zip"
    
    
    
    
  )
    
   

  
  
  ##########################################
}
 
 
######  run ########################
enableBookmarking(store = "url")
shinyApp(ui, server)
 