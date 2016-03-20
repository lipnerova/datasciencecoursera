library(shiny)
library(shinydashboard)
library(rCharts)
library(rMaps)
library(shinyjs) #used to hide some inputs
library(shinyBS) #used for  tooltips

header <- dashboardHeader(
  title = "StormReport"
)

header$children[[2]]$children <-  tags$span("Storm", tags$b("Report"))


body <- dashboardBody(
  
  #enable shinyjs
  useShinyjs(),
  
  # css to properly resize the map svg
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  
  fluidRow(
    
    #left panel
    column(width = 9,
           
      # harm map
      box(width = NULL, status = "primary", solidHeader = TRUE, 
          title = tagList("Impact of extreme weather in the USA", 
                          tags$i(id="mapTT", shiny::icon("question-circle"))),
          bsTooltip("mapTT", 
                    "you can filter harm types & event types",
                    "bottom"),
          #title
        fluidRow(
          column(
            width = 12, 
            tags$div(
              htmlOutput("mapTitle", container = tags$span, class = "centerSpan")
            )
          )
        ),
        
        #map & legend
        fluidRow(
          column(width=2),
          column(
            width = 8,
            showOutput("chart1", "datamaps", package="rMaps")
          ),
          column(
            width = 2, 
            uiOutput("legend")
          )
        ),
        hr(),
        fluidRow(textOutput("value")),
        
        #histogram
        fluidRow(
          column(width=1),
          column(width=10,
            tags$div(style="font-weight:bold;",textOutput("histTitle"))
          )
        ),
        fluidRow(
          #column( width = 1),
          column( width = 12,
            showOutput("chart3", "nvd3", package="rCharts"), 
            plotOutput("plot1", height="1px") # to get its width value (as this widget takes 100% width by default)
          )
        ),
        
        # year slider
        fluidRow(
          column( width = 1),
          column(
            width = 10,
            sliderInput(
              "yearSlider", 
              label = "Year Range",
              step=1,
              sep = "",
              min = 1950, 
              max = 2011, 
              value = c(1950, 2011)
            )
          )
        )
      )
    ),
    
    # right panel
    column(width = 3,
           
      # Harm Type
      box(width = NULL, status = "warning", solidHeader = TRUE, 
          title = tagList("Options", tags$i(id="optionsTT", shiny::icon("question-circle"))),
          bsTooltip("optionsTT", 
                    "you can filter harm types & event types",
                    "bottom"),
        #h5("Type"),
        tags$div(style="font-weight:bold;","Harm Category"),
        tags$div(class = "twocol",
          radioButtons(
            "radioHarmType", 
            label = NULL,
            choices = c("Fatalities", "Injuries", "Property Damage", "Crop Damage"), 
            selected = "Fatalities"
          )
        ),
        hr(),
        tags$div(style="font-weight:bold;","Event Type"),
        tags$div(class = "twocol",
                 checkboxGroupInput(
                   "eventTypes", 
                   label=NULL,
                   choices = harmLevels[["Fatalities"]],
                  selected = harmLevels[["Fatalities"]]
                 )
        ),
        shinyjs::hidden(uiOutput('trigger1')),
        shinyjs::hidden(uiOutput('trigger2'))
      ),
      
      # State
      fluidRow(
        column(width = 12,
          box(width = NULL, status = "primary", solidHeader = TRUE, 
              title = tagList("Top 10 Events", tags$i(id="top10TT", shiny::icon("question-circle"))),
              bsTooltip("top10TT", 
                        "Top 10 Events",
                        "bottom"),
            
              radioButtons(
                "radioTop10", 
                label = NULL,
                inline = TRUE,
                choices = c("Top 10 Events", "Event Types"), 
                selected = "Top 10 Events"
              ),
              DT::dataTableOutput("table")
          )
        )
      )
    )
  )
)



         

shinyUI(dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
))
