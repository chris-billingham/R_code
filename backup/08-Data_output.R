
#   8 Data output &presentation



### ggmap
#install.packages('ggmap')
#install.packages('mapproj')
library(ggmap)
library(mapproj)

#terrain;satellite;roadmap;hybrid
map=get_map(location = 'us',zoom=4,maptype = 'terrain')
ggmap(map)
?get_map
?ggmap


setwd("C:/Users/tduan/Desktop/Mission/R/R_code")
zipcode <- read.csv("zipcode.csv", header=TRUE)

zipcode2=sample_n(zipcode,20)
pop=round(runif(20, 1, 500))
zipcode3=cbind(zipcode2,pop)
zipcode3

gp=ggmap(map,extent='device',
         base_layer = ggplot(zipcode2,aes(x=longitude,y=latitude)))

gp=gp+geom_point(color="blue",aes(size=pop))+labs(title='city pop',size=
                                                    'popluation')
print(gp)






