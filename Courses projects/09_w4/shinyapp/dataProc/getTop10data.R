# group the other event types as "OTHER"
dfFinal <- as.data.frame(group_by(dfField, Top10) %>% 
                           summarize(harmfulEvents = sum(countHarmful),
                                     harmField=sum(harmField))) %>%
  arrange(desc(harmField))

# estimate avg when fatalities
dfFinal$Average <- round(with(dfFinal, harmField/harmfulEvents),1)

# move "OTHER" at the end
dfFinal <- rbind (dfFinal[-which(dfFinal$Top10=="OTHER"), ],
                  dfFinal[which(dfFinal$Top10=="OTHER"), ])
rownames(dfFinal) <- NULL

# sort factors by decr fatalities
dfFinal$Top10 <- with(dfFinal, factor(Top10, levels=Top10[1:10]))

#return dfFinal
dfFinal