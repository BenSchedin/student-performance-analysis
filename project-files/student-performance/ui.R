#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(DT)

data <- read.csv("www/full.csv")

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme=shinytheme("yeti"),
                  titlePanel("Academic Performance Analytics"),
                  navbarPage("Navigation",
                             
                             tabPanel(icon("home")),
                             
                             tabPanel("General",
                                      sidebarPanel(sliderInput("perfThresh", 
                                                               "Performance Threshold", 
                                                               min=0, 
                                                               max=20, 
                                                               value=10),
                                                   
                                                   radioButtons("periodSel",
                                                                "Class Period",
                                                                c("First" = "G1", "Second" = "G2", "Third" = "G3", "Average" = "gMean")),
                                                   
                                                   width=2),
                                      
                                      mainPanel(fluidRow(column(plotOutput("gradeDensity"), width=12))),
                                
                                      
                                      fluidRow(column(DT::dataTableOutput("belowThreshTable"), width=12))
                             ),
                             
                             tabPanel("Tab2")
                             
                  )
)
)
