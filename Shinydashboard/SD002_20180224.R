
#https://rstudio.github.io/shinydashboard/get_started.html
#https://www.youtube.com/watch?v=fUXBL5bk20M&list=PLH6mU1kedUy-aGYi-w1XqSiGtViFK9NpI&index=7


#Video
#Building Dashboards with Shiny – Tutorial
#https://www.rstudio.com/resources/videos/building-dashboards-with-shiny-tutorial/


#Dynamic Dashboards with Shiny
#https://www.rstudio.com/resources/webinars/dynamic-dashboards-with-shiny/


##########  package ################

#install.packages("shinydashboard")

library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(readxl)
library(writexl)
library(RtutoR)
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
                  ,downloadButton('PPT', 'Download_ppt')
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
    filename = function(file) {
      paste("samplefile.xlsx")
    },
    content = function(con) {
      write_xlsx(data002(), con)
    }
    ,contentType ='xlsx'
  ) 
  
  output$PPT <- downloadHandler(
    filename = function(file) {
      paste("aaa", "pptx", sep=".")
    },
    content <- function(file) {
    file.copy("aaa.pptx", file)
    },
    contentType = "pptx"
    
   
  ) 
  
  
  ##########################################
}
 
 
######  run ########################
enableBookmarking(store = "url")
shinyApp(ui, server)
 