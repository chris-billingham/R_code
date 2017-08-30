
#https://github.com/pzhaonet/mindr
#install.packages("mindr")
library('mindr')
example(md2mm)

#To create a mind map from your own markdown files
md2mm()


getwd()
#Convert (a) mind map(s) into a markdown file
example(mm2md)

#Create Interactive Web MindMap with the JavaScript 'markmap' Library
example(markmap)

#More themes can be seen if you run:
example(markmapOption)

#To create your own interactive mind map
markmap()

#Extract the outline from (a) markdown files
example(outline)

#To extract the outline from your own markdown
outline()
