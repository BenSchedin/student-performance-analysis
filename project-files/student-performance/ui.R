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
shinyUI(fluidPage(theme=shinytheme("superhero"),
                  titlePanel("Academic Performance Analytics System"),
                      navbarPage("Navigation",
                                 
                                 tabPanel(icon("home")),
                                 
                                 tabPanel("General",
                                                sidebarPanel(sliderInput("perfThresh", "Performance Threshold", min=0, max=20, value=10), width=2),
                                          
                                                mainPanel(fluidRow(column(plotOutput("g1Density"), width=6),
                                                                   column(plotOutput("g2Density"), width=6)),
                                                          fluidRow(column(plotOutput("g3Density"), width=6),
                                                                   column(plotOutput("gMeanDensity"), width=6))),
                                          
                                                fluidRow(column(DT::dataTableOutput("belowThreshTable"), width=12))
                                          ),
                                 
                                 tabPanel("Tab2")
                                 
                                 )
                  )
        )
