# Academic Performance Analytics
# Ben Schedin
# Shiny Server Functionality

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
