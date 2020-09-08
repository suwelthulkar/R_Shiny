# Add a selectInput() to the UI with ID "continents" and a label of "Continents", with the default continent set to "Europe".
# The choices in the list should be all the different continents that exist in the gapminder dataset.
# Allow the user to select multiple continents simultaneously.
# Add code to the server such that only data for the selected continent is shown, by subsetting the gapminder dataset.



ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textInput("title", "Title", "GDP vs life exp"),
      numericInput("size", "Point size", 1, 1),
      checkboxInput("fit", "Add line of best fit", FALSE),
      radioButtons("color", "Point color",
                   choices = c("blue", "red", "green", "black")),
      # Add a continent dropdown selector
      selectInput("continents", "Continents",
                  choices = levels(unique(gapminder$continent)),
                  multiple = TRUE,
                  selected = "Europe")
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  output$plot <- renderPlot({
    # Subset the gapminder dataset by the chosen continents
    data <- subset(gapminder,
                   continent %in% input$continents)
    
    p <- ggplot(data, aes(gdpPercap, lifeExp)) +
      geom_point(size = input$size, col = input$color) +
      scale_x_log10() +
      ggtitle(input$title)
    
    if (input$fit) {
      p <- p + geom_smooth(method = "lm")
    }
    p
  })
}

shinyApp(ui = ui, server = server)