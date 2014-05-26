
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
    selectInput("n.loc",
                "Neighborhood Listing:",
                choices = nb.list,
                selected = "KERNS"),
    selectInput("c.year",
                "Year Choice:",
                choices = year.list,
                selected = "2004"),
    checkboxGroupInput("c.type",
                       "Listed type of Crime:",
                       choices = mot.list,
                       selected = "Larceny"
    )
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    #output$TypePlot
    tabsetPanel(
      tabPanel(
        "Map Output",
        plotOutput(print("MapPlot"))
        ),
      tabPanel(
        "Average Graphs",
        plotOutput(print("TypePlot"))
        )
    
    )  
  )
  )
))
