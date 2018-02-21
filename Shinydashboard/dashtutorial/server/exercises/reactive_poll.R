library(shiny)
library(httr)
library(xml2)
library(magrittr)

feedUrl <- "https://jchengdemo.wordpress.com/feed/"
# Or use http://lorem-rss.herokuapp.com/feed?unit=second&interval=5 for
# more frequently updating (but less realistic) data

ui <- fluidPage(
  tableOutput("entries")
)

server <- function(input, output, session) {
  feed_data=reactivePoll(1000,session,
  checkFunc=function(){
    httr::HEAD(feedUrl)$headers[c("last-modified", "etag")]
  },
  valueFunc=function(){
  feed_xml <- read_xml(feedUrl)
  title <- xml_find_all(feed_xml, "/rss/channel/item/title") %>% xml_text()
  creator <- xml_find_all(feed_xml, "/rss/channel/item/dc:creator") %>% xml_text()
  date <- xml_find_all(feed_xml, "/rss/channel/item/pubDate") %>% xml_text()
  link <- xml_find_all(feed_xml, "/rss/channel/item/link") %>% xml_text()
  data.frame(stringsAsFactors = FALSE,
    title = title, creator = creator, date = date, link = link
  )
  }
  )
  output$entries <- renderTable({
    feed_data()
  })
}

shinyApp(ui, server)