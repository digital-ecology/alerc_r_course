

library(readr)
library(readxl)

# reading a csv

records_csv <- readr::read_csv("data/myrecords.csv")


# reading an Excel spreadsheet

records_excel <- readxl::read_xlsx("data/TVERC_data.xlsx")

excel_sheet2 <- read_xlsx("data/TVERC_data.xlsx", sheet = 2)
excel_sheet1 <- read_xlsx("data/TVERC_data.xlsx", sheet = 1)

