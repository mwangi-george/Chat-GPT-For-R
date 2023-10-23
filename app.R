# # Install dependencies
# install.packages(c("devtools", "openai"))
# devtools::install_github("isinaltinkaya/gptchatteR")

# Load package that allows you to interface with ChatGPT
library(gptchatteR)
pacman::p_load(shinydashboard, tidyverse, shiny)

# Replace the below with your OpenAI API key
chatter.auth("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")

# Initiate chat session with ChatGPT; type ?chatter.create for additional options
chatter.create()




header <- dashboardHeader(title = "Chat GPT for R")

sidebar <- dashboardSidebar(
  actionButton(
    "submit", "Submit", 
    icon = icon("paper-plane", lib = "font-awesome"),
    style = "color: #ffffff; 
                       background-color: steelblue; /* Use a professional blue color */
                       border: 2px solid #007BFF; /* Add a solid border for a cleaner look */
                       border-radius: 20px; /* Round the corners for a softer appearance */
                       width: 100px;
                       height: 40px; /* Slightly increase the height for better visibility */
                       text-align: center; /* Center the text horizontally */
                       line-height: 40px; /* Center the text vertically */
                       position: absolute; /* Use absolute positioning for centering */
                       top: 50%;
                       left: 50%;
                       transform: translate(-50%, 50%); /* Center the button */
                       font-family: Arial, sans-serif; /* Choose a professional font */
                       font-size: 14px; /* Adjust font size as needed */
                       cursor: pointer; /* Show pointer cursor on hover */
                       transition: background-color 0.3s, color 0.3s; /* Add a smooth hover effect */
                      "
  )
)

body <- dashboardBody(
  fluidRow(
    box("Chat GPT", width = 4, textInput("query", label = "Query")),
    box("Result", width = 8, textOutput("results"))
  )
)

ui <- dashboardPage(header, sidebar, body)

server <- function(input, output, session){
  
  observeEvent(input$submit, {
    # Talk to ChatGPT 
    response <- chatter.chat(input$query, return_response = TRUE, feed = T)
    output$results <- renderText({
      
      # Extract the response from ChatGPT
      response$choices[[1]]
      
    })
  })
  
}

shinyApp(ui, server)
