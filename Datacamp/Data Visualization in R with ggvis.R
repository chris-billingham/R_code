
library(tidyverse)
library(ggvis)

# Adapt the code: show bars instead of points
pressure %>% ggvis(~temperature, ~pressure) %>% layer_bars()

# Adapt the code: show lines instead of points
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()

# Extend the code: map the fill property to the temperature variable
pressure %>% ggvis(~temperature, ~pressure,fill=~temperature) %>% layer_points()

# Extend the code: map the size property to the pressure variable
pressure %>% ggvis(~temperature, ~pressure,size=~pressure) %>% layer_points()



# Build a histogram with a binwidth of 5 units
faithful %>% ggvis(~waiting) %>% layer_histograms(width = 5)

# Finish the command
faithful %>%
  compute_bin(~waiting, width = 5) %>%
  ggvis(x = ~xmin_, x2 = ~xmax_, y = 0, y2 = ~count_) %>%
  layer_rects()

faithful %>% ggvis(~waiting, fill := "green") %>% layer_densities()

# Instruction 1
mtcars %>% group_by(cyl) %>% ggvis(~mpg, ~wt, stroke = ~factor(cyl)) %>% layer_smooths()

# Instruction 2
mtcars %>% group_by(cyl) %>% ggvis(~mpg, fill = ~factor(cyl)) %>% layer_densities()

glimpse(mtcars)
mtcars %>% ggvis(~mpg, fill = ~factor(cyl)) %>% layer_densities()

# Alter the graph
mtcars %>% group_by(cyl, am) %>% ggvis(~mpg, fill = ~interaction(cyl, am)) %>% layer_densities()



# Adapt the code: set fill with a select box
faithful %>%
  ggvis(~waiting, ~eruptions, fillOpacity := 0.5,
        shape := input_select(label = "Choose shape:",
                              choices = c("circle", "square", "cross",
                                          "diamond", "triangle-up", "triangle-down")),
        fill := input_select(label = "Choose color:",
                             choices = c("black", "red", "blue", "green"))) %>%
  layer_points()

# Add radio buttons to control the fill of the plot
mtcars %>%
  ggvis(~mpg, ~wt,
        fill := input_radiobuttons(label = "Choose color:",
                                   choices = c("black", "red", "blue", "green"))) %>%
  layer_points()


# Change the radiobuttons widget to a text widget
mtcars %>%
  ggvis(~mpg, ~wt,
        fill := input_text(label = "Choose color:",
                           value = "black")) %>%
  layer_points()

# Map the fill property to a select box that returns variable names
mtcars %>%
  ggvis(~mpg, ~wt,
        fill = input_select(label = "Choose fill variable:",
                            choices = names(mtcars), map = as.name)) %>%
  layer_points()


mtcars %>%
  ggvis(x=~mpg, y=input_select(label = "Choose y variable:",
                               choices = names(mtcars), map = as.name),
        fill = input_select(label = "Choose fill variable:",
                            choices = names(mtcars), map = as.name)) %>%
  layer_points()

# Change the axes of the plot as instructed
faithful %>% 
  ggvis(~waiting, ~eruptions) %>% 
  layer_points() %>% 
  add_axis("x", 
           title = "Time since previous eruption (m)", 
           values = c(50, 60, 70, 80, 90), 
           subdivide = 9
           ) %>%
  add_axis("y", 
           title = "Duration of eruption (m)", 
           values = c(2, 3, 4, 5), 
           subdivide = 9
           )

# Add a scale_numeric()
mtcars %>% 
  ggvis(~wt, ~mpg, fill = ~disp, stroke = ~disp, strokeWidth := 2) %>%
  layer_points() %>%
  scale_numeric("fill", range = c("red", "yellow")) %>%
  scale_numeric("stroke", range = c("darkred", "orange"))

# Add a scale_numeric()
mtcars %>% ggvis(~wt, ~mpg, fill = ~hp) %>%
  layer_points() %>%
  scale_numeric("fill", range = c("green", "beige"))

# Add a scale_nominal()
mtcars %>% ggvis(~wt, ~mpg, fill = ~factor(cyl)) %>%
  layer_points() %>%
  scale_nominal("fill", range = c("purple", "blue", "green"))
