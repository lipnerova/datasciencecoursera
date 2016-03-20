library(ggplot2)

#server side
shinyServer(function(input, output, session) {
  
# ------------------------------ MAP SETUP ------------------------------------ #  
  
  # USA map data
  getMapDB <- function () {
    df <- filter(stormList[[harmType()]], 
                 year>=years()[1] & 
                 year<=years()[2] & 
                 eventType %in% input$eventTypes) %>%
      group_by(State, stateName) %>%
      summarize(harmValue = sum(harmValue, na.rm=TRUE))
    return(df)
  }
  
  # tooltip displayed when hovering the USA map
  tooltip <- function () {
    ttYears <- ifelse(years()[1]==years()[2], paste(" in",years()[1]), paste(" from",years()[1],"to",years()[2]))
    ttContent <- paste0("'", input$radioHarmType, ttYears, ":<br><br>' + data.harmValue +")
    return(paste(ttBgn, ttContent, ttEnd))
  }
  
  # USA map chart
  createMap <- function () { 
    p1 <- ichoropleth(harmValue ~ State, ncuts=7, data = getMapDB(), 
                      legend=TRUE,
                      geographyConfig=list(popupTemplate=tooltip()))
    return(p1)
  }
  
  # USA map output 
  # updated only after the hist has been updated
  observeEvent(input$triggerCount1, {
    output$chart1 <- renderChart2 ({ isolate(createMap()) }) 
  })

  
  
# ------------------------------ MAP TITLE ------------------------------------ #  
  
  # total recorded harm 
  totalHarm <- eventReactive(v$mapTrigger, {
    total <- sum(getMapDB()$harmValue)
    total <- formatNumbers(total)
    return(total)
  })
  
  # USA map title output
  output$mapTitle <- renderUI({ h3(HTML(paste(
    paste0(input$radioHarmType, ", "),
    ifelse(years()[1]==years()[2], years()[1], 
           paste(years()[1]," - ",years()[2])),
    "</br>Total: ",
    totalHarm()
  ))) })


  
# ------------------------------ MAP LEGEND ----------------------------------- #  
# rMaps issue with shiny: the legend is not generated so we create it manually

  # legend labels (use same cut method as rMaps)
  getLegendText <- function (df) {
    x <- df$harmValue
    cut <- unique(round(quantile(x, seq(0, 1, 1/7), na.rm=TRUE),0))
    cut <- formatNumbers(cut)
    cutRange <- vector('character')
    for (i in 1:7) cutRange[i] <- paste0("(", cut[i], " - ", cut[i+1], "]")
    return(cutRange)
  }
  
  # legend items: colour square + legend labels
  legendDiv <- function(legendText) {
    LL <- vector("list",7) 
    for(i in 1:7) {
      LL[[i]] <- list(
        tags$div(
          class = "col-xs-12 legend",
          tags$span(style = sprintf(
            "width:1.5em; height:1.5em; border-radius:0.2em; background-color:%s; display:inline-block;",
            fillColors[8-i]
          )), 
          tags$span(class="legendText", legendText[8-i])
        )
      )
    }  
    return(LL) 
  }
  
  
  # legend block: title + items
  createLegend <- eventReactive(v$mapTrigger, {
    tags$div(
      tags$div(
        class = "col-xs-12",
        tags$span(style = sprintf(
          "font-weight: bold;"),
          paste(input$radioHarmType,"per state")
        )
      ),
      legendDiv(getLegendText(getMapDB()))
    )
  })
  
  # USA map legend output
  output$legend <- renderUI({ createLegend() })
  
  
  
# ------------------------------ HISTOGRAM ------------------------------------ #    
  
  # histogram
  createHist <- reactive({ 
    
    # we create the hist data
    df <- filter(stormList[[harmType()]], eventType %in% input$eventTypes) %>%
          group_by(year) %>%
          summarize(harmValue = sum(harmValue))
    
    # we create the hist
    p2 <- nPlot(harmValue ~ year, type = 'historicalBarChart', data = df)
    
    # we specify the width (responsive) & height
    # more details here: http://stackoverflow.com/questions/25371860/automatically-resize-rchart-in-shiny
    p2$addParams(width= session$clientData[["output_plot1_width"]], # here we get the width, 
                 height=200)
    
    #we grey out the unselected years
    p2$params$data$color <- c(rep('#ccc',years()[1] - 1950), 
                              rep('#1f77b4',years()[2] - years()[1] + 1), 
                              rep('#ccc',2011 - years()[2]))
    
    # we specify the y axis format
    # more formatting info here: https://github.com/mbostock/d3/wiki/Formatting 
    if (harmType() == "propDmg" | harmType() == "cropDmg") {
      p2$chart(yAxis.tickFormat = "#! function(d){ 
                 var prefix = d3.formatPrefix(d);
                 if (prefix.symbol == 'G') {prefix.symbol='B';}
                 return d3.round(prefix.scale(d),1) + prefix.symbol + '$'; 
              } !#"
      )
    }
    else {
      p2$chart(yAxis.tickFormat = "#! function(d){ return d3.format(',.2s')(d); } !#")
    }

    return(p2)
    
  })
  
  # the triggers are a convoluted way to make the map update only
  # after the histogram has been updated (there seems to be a conflict between
  # rCharts & rMaps during the rendering process)
  # note: the triggers are hidden using shinyjs
  observe({
    
    input$eventTypes
    input$yearSlider
    
    # update the histogram
    output$chart3 <- renderChart2({ isolate(createHist()) })
    
    # we cannot update variables nor inputs in observe
    # so we programatically create inputs (via outputs...) that are updated
    # at the same time as our histogram.
    # these updates will trigger the map update.
    # inspiration found here: http://stackoverflow.com/questions/27827962/r-shiny-bi-directional-reactive-widgets
    output$trigger1 <- renderUI({
      trigger2.value <- isolate(input$triggerCount2)
      trigger1.value <- if (is.null(trigger2.value)) 0 else trigger2.value
      numericInput('triggerCount1', 'Value', value = trigger1.value)
    })
    
    output$trigger2 <- renderUI({
      trigger1.value <- isolate(input$triggerCount1)
      trigger2.value <- if (is.null(trigger1.value)) 1 else trigger1.value
      numericInput('triggerCount2', 'Value', value = trigger2.value)
    })
    
    #the outputs are hidden (via shinyjs) but we want them to work anyway
    outputOptions(output, "trigger1", suspendWhenHidden = FALSE)
    outputOptions(output, "trigger2", suspendWhenHidden = FALSE)
    
  })
  
  # histogram title
  output$histTitle <- renderText(paste(input$radioHarmType,"per year"))
  

  
# ------------------------------ TOP 10 LIST ---------------------------------- #  
  
  # top10 data
  getTop10DB <- function () {
    data <- stormClean[, c("year","stateName",paste0(harmType(),"Top10"),harmType())]
    names(data) <- c("year","State","eventType", "harmValue")
    data <- filter(data, 
                   year>=years()[1] & 
                   year<=years()[2] & 
                   eventType %in% input$eventTypes) %>%
            arrange(desc(harmValue))
    data <- data[1:10, ]
    data$harmValue <- formatNumbers(data$harmValue)
    #names(data) <- c("year","State","Event Type", input$radioHarmType)
    return(data[1:10, ])
  }
  
  # top 10 table; we only have 10 elements that are always 
  # shown so we hide the search box & the pagination
  output$table <- DT::renderDataTable(
    DT::datatable(
      getTop10DB(), 
      colnames = c("year","State","Event Type", input$radioHarmType),
      rownames = FALSE,
      options = list(dom='t',
                     ordering = FALSE,
                     columnDefs = list(list(className = 'dt-center', targets = 0),
                                       list(className = 'dt-right', targets = 3)))
    )
  )
  
  
  
  
  
  
# ------------------------------ REACTIVE VARIABLES --------------------------- #   
 
  # reactive values
  v <- reactiveValues(mapTrigger = 0)
  
  # mapTrigger is used to prevent flickering during the switch
  # between harm types
  observeEvent(input$yearSlider, { v$mapTrigger <- v$mapTrigger+1 })
  observeEvent(input$eventTypes, { v$mapTrigger <- v$mapTrigger+1 })  
  
  # update the years 
  years <- reactive({input$yearSlider})
  
  # update the harm type
  harmType <- reactive({ harmTypes[input$radioHarmType] })
  
  # update the event types checkbox depending on the harm type (only the top10)
  observe({
    eventTypes <- harmLevels[[ harmType() ]]
    updateCheckboxGroupInput(session, "eventTypes", 
                             choices=eventTypes, 
                             selected=eventTypes)
  })
  

  
# ------------------------------ MISC FUNCTIONS ------------------------------- #   
  
  formatNumbers <- function (x) {
    newX <- ifelse(x>1e9, paste0(round(x/1e9,1),"B"), 
                   ifelse(x>1e6, paste0(round(x/1e6,1),"M"),
                          ifelse(x>1e3, paste0(round(x/1e3,1),"k"),
                                 x)))
    if (grepl("Dmg", harmType())) newX <- paste0(newX,"$")
    return (newX)
  }
  
  #output$value <- renderText({ totalHarm() }) 
  
})





