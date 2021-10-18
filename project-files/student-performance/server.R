# Academic Performance Analytics
# Ben Schedin
# Shiny Server Functionality

library(shiny)
library(tidyverse)
library(rlang)
library(ggcorrplot)

full <- read.csv("www/full.csv")

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
    
    # Habits - Failures
    output$failures <- renderPlot({
        
        temp <- full %>% count(failures, sex)
        
        ggplot(temp, aes(fill=sex, x=failures, y=n)) +
            geom_bar(position="stack", stat="identity") +
            scale_x_continuous(breaks=round(seq(min(temp$failures), max(temp$failures), by=1))) +
            theme_bw() +
            labs(title="Course Failures", x="Number of Failures", y="Count")
        
    })
    
    # Habits - Absences
    output$absences <- renderPlot({
        
        temp <- full %>% count(absences, sex)
        
        ggplot(temp, aes(fill=sex, x=absences, y=n)) +
            geom_bar(position="stack", stat="identity") +
            scale_x_continuous(breaks=round(seq(min(temp$absences), max(temp$absences), by=1))) +
            theme_bw() +
            labs(title="Absences", x="Number of Absences", y="Count")
        
    })
    
    # Habits - Study time
    output$studyTime <- renderPlot({
        
        temp <- full %>% count(studytime, sex)
        
        ggplot(temp, aes(fill=sex, x=studytime, y=n)) +
            geom_bar(position="stack", stat="identity") +
            scale_x_continuous(breaks=round(seq(min(temp$studytime), max(temp$studytime), by=1))) +
            theme_bw() +
            labs(title="Study Time", x="Hours Spent", y="Count")
        
    })
    
    # Habits - Free time
    output$freeTime <- renderPlot({
        
        temp <- full %>% count(freetime, sex)
        
        ggplot(temp, aes(fill=sex, x=freetime, y=n)) +
            geom_bar(position="stack", stat="identity") +
            scale_x_continuous(breaks=round(seq(min(temp$freetime), max(temp$freetime), by=1))) +
            theme_bw() +
            labs(title="Free Time", x="Hours Spent", y="Count")
        
    })
    
    # Grades Predictors - Regression Model
    output$gradesRegression <- renderPlot({
        
        # Filtering numeric variables
        filtered <- full %>%
            select("age", "Medu", "Fedu", "traveltime", "studytime", "failures", "famrel", "freetime", "goout", "Dalc", "Walc", "health", "absences", "G1", "G2", "G3", "gMean")
        
        # Defining plot variables
        explVar <- input$expVarSel
        respVar <- input$respVarSel
        
        # Fitting the model
        lm <- lm(eval(parse(text=explVar)) ~ eval(parse(text=respVar)), data=filtered)
        
        # Plotting the model
        ggplot(filtered, aes_string(x=explVar, y=respVar)) +
            geom_point() +
            stat_smooth(method="lm", col="red") +
            theme_bw() +
            labs(title="Regression Model")
        
    })
    
    # Grade Predictors - Correlation Table
    output$gradesCorrPlot <- renderPlot({
        
        # Filtering on numeric data
        fullNum <- full %>%
            select(where(is.numeric))
        
        # Computing correlations between variables
        varCor <- cor(fullNum)
        
        # Plotting correlation table
        ggcorrplot(varCor) + 
            theme(axis.text.x = element_text(size=11, angle=90, hjust=0.99, vjust=0.3), axis.text.y=element_text(size=11)) + 
            labs(title = "Variable Correlations", x="Variable 1", y="Variable 2")
        
    })

})
