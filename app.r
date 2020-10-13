library(shiny)
library(tidyverse)

covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

ui <- fluidPage(
  selectInput("state", 
              "State",
              choices ),
  plotOutput(outputId = "timeplot")
)

server <- function(input, output){
  output$timeplot <- renderPlot({
    ggplot(aes(x = cases, y = weekly, color = state)) + 
      scale_x_log10(label = scales::comma) + 
      scale_y_log10(label = scales::comma) + 
      geom_path() +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)