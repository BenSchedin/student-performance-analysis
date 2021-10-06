# Academic Performance Analytics
# Ben Schedin
# Shiny Client Functionality

# TODO: make the data downloadable: https://stackoverflow.com/questions/44504759/shiny-r-download-the-result-of-a-table
# TODO: add school filter for grades
# TODO: change school fill colors for grade densities
# TODO: center/change grade density plot position and/or scale
# TODO: make plot scaling fill page ()
# TODO: fix landing page centering issues for login dialogue

library(shiny)
library(shinythemes)
library(DT)

data <- read.csv("www/full.csv")

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme=shinytheme("yeti"),
                  titlePanel("Academic Performance Analytics"),
                  navbarPage("Navigation",
                             
                             # Main Tab: Home
                             tabPanel(icon("home"),
                                      # Welcome text
                                      fluidRow(column(br(), br(), br(), br(), br(), br(), p("Welcome", style="text-align:center; font-size:85px; font-family: 'Garamond'"), width=12)),
                                      
                                      # Sign in
                                      
                                      fluidRow(
                                        column(3, offset=5,
                                               titlePanel("Sign in"),
                                               wellPanel(
                                                 textInput("userCred", "Username"),     
                                                 textInput("pwCred", "Password"),
                                                 actionButton("loginButton", "Enter")
                                               )
                                        )
                                      )
                                      
                                      ),
                             
                             # Main Tab: Grades
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
                             
                             # Main Tab: Habits
                             tabPanel("Behavior",
                                      fluidRow(column(plotOutput("failures"), width=4), column(plotOutput("studyTime"), width=4), column(plotOutput("freeTime"), width=4)),
                                                fluidRow(column(plotOutput("absences"), width=12))
                                      ),
                             
                             # Main Tab: Courses
                             tabPanel("Courses"),
                             
                             # Main Tab: Instructors
                             tabPanel("Instructors")
                             
                             )
                  )
        )
