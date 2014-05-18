
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("New Application"),
  
  # Sidebar with a slider input for number of observations
  sidebarLayout(
  sidebarPanel(
    selectInput("c.type",
              "Listed type of Crime:",
              choices = mot.list,
              selected = "Larceny"
              ),
    selectInput("n.loc",
                "Neighborhood Listing:",
                choices = nb.list,
                selected = "KERNS")
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    #output$TypePlot
    textOutput("SelectedC"),
    textOutput("SelectedN"),
    plotOutput(print("TypePlot"))
  )
  )
))
