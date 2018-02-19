
#https://rstudio.github.io/shinydashboard/get_started.html
#https://www.youtube.com/watch?v=fUXBL5bk20M&list=PLH6mU1kedUy-aGYi-w1XqSiGtViFK9NpI&index=7
#https://www.rstudio.com/resources/webinars/dynamic-dashboards-with-shiny/


##########  package ################

#install.packages("shinydashboard")

library(shiny)
library(shinydashboard)

########   ui ###########
ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
)
######    server #########
server <- function(input, output) { }

#####   run ##############
shinyApp(ui, server)







