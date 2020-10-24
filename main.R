source("src/extract_data.R")
source("src/transform_data.R")
source("src/plots.R")
library(ggplot2)

nyt_url <- "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv"
jh_url <- "https://raw.githubusercontent.com/datasets/covid-19/master/data/time-series-19-covid-combined.csv"

nyt_data <- getData(nyt_url)
jh_data <- getData(jh_url)

if(!(hasData(nyt_data) && hasData(jh_data))) {
  quit()
} else {
  print("Data Downloaded Successfully")
}

jh_data <- filterData(jh_data)

print("Johns Hopkins Data Filtered Successfully")

covid_data <- mergeData(nyt_data, jh_data)

print("NYT and Johns Hopkins Data Merged Successfully")

if(!hasValidDataTypes(covid_data)) {
  quit()
} else {
  print("Data Validated Successfully")
}

covid_data <- addFields(covid_data)
print("Added Fields Successfully")

write.csv(covid_data, "data\\transformed_data.csv", row.names = FALSE)
print("Data Written to CSV Successfully")

pdf("figs\\COVID-19_Plots.pdf")

for (col in colnames(covid_data)) {
  if (!(col %in% c("date", "date_diff", "month", "day_of_week"))) {
    print(createPlot(col, covid_data))    
  }
}

dev.off()
