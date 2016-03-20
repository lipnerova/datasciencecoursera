shinyUI( navbarPage( 
  
  title="Machine Learning Performance", id="nav",
                   
  tabPanel("Synopsis", 
           
    sidebarPanel(
      
      # model selection
      radioButtons (
        "radio", label = h3("Select a training model"),
        choices = list("Regression Trees" = 1, "Random Forest" = 2, "Stochastic Gradient Boosting" = 3), 
        selected = 1
      )
      
      # slider for random forest
      
      # pca yes/no
      
      # pca threshold (default 0.95)
      
      # cross validation
      
      # number of folds
      
      
    )
  
      
  ),
                   
  tabPanel("Test",
         
    fluidRow(
      column(12, 
        # glucose
        numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5)
      )
    )
      
  )

))