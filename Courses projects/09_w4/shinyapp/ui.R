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

# ------------------------------ LEFT PANEL ----------------------------------- #   
  
  fluidRow(
    
    #left panel
    column(width = 9,
           
      # harm map
      box(width = NULL, status = "primary", solidHeader = TRUE, 
          title = tagList(htmlOutput("chartBoxTitle", container = tags$span, class = "centerSpan"),
                          tags$i(id="mapTT", shiny::icon("question-circle"))),
          bsTooltip("mapTT", 
                    "Total per state / per year, for the selected Years & Event Types",
                    "bottom"),

# ------------------------------ MAP ------------------------------------------ # 

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
        
        #fluidRow(textOutput("value")),

        
# ------------------------------ HISTOGRAM ------------------------------------ # 
        
        hr(),
        #fluidRow(
        #  column(width=1),
        #  column(width=10,
        #  tags$div(style="font-weight:bold;",textOutput("histTitle"))
        #  )
        #),
        fluidRow(
          #column( width = 1),
          column( 
            width = 12,
            showOutput("chart3", "nvd3", package="rCharts"), 
            plotOutput("plot1", height="1px") # to get its width value (as this widget takes 100% width by default)
          )
        )
      ),
        

# ------------------------------ YEAR SLIDER ---------------------------------- # 

      box(width = NULL, status = "warning", solidHeader = TRUE, 
        # year slider
        fluidRow(
          column( width = 1),
          column(
            width = 10,
            sliderInput(
              "yearSlider", 
              label = "",
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


# ------------------------------ RIGHT PANEL ---------------------------------- # 

    # right panel
    column(width = 3,

# ------------------------------ FILTERING OPTIONS ---------------------------- # 

      # Harm Type
      box(width = NULL, status = "warning", solidHeader = TRUE, 
          title = tagList("Filtering Options", tags$i(id="optionsTT", shiny::icon("question-circle"))),
          bsTooltip("optionsTT", 
                    "Event types depend on the harm category; filter by years is available below the histogram",
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
        shinyjs::hidden(numericInput("triggerMapUpdate", label="trigger map update", value=0))
      ),


# ------------------------------ TOP 10 --------------------------------------- # 

      fluidRow(
        infoBox(width = 12, textOutput("totalTitle"), textOutput("totalValue"), icon = icon("exclamation"), color="light-blue")
      ),


# ------------------------------ TOP 10 --------------------------------------- # 

      fluidRow(
        column(width = 12,
          box(width = NULL, status = "primary", solidHeader = TRUE, 
              title = tagList("Top 10", tags$i(id="top10TT", shiny::icon("question-circle"))),
              bsTooltip("top10TT", 
                        "Top 10",
                        "bottom"),
            
              radioButtons(
                "radioTop10", 
                label = NULL,
                inline = TRUE,
                choices = c("Events", "Event Types"), 
                selected = "Events"
              ),
              #conditionalPanel(
              #  condition = "input.radioTop10 == 'Events'",
                DT::dataTableOutput("table")
              #),
              #conditionalPanel(
              #  condition = "input.radioTop10 == 'Event Types'",
              #  showOutput("chart4", "highcharts", package="rCharts"), 
              #  plotOutput("plot2", height="1px") # to get its width value (as this widget takes 100% width by default)
              #)
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
