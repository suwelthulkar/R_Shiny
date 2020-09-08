# Add a numeric input to the UI with ID "size", a label of "Point size", a default value of 1, and a minimum value of 1.
# Add code to the server so that the numeric input will determine the point size in the plot.



# Define UI for the application
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textInput("title", "Title", "GDP vs life exp"),
      # Add a size numeric input
      numericInput("size", "Point size", value = 1, min = 1)
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  output$plot <- renderPlot({
    ggplot(gapminder, aes(gdpPercap, lifeExp)) +
      # Use the size input as the plot point size
      geom_point(size = input$size) +
      scale_x_log10() +
      ggtitle(input$title)
  })
}

# Run the application
shinyApp(ui = ui, server = server)