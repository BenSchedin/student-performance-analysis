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
library(rlang)

data <- read.csv("www/full.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Density plot for selected input
    output$gradeDensity <- renderPlot({
        
        threshold <- input$perfThresh
        period <- input$periodSel
        
        ggplot(data=full, aes(fill=school)) +
            geom_density(aes_string(x=period), alpha=0.25) +
            geom_vline(xintercept=threshold, color="red") +
            xlim(0, 20) +
            theme_bw() +
            labs(title="Grade Density", x="Score", y="Density")
        
    })
    
    # Data table for selected period
    output$belowThreshTable <- renderDataTable({
        
        threshold <- input$perfThresh
        period <- input$periodSel
        
        table <- full %>%
            select(everything()) %>%
            filter((!!sym(period)) <= threshold) %>%
            as_tibble()
        
        datatable(table, options=list(scrollX=TRUE, scrollCollapse=TRUE))
        
    })

})
