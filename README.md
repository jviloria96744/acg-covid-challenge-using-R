# ACloudGuru September 2020 Challenge (using R)

This is another implementation of the ETL steps from the September 2020 ACloudGuru Challenge (Event-Driven Python ETL) done using R.

This ETL takes two COVID-19 Data Sources (NY Times and Johns Hopkins), applies some filters/transformations, adds fields and writes the data to a CSV

## Project Structure

### data
This is the data (csv file) created by the ETL Process.

### figs
This folder contains all plots created from this data.  Plots have been created for Aggregate/Incremental Cases/Deaths/Recoveries.  Log scaled plots are also included.

### src
This folder contains all helper functions called by Main.r.  The folder contains three files,

- `extract_data.R` - This script contains functions to download the data from their respective public GitHub repos and does a basic check to make sure the download completes properly

- `transform_data.R` - This script contains functions that are responsible for data processing.  These transformations include filtering for only US data, data validation checks for numeric fields, date field conversions and adding derived fields

- `plots.R` - This script contains a function that creates a plot based on the `ggplot2` library.  The plot is parameterized based on what data field we are interested in, eg. cases, deaths or recoveries and whether or not the data is aggregated or incremental.