
################   temple    #################
#library(shiny)
#ui
#ui=fluidPage("hello world")

#server
#server=function(input,output){}

#run
#shinyApp(ui=ui,server = server)

###################   a+b=z shiny app ##############
library(shiny)
#ui
ui=fluidPage(titlePanel("Hello Shiny!"),                                                   # title 
             sidebarLayout(                                                                # type of layout
               sidebarPanel(                                                               # left side panel
                 numericInput(inputId = 'a','first number',0),                             # numericInput into a and defalt is 0 
                 numericInput(inputId = 'b','second number',0),                            # numericInput into b and defalt is 0 
                 sliderInput(inputId = 'c','third number',min = 1,max = 50,value = 30),    # numericInput into c and defalt is 30
                 checkboxInput(inputId ='d','add 10',FALSE),                               # 1/0 into d and defalt is 0 
                 dateInput(inputId='e', 'input date','2017-01-01'),                        # date input to e
                 dateRangeInput('f',label = 'Date range input: yyyy-mm-dd',                # date range to f
                                start = Sys.Date() - 2, end = Sys.Date() + 2),
                 selectInput('g',label='select cyl',c(999,unique(mtcars$cyl)))                    # selectInput to g
               ),
               mainPanel(                                        # right main panel
                 textOutput('z1'),                                   # output  z1
                 verbatimTextOutput("z2"),                        #  output  z2
                 verbatimTextOutput("z3"),                        #  output  z3
                 tableOutput("z4"),                                #  output table  z4
                 plotOutput('z5')                                   # output chart z5
               )
             )
             )

#server
server=function(input,output){ 
  output$z1=renderText({input$a+input$b+input$c+input$d*10})           # output  number (z1 =a+b+c+d) as text 
  output$z2=renderText({as.character(input$e)})                         # output date z2 as text
  output$z3=renderText({as.character(input$f)})                         # output date z3 as text
  output$z4=renderTable({mtcars%>%filter(cyl==input$g)})                # output date z4 as table
  output$z5=renderPlot({ggplot(mtcars%>%filter(cyl==input$g),aes(mpg,wt))+geom_point()})                # output date z4 as table
}

#run
shinyApp(ui=ui,server = server)

###############################   ploty                      ###################################################


library(plotly)

plot_ly(data=mtcars, x = ~wt , y =~mpg,mode='markers')

plot_ly(data=mtcars, x = ~wt , y =~mpg,mode='markers',color = ~cyl)



plot_ly(data=mtcars, x = ~wt , y =~mpg,z=~hp,type="scatter3d",mode='markers',color = ~as.factor(cyl))

library(dplyr)
data("airmiles")
head(airmiles)
class(airmiles)

plot_ly(x=~time(airmiles),y=~airmiles,mode='lines')


library(plotly)
library(tidyr)
library(dplyr)
data("EuStockMarkets")

stocks <- as.data.frame(EuStockMarkets) %>%
  gather(index, price) %>%
  mutate(time = rep(time(EuStockMarkets), 4))
stocks

plot_ly(stocks, x = ~time, y = ~price, color = ~index)


library(plotly)
plot_ly(x = ~precip, type = "histogram")

plot_ly(iris, y = ~Petal.Length, color = ~Species, type = "box")

?state.abb

# Create data frame
state_pop <- data.frame(State = state.abb, Pop = as.vector(state.x77[,1]))
# Create hover text
state_pop$hover <- with(state_pop, paste(State, '<br>', "Population:", Pop))
# Make state borders white
borders <- list(color = toRGB("black"))
# Set up some mapping options
map_options <- list(
  scope = 'usa',
  projection = list(type = 'USA'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)


plot_ly(state_pop, z = ~Pop, text = ~hover, locations = ~State, 
        type = 'choropleth', locationmode = 'USA-states', 
        color = ~Pop, colors = 'Reds', marker = list(line = borders)) %>%
  layout(title = 'US Population in 1975', geo = map_options)


###################################################


library(plotly)

df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2011_us_ag_exports.csv")

write.csv(df,'df.csv')



df$hover <- with(df, paste(state, '<br>', "Beef", beef, "Dairy", dairy, "<br>",
                           "Fruits", total.fruits, "Veggies", total.veggies,
                           "<br>", "Wheat", wheat, "Corn", corn))
# give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

p <- plot_geo(df, locationmode = 'USA-states') %>%
  add_trace(
    z = ~total.exports, text = ~hover, locations = ~code,
    color = ~total.exports, colors = 'Purples'
  ) %>%
  colorbar(title = "Millions USD") %>%
  layout(
    title = '2011 US Agriculture Exports by State<br>(Hover for breakdown)',
    geo = g
  )
p
