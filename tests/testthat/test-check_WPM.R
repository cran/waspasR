library(testthat)        # Load testthat package
library(waspasR)         # Load our package

#### Test WPM Calculation function
# Creates the test DB
data(choppers)
flags <- sliceData(choppers, "F")
values <- sliceData(choppers, "V")
norm_values <- normalize(values, flags)
vec_weights <- sliceData(choppers, "W")
# Test vector of Weights X matrix of values dimensions
test_that("calcWPM() checks wrong dimensions...", {
  temp_vec <- vec_weights[, -1]
  wrong <- calcWPM(norm_values, temp_vec)
  expect_equal(wrong,
    "Error: The weight vector must be the same size as the number of criteria")
})

# Test Vector of Weights contents
test_that("calcWPM() checks Vector of Weights... Not OK", {
  temp_vec <- vec_weights
  temp_vec[1, 1] <- "1"
  wrong <- calcWPM(norm_values, temp_vec)
  expect_equal(wrong, "Error: Values in Vector of Weights must summarize 1")
  temp_vec <- vec_weights
  temp_vec[1, 1] <- "non numeric-alike value"
  wrong <- calcWPM(norm_values, temp_vec)
  expect_equal(wrong, "W[P] Error: Some non numeric - alike value was found")
})

# Covers tryCatch Errors
test_that("calcWPM() checks Error.", {
  expect_error(calcWPM())
})
