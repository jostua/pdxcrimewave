
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library("shiny")
library("ggplot2")
library("dplyr")

shinyServer(function(input, output) {

 react.out <- reactive({
   TimeSeries.SpecCrime <- speccrime(input$c.type,input$n.loc)
         })
   
#   output$distPlot <- renderPlot({
#      
#     # generate and plot an rnorm distribution with the requested
#     # number of observations
#     dist <- rnorm(input$obs)
#     hist(dist)
  
  output$TypePlot <- renderPlot({
    plot.Data <- speccrime(input$c.type,input$n.loc)
    Splot <- {
      ggplot(data=plot.Data) + 
      geom_point(aes(x=strptime(repdate, "%Y-%m-%d"), y=Count, group=Major.Offense.Type, color=Major.Offense.Type)) +
      geom_smooth(aes(x=strptime(repdate, "%Y-%m-%d"), y=Count, group=Major.Offense.Type, color=Major.Offense.Type)) +
        labs(x = "TimeSeries", y = "Number of Reports", title="TimeSeries plot of specific crime by specific neighborhood") +
      p.theme
            }
    print(Splot)
  })
  output$MapPlot <- renderPlot({
    neighborhood.num <- merge(neighborhood.list, c.neigh(input$c.type), by.x="crimeneighbor", by.y="Neighborhood", incomparables="0")
    neighborhood.num$Count[neighborhood.num$Count == "NA"] <- 0
    pdxmap.poly@data=merge(pdxmap.poly@data,neighborhood.num,by.x='NAME',by.y='mapneighbor', all.x=T, sort=F)
    nnames <- pdxmap.poly$NAME
    nnamesLabel <- 1:length(pdxmap.poly$NAME)
    pdxmap.poly$Count[is.na(pdxmap.poly$Count)] <- 0
    plot(pdxmap.poly,col=rgb(red = 0, green = 0, blue = 1-(pdxmap.poly@data$Count/max(pdxmap.poly@data$Count)), alpha=pdxmap.poly@data$Count/max(pdxmap.poly@data$Count)))
    
  })
  output$SelectedN <- renderText({
    paste("You have selected: ", input$n.loc)
  })
  output$SelectedC <- renderText({
    paste("You have selected: ", input$c.type)
  })
  
})
