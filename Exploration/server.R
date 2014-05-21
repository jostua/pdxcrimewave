
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
  output$SelectedN <- renderText({
    paste("You have selected: ", input$n.loc)
  })
  output$SelectedC <- renderText({
    paste("You have selected: ", input$c.type)
  })
  
})
