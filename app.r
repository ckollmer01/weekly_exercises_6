library(shiny)
library(tidyverse)
library(dplyr)
library(rsconnect)

covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

ui <- fluidPage(
  selectInput("state", 
              "State",
              choices = unique(covid19$state),
              multiple = TRUE),    
  submitButton(text = "View Plot"),
  plotOutput(outputId = "timeplot")
)

server <- function(input, output){
  output$timeplot <- renderPlot({
    covid19 %>%
      filter(cases >= 20,
             state %in% input$state) %>%
      group_by(state) %>% 
      mutate(days_since_20 = row_number()) %>%
    ggplot() + 
      geom_path(aes(x = days_since_20, y = cases, color = state))+
      theme_minimal() +
      labs(x = "Days Since 20 Cases",
           y = "Total Cases",
           color = "State")
  })
}

shinyApp(ui = ui, server = server)