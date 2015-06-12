library(shiny)
library(ggplot2)

ui <- fluidPage(
  plotOutput("plot", click = "GGPlot_click")
)

server <- function(input, output, session) {
  v <- reactiveValues(
    click1 = NULL  
  )

  # Handle clicks on the plot
  observeEvent(input$GGPlot_click, {
      v$click1 <- input$GGPlot_click
  })

  observeEvent(input$reset, {
    v$click1 <- NULL
  })

  output$plot <- renderPlot({
    pg <- ggplot(cars, aes(speed, dist)) +  geom_bar(stat="identity")

    print(pg)
    if (!is.null(v$click1$x))
      print(paste(v$click1$x, v$click1$y, sep = " / "))
      #print(v$click1)
  })
}

shinyApp(ui, server)
