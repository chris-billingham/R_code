## app.R ##
library(shiny)
library(shinydashboard)

function(request) { 
  dashboardPage(
    dashboardHeader(title = "Basic dashboard"),
    dashboardSidebar(collapsed = TRUE),
    dashboardBody(
      # Boxes need to be put in a row (or column)
      fluidRow(
        
        box(plotOutput("plot1", height = 250)
            ,tableOutput("contents")
            ,fileInput("file1", "Choose CSV File",
                      accept = c(
                        "text/csv",
                        "text/comma-separated-values,text/plain",
                        ".csv")
       
          
            )),
        
        box(
          title = "Controls",
          sliderInput("slider", "Number of observations:", 1, 100, 50),
          bookmarkButton('Story_ID')
        )
      )
    )
  )
}

function(input, output,session) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  output$contents <- renderTable({  
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath)
    
    
    }) 
  
}

#enableBookmarking(store = "url")
#shinyApp(ui, server)
