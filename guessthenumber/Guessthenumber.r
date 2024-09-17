library(shiny)

ui <- fluidPage(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
  titlePanel("Number Guessing Game"),
  sidebarLayout(
    sidebarPanel(
      numericInput("guess", "Enter your guess:", value = 50, min = 1, max = 100),
      actionButton("submit", "Submit Guess"),
      actionButton("reset", "Reset")
    ),
    mainPanel(
      h3("Status:"),
      textOutput("status"),
      h3("Hint:"),
      textOutput("hint")
    )
  )
)
server <- function(input, output, session) {
  secret_number <- round(runif(1, min = 1, max = 100))
  
  observeEvent(input$submit, {
    guess <- input$guess
    
    if (guess == secret_number) {
      output$status <- renderText("Winner Winner Chicken Dinner Congratulations! You guessed the correct number!")
      output$hint <- renderText(NULL)
    } else if (guess < secret_number) {
      output$status <- renderText("Try a higher number.")
      output$hint <- renderText("Hint: The secret number is greater than your guess.")
    } else {
      output$status <- renderText("Try a lower number.")
      output$hint <- renderText("Hint: The secret number is less than your guess.")
    }
  })
  
  observeEvent(input$reset, {
    secret_number <<- round(runif(1, min = 1, max = 100))
    output$status <- renderText(NULL)
    output$hint <- renderText(NULL)
  })
}

shinyApp(ui,server)