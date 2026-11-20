# Run from this directory with the Delaware 2023 school sampling CSV.
library(readr)
library(dplyr)
args <- commandArgs(trailingOnly = TRUE)
stopifnot(length(args) == 1)
raw <- read_csv(args[1], show_col_types = FALSE, col_types = cols(
  `Result (PPB)` = col_number(), .default = col_character()
))
fields <- c("District", "School", "Location Description", "Sample Type", "Result (PPB)")
clean <- raw[complete.cases(raw[, fields]), ]
districts <- clean |>
  group_by(district = District) |>
  summarise(samples = n(), max_ppb = max(`Result (PPB)`), .groups = "drop")
stopifnot(sum(districts$samples) == nrow(clean))
write_csv(districts, "districts.csv")
