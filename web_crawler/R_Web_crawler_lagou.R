#install.packages("rvest")
#install.packages("jpeg")
#install.packages("installr")
#install.packages("httr")
#Sys.setlocale("LC_ALL","Chinese")
#library(installr)
#updateR()
#install.packages("xml2")
library(dplyr)
library(tidyr)
library(xml2)
library(rvest)
library(jpeg)
library(httr)

Sys.setlocale(locale='Chinese')

###################     Lagou            #####################################

data_job_url='https://www.lagou.com/zhaopin/shujuwajue/1'


lagou=read_html(data_job_url)
job_title=lagou%>%html_nodes("h3")%>%html_text()
job_title_link=lagou%>%html_nodes("a.position_link")%>%html_attr("href")
job_title_salary=lagou%>%html_nodes(".money")%>%html_text()
job_title_company=lagou%>%html_nodes(".company_name a")%>%html_text()
job_title_company_dis=lagou%>%html_nodes(".li_b_r")%>%html_text()
job_title_requirement=lagou%>%html_nodes(".p_bot .li_b_l")%>%html_text()
job_title_industry=lagou%>%html_nodes(".industry")%>%html_text()

job001=data.frame(job_title,job_title_link,job_title_salary,job_title_company,job_title_company_dis,job_title_industry,job_title_requirement)

glimpse(job001)

###################### 数据挖掘  ############################
pages=c(2)
pages
job=data.frame()
for (page in pages){
  print(page)
  Sys.sleep(runif(1, min=8, max=10))
  data_job_url=paste("https://www.lagou.com/zhaopin/shujuwajue/",page,sep="")
  #print(data_job_url)
  lagou=read_html(data_job_url)
  job_title=lagou%>%html_nodes("h3")%>%html_text()
  job_title_link=lagou%>%html_nodes("a.position_link")%>%html_attr("href")
  job_title_salary=lagou%>%html_nodes(".money")%>%html_text()
  job_title_company=lagou%>%html_nodes(".company_name a")%>%html_text()
  job_title_company_dis=lagou%>%html_nodes(".li_b_r")%>%html_text()
  job_title_requirement=lagou%>%html_nodes(".p_bot .li_b_l")%>%html_text()
  job_title_industry=lagou%>%html_nodes(".industry")%>%html_text()
  job_title_location=lagou%>%html_nodes("#s_position_list em")%>%html_text()
  job001=data.frame(job_title,job_title_link,job_title_salary,job_title_company,job_title_company_dis,job_title_industry,job_title_requirement,job_title_location)
  job=rbind(job,job001)
}

job$job_title_salary=gsub('k', '', job$job_title_salary)
job$job_title_salary=gsub('K', '', job$job_title_salary)
job_002=job%>%separate(job_title_salary,c('low_salary','high_salary'),"-")%>%
  separate(job_title_location,c('city','area'),"·")
job_002$low_salary=as.integer(job_002$low_salary)
job_002$high_salary=as.integer(job_002$high_salary)


Sys.sleep(5)
###################### 商业数据分析  ############################
pages=seq(8)
pages
job=data.frame()
for (page in pages){
  print(page)
  Sys.sleep(runif(1, min=8, max=10))
  #data_job_url=paste("https://www.lagou.com/zhaopin/shangyeshujufenxi/",page,"/?filterOption=",page,sep="")
  data_job_url=paste("https://www.lagou.com/zhaopin/shangyeshujufenxi/",page,"/?filterOption=2",sep="")
  print(data_job_url)
  lagou=read_html(data_job_url)
  job_title=lagou%>%html_nodes("h3")%>%html_text()
  job_title_link=lagou%>%html_nodes("a.position_link")%>%html_attr("href")
  job_title_salary=lagou%>%html_nodes(".money")%>%html_text()
  job_title_company=lagou%>%html_nodes(".company_name a")%>%html_text()
  job_title_company_dis=lagou%>%html_nodes(".li_b_r")%>%html_text()
  job_title_requirement=lagou%>%html_nodes(".p_bot .li_b_l")%>%html_text()
  job_title_industry=lagou%>%html_nodes(".industry")%>%html_text()
  job_title_location=lagou%>%html_nodes("#s_position_list em")%>%html_text()
  job001=data.frame(job_title,job_title_link,job_title_salary,job_title_company,job_title_company_dis,job_title_industry,job_title_requirement,job_title_location)
  job=rbind(job,job001)
}

job$job_title_salary=gsub('k', '', job$job_title_salary)
job$job_title_salary=gsub('K', '', job$job_title_salary)
job_003=job%>%separate(job_title_salary,c('low_salary','high_salary'),"-")%>%
  separate(job_title_location,c('city','area'),"·")
job_003$low_salary=as.integer(job_003$low_salary)
job_003$high_salary=as.integer(job_003$high_salary)



job_all=rbind(job_002,job_003)

library("xtable")
sample_table <- job_all
print(xtable(sample_table), type="html", file="example.html")



library(mailR)



send.mail(from = "jcflyingco@gmail.com",
          to = c("jcflyingco@gmail.com",'jcwinningco@163.com'),
          #cc = c("CC Recipient <cc.recipient@gmail.com>"),
          #bcc = c("BCC Recipient <bcc.recipient@gmail.com>"),
          subject = paste("System time is ",date(),  "   let go lunch"),
          body = "example.html",
          encoding = "utf-8",
          smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "jcflyingco@gmail.com", passwd = "jcduan123", ssl = TRUE),
          authenticate = TRUE,
          send = TRUE)




