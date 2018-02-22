
#install.packages("mailR")
#install.packages("sendmailR")
#install.packages("stringr")

library(mailR)
library(sendmailR)

library(dplyr)


send.mail(from = "verykoala@gmail.com",
          to = c("jcwinningco@gmail.com"),
          #cc = c("CC Recipient <cc.recipient@gmail.com>"),
          #bcc = c("BCC Recipient <bcc.recipient@gmail.com>"),
          subject = "Subject of the email by R",
          body = "Body of the email by R",
          smtp = list(host.name = "aspmx.l.google.com", port = 25),
          authenticate = FALSE,
          send = TRUE,
          attach.files = c("C:/Users/User/Desktop/Mission/R/code/R_email.R"),
          debug = TRUE)



