

US Population Distirbution across states Presentation
========================================================
author: Jitender Kumar
date: 
autosize: true



Executive Summary
========================================================
The application developed as submission to Developing Data Products course.

This application performs the following
  - Plots the Population distribution across US States 
  - Top 10 states with highest growth in population from 1900 as base year

Data for year 2015, 2010, 2000, 1990 and 1950 are used for the application. All figures are in millions
 
Conclusion: 
**California, Florida,  Texas and New York** are the states which have shown maximum population growth for the years.


Methodology
========================================================
After the Data is loaded, we are doing the following
 - Convert to Numeric format and calculate the difference in population
 - Change the States to lower case and merge with maps state data
 - GGplot for plotting the population distribution
 - Sorting the change in population data and selecting top 10 states 
 - Using ggplot again to build histogram of data
 
 Ggplot2, maps and RColorbrewer packages are used for plotting the data
 
US States Ploting
========================================================
Following is code for plotting the Population distribution

```r
ggplot(popdata, aes(map_id = State)) + geom_map(aes_string(fill = popdata$Year_2015), map = states_map) + ggtitle("Population distribution across states (in millions)") + scale_fill_gradientn("",colours=brewer.pal(5,"GnBu"))+ expand_limits(x = states_map$long, y = states_map$lat)
```

![plot of chunk unnamed-chunk-2](USPopGrowth Presentation-figure/unnamed-chunk-2-1.png)


Histogram Plotting
========================================================


```r
ggplot(popdata1,aes(State,value/1000000,fill= variable))+ geom_bar(stat = "identity", position = "stack") +
        xlab("State") + ylab("Population Growth (in millions)") +
        ggtitle("Top 10 states with highest growth in population") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

![plot of chunk unnamed-chunk-3](USPopGrowth Presentation-figure/unnamed-chunk-3-1.png)


Links
========================================================
The data used for the application can be found at 
http://www.factmonster.com/ipka/A0004986.html

Shiny application is hosted at 
https://kjitender.shinyapps.io/DPP_App_Assignment/

Github link is https://github.com/kjitender/DDP_Data_Science
