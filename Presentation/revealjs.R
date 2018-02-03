
install.packages('getPass')
library(getPass)
rmarkdown::render("revealjs.Rmd", params=list(pass=pw))
