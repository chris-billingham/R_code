library(dplyr)


####################  data ###########################
track_data_001=read.csv2('track_data.csv')
track_data_001$date=as.Date(track_data_001$date)
summary(track_data_001)
track_data_001$weight=as.numeric(as.character(track_data_001$weight))
glimpse(track_data_001)

###################  run shiny ##################

shinyApp(ui, server)
##############3  test  z#


gg=ggplot(track_data_001, aes(date, weight)) + geom_line()
p=ggplotly(gg)
p
