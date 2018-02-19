
#https://rstudio.github.io/shinydashboard/get_started.html
#https://www.youtube.com/watch?v=fUXBL5bk20M&list=PLH6mU1kedUy-aGYi-w1XqSiGtViFK9NpI&index=7
#https://www.rstudio.com/resources/webinars/dynamic-dashboards-with-shiny/


##########  package ################

#install.packages("shinydashboard")

library(shiny)
library(shinydashboard)

#########      ui      ##########################

header <-dashboardHeader(title = "BM001 dashboard",
                         ######################################   messages menus
                         dropdownMenu(type = "messages",
                                      messageItem(
                                        from = "Sales Dept",
                                        message = "Sales are steady this month."
                                      ),
                                      messageItem(
                                        from = "New User",
                                        message = "How do I register?",
                                        icon = icon("question"),
                                        time = "13:45"
                                      ),
                                      messageItem(
                                        from = "Support",
                                        message = "The new server is ready.",
                                        icon = icon("life-ring"),
                                        time = "2014-12-01"
                                      )
                         ),
                         
                         
                         ######################################   Notification menus
                         dropdownMenu(type = "notifications",
                                      notificationItem(
                                        text = "5 new users today",
                                        icon("users")
                                      ),
                                      notificationItem(
                                        text = "12 items delivered",
                                        icon("truck"),
                                        status = "success"
                                      ),
                                      notificationItem(
                                        text = "Server load at 86%",
                                        icon = icon("exclamation-triangle"),
                                        status = "warning"
                                      )
                         ),           
                                            
                         ######################################   task menus     
                         dropdownMenu(type = "tasks", badgeStatus = "success",
                                      taskItem(value = 90, color = "green",
                                               "Documentation"
                                      ),
                                      taskItem(value = 17, color = "aqua",
                                               "Project X"
                                      ),
                                      taskItem(value = 75, color = "yellow",
                                               "Server deployment"
                                      ),
                                      taskItem(value = 80, color = "red",
                                               "Overall project"
                                      )
                         )
                         ####################################################
                         )
  
sidebar <- dashboardSidebar(
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
body <-dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "widgets",
              h2("Widgets tab content")
      )
    )
)

ui <-dashboardPage(header, sidebar, body)
  
  
######   server ###############################
server <- function(input, output) {
  
    
    

  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}
 
 
######  run ########################
shinyApp(ui, server)
 