library(testthat)
library(readr)
source("../../R/clean_data.R")

# Test statement 1
test_that("clean_data returns a data frame", {
  # Create a sample data frame
  facebook <- data.frame(Type = c("Photo", "Status", "Link", "Video"),
                         comment = c(20, 30, 40, 50),
                         like = c(100, 200, 300, 400),
                         share = c(5, 10, 15, 20),
                         Total_Interactions = c(125, 240, 355, 470),
                         Paid = c(1, 0, 0, 1),
                         Lifetime_Post_Total_Impressions = c(1000, 2000, 3000, 4000),
                         Lifetime_Post_Total_Reach = c(500, 1000, 1500, 2000))
  
  # Call clean_data function
  cleaned_data <- clean_data(facebook)
  
  # Check if the result is a data frame
  expect_true(is.data.frame(cleaned_data))
})

# Test statement 2
test_that("clean_data returns a summary table with expected columns", {
  # Create a sample data frame
  facebook <- data.frame(Type = c("Photo", "Status", "Link", "Video"),
                         comment = c(20, 30, 40, 50),
                         like = c(100, 200, 300, 400),
                         share = c(5, 10, 15, 20),
                         Total_Interactions = c(125, 240, 355, 470),
                         Paid = c(1, 0, 0, 1),
                         Lifetime_Post_Total_Impressions = c(1000, 2000, 3000, 4000),
                         Lifetime_Post_Total_Reach = c(500, 1000, 1500, 2000))
  
  # Call clean_data function
  cleaned_data <- clean_data(facebook)
  
  # Check if the result contains expected columns
  expect_true("Type" %in% colnames(cleaned_data))
  expect_true("unpaid" %in% colnames(cleaned_data))
  expect_true("paid" %in% colnames(cleaned_data))
})