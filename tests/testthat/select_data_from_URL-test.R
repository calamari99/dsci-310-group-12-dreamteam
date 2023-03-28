library(testthat)
library(readr)
source("../../R/select_data_from_URL.R")

# Test case 1
test_that("read_data_from_url converts specified columns to factors", {
  url <- "https://raw.githubusercontent.com/calamari99/Facebook-Post-Predictor/main/data/dataset_Facebook.csv"
  name <- "test_data"
  data <- read_data_from_url(url, name)
  expect_true(is.factor(data$Type))
  expect_true(is.factor(data$Category))
  expect_true(is.factor(data$Paid))
})

# Test case 2
test_that("read_data_from_url returns data frame with same number of rows as original CSV", {
  url <- "https://raw.githubusercontent.com/calamari99/Facebook-Post-Predictor/main/data/dataset_Facebook.csv"
  name <- "test_data"
  data <- read_data_from_url(url, name)
  original_data <- read.csv2(url)
  expect_equal(nrow(data), nrow(original_data))
})