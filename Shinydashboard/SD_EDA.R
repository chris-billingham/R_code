library(summarytools)
#install.packages("summarytools")
library(shiny)
library(shinydashboard)
library(datasets)
#width = 6,height = 500,
#####################  ui  
ui <- fluidPage(
  box(title='a',width = 3,height = "100%",
      tabsetPanel(type = "tabs"
      ,tabPanel(uiOutput("dfSummaryButton"),height = 300)
    )
  )
  ,box(title='b',width = 9,height = "100%",
      tabsetPanel(type = "tabs"
                  ,tabPanel(uiOutput("profileSummary"),height = 300)
                  #,tabPanel(includeHTML("C:/Users/User/AppData/Local/Temp/RtmpMPnyHV/file4b838e35a5.html"))
                  
      )         
  )

)


################# server 
server <- function(input, output, session) {
  #Read in data file
  recVal <- reactiveValues()
  dfdata <- iris
  
  #Create dfSummary Button
  output$dfSummaryButton <- renderUI({
    actionButton("dfsummarybutton", "Create dfSummary")
  })
  
  actionButton(inputId='ab1', label="Learn More", 
               icon = icon("th"), 
               onclick ="window.open('http://google.com', '_blank')")
  
  #Apply dfSummary Buttom
  #observeEvent(input$dfsummarybutton, {
  #  recVal$dfdata <- dfdata
  #})
  
  #dfSummary data
  observeEvent(input$dfsummarybutton, {
    
    bb <- view(dfSummary(iris),file='cc.html')  
  output$profileSummary <- renderUI({
    includeHTML("aa.html")
  })
  })
}

shinyApp(ui, server)


#############


