
x <- 0

library(shiny)

x <<- x + 1
y <<- 0

diabetesRisk <- function(glucose) glucose / 200

shinyServer(
  function(input, output) {
    
    # glucose
    output$inputValue <- renderPrint({input$glucose})
    output$prediction <- renderPrint({diabetesRisk(input$glucose)})
    
    # hist
    output$newHist <- renderPlot({
      hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
      mu <- input$mu
      lines(c(mu, mu), c(0, 200),col="red",lwd=5)
      mse <- mean((galton$child - mu)^2)
      text(63, 150, paste("mu = ", mu))
      text(63, 140, paste("MSE = ", round(mse, 2)))
    })
    
    # text
    y <<- y + 1
    
    x <- reactive({as.numeric(input$text1)+100}) 
    
    output$text1 <- renderText({x()})
    output$text2 <- renderText({x() + as.numeric(input$text2)})
    
    output$text3 <- renderText({
      if (input$goButton == 0) "You have not pressed the button"
      else if (input$goButton == 1) "you pressed it once"
      else "OK quit pressing it"
    })
    
    output$text4 <- renderText(y)
    
  }
)