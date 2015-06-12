library(shiny)
library(ggplot2)

ui <- fluidPage(
  plotOutput("plot", click = "plot_click"),
  verbatimTextOutput("info")
)

server <- function(input, output, session) {

  output$plot <- renderPlot({
    ggplot(cars, aes(speed, dist)) +  geom_bar(stat="identity")
  })

  output$info <- renderText({
    xy_str <- function(e) {
      if(is.null(e)) return("NULL\n")
      paste0("x=", round(e$x, 1), "\n")
    }
    x_Numeric <- function(e) {
      if(is.null(e)) return(0)
      round(e$x, 1)
    }    

    paste0(
      "click: x = ", xy_str(input$plot_click),
      "Nearest x-axis[?]: ", toString(which(abs(as.numeric(cars$speed)-as.numeric(x_Numeric(input$plot_click)))==min(abs(as.numeric(cars$speed)-as.numeric(x_Numeric(input$plot_click))))))
    )
     
  })  
}

shinyApp(ui, server)

