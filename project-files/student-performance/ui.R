# Academic Performance Analytics
# Ben Schedin
# Shiny Client Functionality

# TODO: make the data downloadable: https://stackoverflow.com/questions/44504759/shiny-r-download-the-result-of-a-table
# TODO: add school filter for grades
# TODO: change school fill colors for grade densities
# TODO: center/change grade density plot position and/or scale

library(shiny)
library(shinythemes)
library(DT)

data <- read.csv("www/full.csv")

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme=shinytheme("yeti"),
                  titlePanel("Academic Performance Analytics"),
                  navbarPage("Navigation",
                             
                             tabPanel(icon("home")),
                             
                             tabPanel("Grades",
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
                             
                             tabPanel("Demographics")
                             
                  )
)
)
