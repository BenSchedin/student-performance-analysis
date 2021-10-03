#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

data <- read.csv("www/full.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Density plots for both schools, class period 1
    output$g1Density <- renderPlot({
        
        threshold <- input$perfThresh
        
        full %>% 
            select(school, G1) %>% 
            ggplot(aes(x=G1, fill=school)) +
            geom_density(alpha=0.25) +
            geom_vline(xintercept=threshold, color="red") +
            xlim(0, 20) +
            theme_bw() +
            labs(title="1st Period Grades", x="Score", y="Density")
        
    })
    
    # Density plots for both schools, class period 2
    output$g2Density <- renderPlot({
        
        threshold <- input$perfThresh
        
        full %>% 
            select(school, G2) %>% 
            ggplot(aes(x=G2, fill=school)) +
            geom_density(alpha=0.25) +
            geom_vline(xintercept=threshold, color="red") +
            xlim(0, 20) +
            theme_bw() +
            labs(title="2nd Period Grades", x="Score", y="Density")
        
    })
    
    # Density plots for both schools, class period 3
    output$g3Density <- renderPlot({
        
        threshold <- input$perfThresh
        
        full %>% 
            select(school, G3) %>% 
            ggplot(aes(x=G3, fill=school)) +
            geom_density(alpha=0.25) +
            geom_vline(xintercept=threshold, color="red") +
            xlim(0, 20) +
            theme_bw() +
            labs(title="3rd Period Grades", x="Score", y="Density")
        
    })
    
    # Density plots for both schools, average of class periods 1-3
    output$gMeanDensity <- renderPlot({
        
        threshold <- input$perfThresh
        
        full %>% 
            select(school, gMean) %>% 
            ggplot(aes(x=gMean, fill=school)) +
            geom_density(alpha=0.25) +
            geom_vline(xintercept=threshold, color="red") +
            xlim(0, 20) +
            theme_bw() +
            labs(title="Average Grades (All Periods)", x="Score", y="Density")
        
    })
    
    # Data table for selected period
    output$belowThreshTable <- renderDataTable({
        
        threshold <- input$perfThresh
        
        full %>%
            select(everything()) %>%
            filter(G3 <= threshold) %>%
            as_tibble()
        
    })

})
