
add1=function(a,b=1){
  c=a+b
  c
}

add1(10)

install.packages('meme')


library(meme)


getwd()

f <- system.file("shiny002.png", package="meme")

meme('https://cdn.arstechnica.net/wp-content/uploads/2017/03/GettyImages-461246108-1-800x941.jpg', "code", "all the things!") + aes(color="firebrick")
Sys.Date()


u2 <- 'egd001.png'


text=paste('Updated at',Sys.Date())
text
x=meme(u2, "", text)+ aes(color="#C2F5FF", size=0.8)
x
meme_save(x, file="./meme.png") 


devtools::install_github("hrbrmstr/speedtest")
speedtest::spd_test()



install.packages('writexl')
??read_xlsx


library(writexl)

mtcars
write_xlsx(mtcars, path="df.xlsx")


library(dplyr)
glimpse(mpg)
t <- ggplot(mpg, aes(cty, hwy)) + geom_point()
t + facet_grid(. ~ fl)#facet into columns
t + facet_grid( fl~.)#facet into rows
t + facet_grid(year ~ fl)#facet year into rows,fl to columns

t <- ggplot(mpg, aes(cty, hwy)) + geom_point()
t + theme(legend.position = "bottom")
t + guides(color = "none")
t + scale_fill_discrete(name = "Title",
                        labels = c("A", "B", "C"))

g=ggplot(mpg,aes(x=manufacturer))
g+geom_histogram()

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

?mpg

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








str(airquality)
# Load the lattice package
library(lattice)

# Create the histogram 
histogram(~ Ozone, data = airquality)


# Load the quantmod package
library(quantmod)

# Import QQQ data from Yahoo! Finance
getSymbols("QQQ")
head(QQQ)



# Import QQQ data from Google Finance
getSymbols("QQQ", src = "google")
# Look at the structure of QQQ
str(QQQ)

# Import GDP data from FRED
getSymbols("GDP", src = "FRED")

# Look at the structure of GDP
str(GDP)
getSymbols("EBAY")
tail(EBAY)


?getSymbols


# Load the Quandl package
library(Quandl)

# Import GDP data from FRED
mydata = Quandl("WIKI/EBAY")

# Look at the structure of the object returned by Quandl
str(mydata)
head(mydata)
library(plotly)
plot_ly(data=mydata%>%filter(Date>='2016-09-01'),x=~Date,y=~Open,mode='lines')



library(dplyr)
library(quantmod)
# Import EBAY data to xts from Yahoo! Finance


# Import Amazon data from Google Finance
getSymbols("AMZN", src = "google")
# Look at the structure of EBAY
str(AMZN)

glimpse(AMZN)

# Plot ebay stock from 2016-09-01 to current

head(AMZN)





library(quantmod)

# Import Amazon data from Google Finance
getSymbols("AMZN", src = "google")
# Look at the structure of EBAY
#str(AMZN)
tail(AMZN)
# Plot ebay stock from 2016-09-01 to current
library(plotly)
library(ggplot2)
AMZN2 <- AMZN["2016-09-01/"] 
gg=ggplot(AMZN2, aes(x = Index, y = AMZN.Close)) + geom_line()+ggtitle("Amazon Stock price") 
  ggplotly(gg)

##########################   modeling ##########################

library(ggplot2)
# Scatterplot with regression line
ggplot(data = mtcars, aes(x = mpg, y = cyl)) + 
  geom_point() + 
  geom_smooth(method = "lm")

mtcars


getwd()
dir.exists('index.Rmd')

library(tuneR)
File1<- readMP3("Becoming_A_Legend.mp3")
play(File1)


install.packages("swirl")
library("swirl")
swirl()


mod=lm(cyl ~ mpg, data = mtcars)
fitted.values(mod)



#install.packages('broom')
library(broom)
head(augment(mod))


Sys.time()
Sys.Date()
library(RJDBC)
library(shiny)
library(datasets)
library(ggplot2)
library(dplyr)
library(stringr)
library(reshape2)
library(ebaytd)
library(gsubfn)
library(chron)
library(sqldf)
library(scales)
library(plotly)
library(readxl)
library(tidyr)
library(ggplot2)

library(RJDBC)




teradataInit("tduan", "Jcqwe123qwe$")

conn <- teradataConnect(database= 'P_bm_tony_t', system="mozart")
connf <- teradataConnect(database='P_bm_tony_t', fastload = TRUE,csv=TRUE,system="mozart")


res<-dbSendQuery(conn, "select * from P_bm_tony_t.BIG_002")


rm(result)
result<-list()
i=1

result[[i]]<-dbFetch(res,n=100000)

while(nrow(chunk <- dbFetch(res, n = 100000))>0){
  i<-i+1
  result[[i]]<-chunk
  print(i)
}

ACCT001<-do.call(rbind,result)

#rm(ACCT001)

glimpse(ACCT001)


install.packages("officer")

#https://rdrr.io/cran/officer/f/vignettes/powerpoint.Rmd
library(officer)
library(dplyr)

my_pres <- read_pptx() 

my_pres <- my_pres %>% 
  add_slide(layout = "Title and Content", master = "Office Theme")

layout_summary(my_pres)

my_pres <- my_pres %>% 
  ph_with_text(type = "title", str = "A title") %>%
  ph_with_text(type = "ftr", str = "A footer") %>%
  ph_with_text(type = "dt", str = format(Sys.Date())) %>%
  ph_with_text(type = "sldNum", str = "slide 1") %>%
  ph_with_text(str = "Hello world", type = "body")%>%
  
  add_slide(layout = "Two Content", master = "Office Theme") %>%
  ph_with_text(type = "body", str = "A first text", index = 1) %>%
  ph_with_text(type = "body", str = "A second text", index = 2) %>%
  ph_with_text(type = "title", str = "A title") %>%
  ph_with_text(type = "ftr", str = "Slide footer") %>%
  ph_with_text(type = "dt", str = format(Sys.Date()))

print(my_pres, target = "first_example.pptx") %>% 
  invisible()



library(devtools)
#install.packages("roxygen2")
library(roxygen2)

getwd()
create("cats")

setwd("./cats")
getwd()
document()
setwd("..")
getwd()
install("cats")
cat_function('haha')

cat_function()
?cat_function()

data(mtcars)
class(mtcars)
library(data.table)
library(dplyr)
mtcars_dt=data.table(mtcars)
class(mtcars_dt)

my_first_data_table <- data.table(x = c("a", "b", "c", "d", "e"), 
                                  y = c(1, 2, 3, 4, 5))  
mtcars_dt
mtcars_dt[2:3,]
mtcars_dt[,2:3]

glimpse(mtcars_dt)
