
#https://gohugo.io/
#https://www.youtube.com/watch?v=syWAKaj-4ck
#https://www.rstudio.com/resources/webinars/introducing-blogdown/
#https://www.netlify.com/

#https://themes.gohugo.io/

options(editor = "internal")
#devtools::install_github('rstudio/blogdown')

library(blogdown)

setwd('C:/Users/User/Desktop/Mission/R/R_code/Blogdown/Bdown_001')
getwd()

#install_hugo()
hugo_version()

#install hugo
new_site()

# blogdown::new_site(theme = "gcushen/hugo-academic")

install_theme('Vimux/mainroad')
build_site()
