path <- "https://covid.ourworldindata.org/data/owid-covid-data.csv"
df <- suppressMessages(
  suppressWarnings(
    read_csv(path, col_types = cols())
  )
)
write_csv(df, "data/data_raw.csv")
