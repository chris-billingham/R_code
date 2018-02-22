
# http://ggplot2.tidyverse.org/reference/

#install.packages('tidyverse')
#install.packages('psych')
#install.packages('reshape2')

install.packages("rbokeh")
Sys.setenv(LANG = "en")
Sys.setlocale("LC_ALL", "English")

library(tidyverse)

#############   Correlation   ##################################

head(mtcars)

# Pearson product-moment correlation(r) with no missing value
mtcars %>%summarize(N = n(), r = cor(mpg,wt, 
                                     use = "pairwise.complete.obs"))


mtcars %>%group_by(cyl)%>%summarize(N = n(), r = cor(mpg,wt, 
                                     use = "pairwise.complete.obs"))
mtcars001=mtcars
glimpse(mtcars001)




ggplot(data = mtcars, aes(x = mpg, y = wt)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE)


library(tidyverse)

library(dplyr)
glimpse(mtcars)














# numeric  vs numeric
ggplot(data = mtcars001, aes(x = hp, y = mpg)) + 
  geom_point()

# numeric  vs character
ggplot(data = mtcars001, aes(x = cut(hp, breaks = 5), y = mpg)) + 
  geom_point()






##########   Outlier #########################################















#############   Regression    ####################################










#######################       Scatter plot     #################################


t001=mtcars
glimpse(mtcars)
glimpse(t001)

ggplot(mtcars, aes(x = mpg, y = disp)) +
  geom_point()

ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(shape = 1, size = 4)

ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl, col = am)) +
  geom_point(shape = 21, size = 4, alpha = 0.6)


# Map cyl to size
ggplot(mtcars, aes(x = wt, y = mpg, size = cyl)) +
  geom_point()

# Map cyl to alpha
ggplot(mtcars, aes(x = wt, y = mpg, alpha = cyl)) +
  geom_point()



# Map cyl to labels
ggplot(mtcars, aes(x = wt, y = mpg, label = cyl)) +
  geom_text()

# Shown in the viewer:
ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_point()

# Solutions:
# 1 - With geom_jitter()
ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_jitter(alpha = 0.2,shape = 1)


ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 24, color = 'yellow')






########################    Line Plots  #############################################
recess=data.frame(begin=as.Date(c("1979-12-01", "1983-11-01")),end=as.Date(c("1978-12-01", "1984-11-01")))
str(recess)


# Basic line plot
ggplot(economics, aes(x = date, y = unemploy/pop)) +
  geom_line()

# Expand the following command with geom_rect() to draw the recess periods
ggplot(economics, aes(x = date, y = unemploy/pop)) +
  geom_rect(data = recess, 
            aes(xmin = begin, xmax = end, ymin = -Inf, ymax = +Inf), 
            inherit.aes = FALSE, fill = "red", alpha = 0.2) +
  geom_line()






##########################   Boxplot #######################

ggplot(mpg, aes(class, hwy)) +
  geom_boxplot(colour = "grey50") +
  geom_jitter()
#############################   Bar chart ##################




# Add geom (position = "stack" by default)
cyl.am + 
  geom_bar()

# Fill - show proportion
cyl.am + 
  geom_bar(position = "fill")  

# Dodging - principles of similarity and proximity
cyl.am +
  geom_bar(position = "dodge") 



#####################          Histogram        ##############################


# 1 - Make a univariate histogram
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram()

# 2 - Plot 1, plus set binwidth to 1 in the geom layer
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(binwidth=1)


# 3 - Plot 2, plus MAP ..density.. to the y aesthetic (i.e. in a second aes() function)
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(aes(y = ..density..), binwidth = 1)


# 4 - plot 3, plus SET the fill attribute to "#377EB8"
ggplot(mtcars, aes(x = mpg,y=..density..)) +
  geom_histogram(aes(y = ..density..), binwidth = 1, fill = "#377EB8")




########################   qplot #######################################






p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()

p + annotate("text", x = 4, y = 25, label = "Some text")

p + annotate("text", x = 2:5, y = 25, label = "Some text")

p + annotate("rect", xmin = 3, xmax = 4.2, ymin = 12, ymax = 21,
             alpha = .2)

p + annotate("segment", x = 2.5, xend = 4, y = 15, yend = 25,
             colour = "blue")

p + annotate("pointrange", x = 3.5, y = 20, ymin = 12, ymax = 28,
             colour = "red", size = 1.5)

p + annotate("text", x = 2:3, y = 20:21, label = c("my label", "label 2"))

p + annotate("text", x = 4, y = 25, label = "italic(R) ^ 2 == 0.75",
             parse = TRUE)

p + annotate("text", x = 4, y = 25,
             label = "paste(italic(R) ^ 2, \" = .75\")", parse = TRUE)





######################   Bloomberg Plot ##############################

set.seed(199)
dat = data.frame(date = seq(as.Date("2013/10/01"), as.Date("2013/12/31"), by="1 day"),
                 price = cumsum(rnorm(92, 0, 1)) + 100)

ggplot(dat, aes(date, y=price)) +
  geom_area(fill="navyblue", colour="white", alpha=0.5) +
  theme(plot.background=element_rect(fill="black"),
        panel.background=element_rect(fill="#101040"),
        panel.grid.minor=element_blank(),
        panel.grid.major=element_line(linetype=2),
        axis.text=element_text(size=15, colour="white")) +
  coord_cartesian(ylim=c(min(dat$price) - 1, max(dat$price) + 1),
                  xlim=c(min(dat$date)-2, max(dat$date)+10)) +
  annotate("rect", xmin=max(dat$date) + 0.75, xmax=max(dat$date) + 7.25, 
           ymin=dat$price[dat$date==max(dat$date)] - 0.25, 
           ymax=dat$price[dat$date==max(dat$date)] + 0.25, fill="white", colour="black") +
  annotate("text", max(dat$date) + 1, dat$price[dat$date==max(dat$date)], 
           label=paste0("$", round(dat$price[dat$date==max(dat$date)],2)), 
           colour="black", hjust=0)















