# server.R
library(shiny)
source("helpers.R")
counties <- readRDS("data/counties.rds")
library(maps)
library(mapproj)

shinyServer(
  function(input, output) {
    output$map <- renderPlot({
      data <- switch(input$var, "Percent White" = counties$white,
                                  "Percent Asian" = counties$asian,            
                                  "Percent Black" = counties$black,
                                  "Percent Hispanic" = counties$hispanic)
      color <- switch(input$var, "Percent Hispanic" = "darkorange",
                                  "Percent White" = "darkgreen",
                                  "Percent Asian" = "darkviolet",
                                  "Percent Black" = "black")
      legend <- switch(input$var, "Percent White" = "% White",
                                  "Percent Asian" = "% Asian",
                                  "Percent Black" = "% Black",
                                  "Percent Hispanic" = "% Hispanic")
      percent_map(var = data, color = color, 
                  legend.title = legend, 
                  max = input$range[2], min = input$range[1])
    })
  }
)
    