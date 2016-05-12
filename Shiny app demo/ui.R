
library(shiny)
# Define UI for application that draws a histogram
shinyUI(pageWithSidebar(
  headerPanel("US Population distribution and growth (Base Year 1900)"),
  
  sidebarPanel(
    p('This app plots the Population distribution across US States 
      and top 10 states with highest growth in population from 1900 as base year'),
    selectInput("inputyear", label = ("Select Year"), 
                choices = list("2015" = "Year_2015", "2010" = "Year_2010", "2000" = "Year_2000",
                               "1990" = "Year_1990","1950" = "Year_1950"), 
                selected = 1),
    p('                   '),
    p('Rpubs link for the presentation is http://rpubs.com/kjitender/180215')
  ),
  mainPanel(
    p('Population distribution across the US States'),
    plotOutput('mappopus'),
    p('Top 10 cities with change in population Base year 1900'),
    plotOutput('plottop10')
  )
))