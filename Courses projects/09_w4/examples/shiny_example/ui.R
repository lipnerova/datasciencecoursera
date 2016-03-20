library(shiny)

shinyUI(
  pageWithSidebar(
    
    headerPanel("Diabetes prediction"),
    
    sidebarPanel(
      
      # glucose
      numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5),

      # hist slider
      sliderInput('mu', 'Guess at the mean',value = 70, min = 62, max = 74, step = 0.05),
    
      # submit both values
      #submitButton('Submit')
      
      # text input
      textInput(inputId="text1", label = "Input Text1"),
      textInput(inputId="text2", label = "Input Text2"),
      
      # triggers certain actions only
      actionButton("goButton", "Go!")

    ),
    
    mainPanel(
      
      # glucose
      h3('Results of prediction'),
      h4('You entered'),
      verbatimTextOutput("inputValue"),
      h4('Which resulted in a prediction of '),
      verbatimTextOutput("prediction"),
      
      # hist
      plotOutput('newHist'),
      
      # text output
      p('Output text1'),
      textOutput('text1'),
      p('Output text2'),
      textOutput('text2'),
      p('as.numeric(text1)'),
      textOutput('text3'),
      p('Y'),
      textOutput('text4')

    )
  )
)