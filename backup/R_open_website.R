######## open website and search web  ####
shell.exec("http://www.talkstats.com")

google.search <- function(search){
  shell.exec(paste("http://www.google.com/#q=", search, sep = ""))
}

google.search("Binning Outliers in a Histogram")




#######