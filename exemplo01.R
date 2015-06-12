library(shiny)
library(ggplot2)

ui <- fluidPage(
  plotOutput("plot", click = "plot_click"),
  verbatimTextOutput("info")
)

server <- function(input, output, session) {

  cars_log <<- log(cars)
  print(cars_log)
  
  output$plot <- renderPlot({
    ggplot(cars_log, aes(cars_log$speed, cars_log$dist)) +  geom_bar(stat="identity")
  })

  output$info <- renderText({
    xy_str <- function(e) {
      if(is.null(e)) return("NULL\n")
      paste0("x=", e$x, "\n")
    }
    x_Numeric <- function(e) {
      if(is.null(e)) return(0)
         e$x
    }    

    paste0(
      "click: x = ", xy_str(input$plot_click),
      "Nearest x-axis[?]: ", toString(which(abs(as.numeric(cars_log$speed)-as.numeric(x_Numeric(input$plot_click)))==min(abs(as.numeric(cars_log$speed)-as.numeric(x_Numeric(input$plot_click))))))
    )
     
  })  
}

shinyApp(ui, server)

