
# F4  run select

%reset -f      # remove all vairable

#################  01-intro
#################  02-Package
#################  03-Data_import
#################  04-Data_EDA_Visualization
#################  05-Data_Cleaning
#################  06-Data_Modeling
#################  07-Data_Validation_and_scoring
#################  08-Data_output


# get wd 
import os
os.getcwd()
#set wd 
os.chdir('C:/Users/User/Desktop/Mission/R/R_code/Get_Python/Book')






#################  04-Data_EDA_Visualization










#Matplotlib 


import matplotlib.pyplot as plt
plt.plot(year, physical_sciences, color='blue')

#bokeh
# Import figure from bokeh.plotting
from bokeh.plotting import figure

# Import output_file and show from bokeh.io
from bokeh.io import output_file, show

# Create the figure: p
p = figure(x_axis_label='fertility (children per woman)', y_axis_label='female_literacy (% population)')

# Add a circle glyph to the figure p
p.circle(fertility, female_literacy)

# Call the output_file() function and specify the name of the file
output_file('fert_lit.html')

# Display the plot
show(p)











