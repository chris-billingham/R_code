#RtutoR
#EDA
#By 	Anup Nair
#https://cran.r-project.org/web/packages/RtutoR/
#https://github.com/anup50695/RtutoR

#monthly download:49
#https://www.rdocumentation.org/packages/RtutoR/versions/1.1

install.packages('RtutoR')
library(RtutoR)


# airquality data set example 
#https://www.rdocumentation.org/packages/datasets/versions/3.4.3/topics/airquality
head(airquality)

res = generate_exploratory_analysis_ppt(airquality,target_var = "Temp", output_file_name = "airquality_RtutoR.pptx")
gen_exploratory_report_app(airquality)

# diamonds data set example 
#http://ggplot2.tidyverse.org/reference/diamonds.html
library(ggplot2)
head(diamonds)

res = generate_exploratory_analysis_ppt(diamonds,target_var = "price", output_file_name = "diamonds_RtutoR.pptx")
gen_exploratory_report_app(diamonds)


# Titanic data set example
titanic=read.csv('train.csv')
head(titanic)
gen_exploratory_report_app(titanic)


