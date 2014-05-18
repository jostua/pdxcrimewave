
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library("shiny")
library("ggplot2")
library("dplyr")

shinyServer(function(input, output) {

#  TimeSeries.SpecCrime <- reactive({
#    ggplot(data=speccrime(input$c.type,input$n.loc)) + 
#    geom_smooth(aes(x=strptime(repdate, "%Y-%m-%d"), y=Count, group=Neighborhood, color=Neighborhood)) +
#    p.theme
#  })  
   
#   output$distPlot <- renderPlot({
#      
#     # generate and plot an rnorm distribution with the requested
#     # number of observations
#     dist <- rnorm(input$obs)
#     hist(dist)
  
  output$TypePlot <- renderPlot({
    Splot <- {
      ggplot(data=speccrime(input$c.type,input$n.loc)) + 
      geom_point(aes(x=strptime(repdate, "%Y-%m-%d"), y=Count, group=Neighborhood, color=Neighborhood)) +
      geom_smooth(aes(x=strptime(repdate, "%Y-%m-%d"), y=Count, group=Neighborhood, color=Neighborhood)) +
        labs(x = "TimeSeries", y = "Number of Reports", title="TimeSeries plot of specific crime by specific neighborhood") +
      p.theme
            }
    print(Splot)
  })
  output$SelectedN <- renderText({
    paste("You have selected: ", input$n.loc)
  })
  output$SelectedC <- renderText({
    paste("You have selected: ", input$c.type)
  })
  
})
