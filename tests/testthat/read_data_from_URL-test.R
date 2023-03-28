library(testthat)
library(readr)
source("../../R/read_data_from_URL.R")

# Test case 1
test_that("read_data_from_url converts specified columns to factors", {
  url <- "https://raw.githubusercontent.com/calamari99/Facebook-Post-Predictor/main/data/dataset_Facebook.csv"
  facebook <- read_data_from_url(url)
  expect_true(is.factor(facebook$Type))
  expect_true(is.factor(facebook$Category))
  expect_true(is.factor(facebook$Paid))
})

# Test case 2
test_that("read_data_from_url returns data frame with same number of rows as original CSV", {
  url <- "https://raw.githubusercontent.com/calamari99/Facebook-Post-Predictor/main/data/dataset_Facebook.csv"
  data <- read_data_from_url(url)
  original_data <- read.csv2(url)
  expect_equal(nrow(data), nrow(original_data))
})