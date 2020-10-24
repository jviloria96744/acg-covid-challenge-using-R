createPlot <- function(data_type, covid_data) {
  if (!grepl("diff", data_type)) {
    if (grepl("log", data_type)) {
      agg_label <- "(Log Scaled) Aggregate"
    } else {
      agg_label <- "Aggregate"
    }
  } else {
    agg_label <- "Incremental"
  }
  
  base_data_type <- unlist(strsplit(data_type, "_", fixed=TRUE))[1]
  data_type_label <- switch(base_data_type, "cases"="Cases", "deaths"="Deaths", "recoveries"="Recoveries")
  
  return(
    ggplot(data = covid_data, aes_string(x="date",y=data_type)) + 
      geom_bar(stat="identity", fill="steelblue") + 
      labs(title=paste("Plot of Daily", agg_label, data_type_label), 
           x="Date", y =paste(agg_label, data_type_label)) + 
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size=20))
  )
} 