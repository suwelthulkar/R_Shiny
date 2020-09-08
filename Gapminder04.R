# Add a checkbox input to the UI with ID "fit", a label of "Add line of best fit", and an initial state of being unchecked.
# Add code to the server so that when the input is checked, a line of best fit is added to the plot. The code for adding a line of best fit is provided.


# Define UI for the application
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textInput("title", "Title", "GDP vs life exp"),
      numericInput("size", "Point size", 1, 1),
      # Add a checkbox for line of best fit
      checkboxInput("fit","Add line of best fit", value = FALSE)
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  output$plot <- renderPlot({
    p <- ggplot(gapminder, aes(gdpPercap, lifeExp)) +
      geom_point(size = input$size) +
      scale_x_log10() +
      ggtitle(input$title)
    
    # When the "fit" checkbox is checked, add a line
    # of best fit
    if (input$fit == TRUE) {
      p <- p + geom_smooth(method = "lm")
    }
    p
  })
}

# Run the application
shinyApp(ui = ui, server = server)