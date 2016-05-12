library(ggplot2)
library(maps)
library(mapproj)
library(reshape)
library(reshape2)
library(RColorBrewer)

popdata<-read.csv("US Statewise population data.csv")

popdata$State<-as.character(popdata$State)
popdata$Year_2015<-as.numeric(popdata$Year_2015)
popdata$Year_2010<-as.numeric(popdata$Year_2010)
popdata$Year_2000<-as.numeric(popdata$Year_2000)
popdata$Year_1990<-as.numeric(popdata$Year_1990)
popdata$Year_1950<-as.numeric(popdata$Year_1950)
popdata$Year_1900<-as.numeric(popdata$Year_1900)

popdata$diff2015<-popdata$Year_2015-popdata$Year_1900
popdata$diff2010<-popdata$Year_2010-popdata$Year_1900
popdata$diff2000<-popdata$Year_2000-popdata$Year_1900
popdata$diff1990<-popdata$Year_1990-popdata$Year_1900
popdata$diff1950<-popdata$Year_1950-popdata$Year_1900

popdata$State<-tolower(popdata$State)
popdata$State[popdata$State=="dc"]<-"district of columbia"
popdata<-popdata[1:51,]

states_map <- map_data("state")

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$mappopus <- renderPlot({
    input1<-(input$inputyear)
    output$text1 <- renderText({input$inputyear})
   ggplot(popdata, aes(map_id = State)) + 
      geom_map(aes_string(fill = popdata[,input1]/1000000), map = states_map) +
     ggtitle("Population distribution across states (in millions)") +
      scale_fill_gradientn("",colours=brewer.pal(5,"GnBu"))+
      expand_limits(x = states_map$long, y = states_map$lat)
  })
  
  output$plottop10 <- renderPlot({
    input1<-(input$inputyear)
    if(input1=="Year_2015") input_test<-8 
      else if(input1=="Year_2010") input_test<-9
      else if(input1 =="Year_2000") input_test<-10 
      else if(input1 =="Year_1990") input_test<-11 
      else if(input1 =="Year_1950") input_test<-12
      
     popdata1<-melt(popdata[order(popdata[,input_test],decreasing = T),c(1,input_test)])[1:10,]
      
      ggplot(popdata1,aes(State,value/1000000,fill= variable))+ geom_bar(stat = "identity", position = "stack") +
        xlab("State") + ylab("Population Growth (in millions)") +
        ggtitle("Top 10 states with highest growth in population") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))

  })
  
})
