library(shiny)
library(plotly)
library(shinydashboard)
ui <- function(request) {
  dashboardPage(
    dashboardHeader(title = "Test"),
    dashboardSidebar(disable = T),
    dashboardBody(
      fluidPage(
        textInput("n", "Number of observations"),
        actionButton("goButton", "Go!"),
        actionButton("resetButton", "Reset"),
        bookmarkButton(),
        conditionalPanel(
          condition = "input.goButton",
          uiOutput("plotArea")
        )
      )
    )
  )
}
server <- function(input, output, session) {
  observeEvent(input$resetButton, {
    updateTextInput(session, "n", "Number of observations", NA)
  })
  
  getN <- eventReactive(input$goButton, {
    new_n = plyr::round_any(as.numeric(input$n), 10)
    return(list(new_n = new_n))
  })
  
  output$plot <- renderPlotly({
    plot_ly(x = faithful$eruptions[seq_len(getN()$new_n)], type = "histogram", nbinsx = 30)
  })
  
  output$table <- DT::renderDataTable(
    data.frame(datapoint = faithful$eruptions[seq_len(getN()$new_n)])
  )
  
  output$plotArea <- renderUI({
    validate(
      need(as.numeric(input$n) < 50,"Please enter a number < 50.")
    )
    list(
      fluidRow(
        box(width = 8, title = "Histogram",plotlyOutput('plot')
        ),
        box(width = 4, title = "Table", DT::dataTableOutput('table'))
      )
    )
  })
}
enableBookmarking(store = "url")
shinyApp(ui, server)