filterData <- function(data) {
  data <- data[data$Country.Region == "US", ]
  data <- data[, names(data) %in% c("Date", "Recovered")]
  return(data)
}

mergeData <- function(nyt_data, jh_data) {
  merged_data <- merge(x=nyt_data, y=jh_data, by.x="date", by.y="Date")
  colnames(merged_data) <- c("date", "cases", "deaths", "recoveries")
  return(merged_data)
}

hasValidDataTypes <- function(data) {
  cols <- colnames(data)
  for (col in cols) {
    if (col != "date") {
      print(paste("Validating that", col, "contain only integer data"))
      if (!(all(data[,col] == floor(data[,col])))) {
        print(paste(col, "contains non-integer data"))
        return(FALSE)
      }
      
      print(paste("Validating that", col, "contain only positive counts"))
      if (any(data[,col] < 0)) {
        print(paste(col, "contains negative counts"))
        return(FALSE)
      }
    } 
  }
  
  
  return(TRUE)
}

addFields <- function(my_data) {
  my_data$date <- as.Date(my_data$date)
  print("Date field converted successfully")
  
  date_diff <- as.integer(tail(my_data$date, -1) - head(my_data$date, -1))
  incremental_values <- data.frame(diff(as.matrix(my_data[,c("cases", "deaths", "recoveries")])))
  
  incremental_data <- cbind(date_diff, incremental_values)
  incremental_data <- rbind(as.integer(c(0, 0, 0, 0)), incremental_data)
  colnames(incremental_data) <- c("date_diff", "cases_diff", "deaths_diff", "recoveries_diff")
  my_data <- cbind(my_data, incremental_data)
  print("Incremental Data Created")
  
  my_data$month <- months(my_data$date)
  my_data$day_of_week <- weekdays(my_data$date)
  print("Month/Day of Week Fields Added")
  
  for (col in c("cases", "deaths", "recoveries")) {
    log_col_name <- paste(col, "log", sep="_")
    my_data[log_col_name] = log(my_data[, col])
    na_values <- !is.finite(my_data[, log_col_name])
    my_data[na_values, log_col_name] <- 0
  }
  print("Aggregate Log Fields Added")
  
  
  return(my_data)
}