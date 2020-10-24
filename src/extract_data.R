getData <- function(url) {
  data <- tryCatch({
    read.csv(url)
  }, error = function(err) {
    print(paste("MY_Error:  ",err))
    quit()
    return(err)  
  })
  
  return(data)
}

hasData <- function(data) {
  if (0 %in% dim(data)) {
    return(FALSE)
  }
  return(TRUE)
}