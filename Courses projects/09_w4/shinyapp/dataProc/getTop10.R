library (dplyr)

getTop10 <- function (df, field) {
  
  names(df)[names(df)==field] <- "harmField"
  
  # group by event type
  dfField <- as.data.frame(group_by(df, Event_Type) %>% 
                           summarize(countHarmful = length(which(harmField > 0)),
                                     harmField=sum(harmField)))
  
  # identify top 10
  dfField <- arrange(dfField,desc(harmField))
  dfField$Top10 <- factor(ifelse(row(dfField)<10,as.character(dfField$Event_Type), "OTHER")[,1])
  
  # group the other event types as "OTHER"
  dfFinal <- as.data.frame(group_by(dfField, Top10) %>% 
                           summarize(harmfulEvents = sum(countHarmful),
                                     harmField=sum(harmField))) %>%
                           arrange(desc(harmField))
  
  # move "OTHER" at the end
  dfFinal <- rbind (dfFinal[-which(dfFinal$Top10=="OTHER"), ],
                    dfFinal[which(dfFinal$Top10=="OTHER"), ])
  rownames(dfFinal) <- NULL
  
  # sort factors by decr fatalities
  dfField$Top10 <- factor(dfField$Top10, levels=dfFinal$Top10[1:10])
  
  # updatelevels of dfField
  #levels(dfField$Top10) <- levels(dfFinal$Top10)
  
  #return event types
  dfField[, c(1, 4)]
}

addTop10 <- function (df, field) {
  
  top10 <- getTop10 (df, field)
  names(top10)[2] <- paste0(field, "Top10")
 
  dfJoin <- left_join (df, top10, by="Event_Type")
  dfJoin
  
}

tableTop10 <- function (df, field) {
  
  stormLight <- df[, c("year", "State", "stateName", field, paste0(field,"Top10"))]
  names(stormLight) <- c("year", "State", "stateName", "harmValue", "eventType")
    
  stormSummary <- group_by(stormLight, year, State, stateName, eventType) %>%
                  summarize(harmValue=sum(harmValue)) %>% 
                  filter (harmValue > 0)
  
  stormSummary
  
}