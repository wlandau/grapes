# library(testthat); devtools::load_all()

context("errors")

test_that("grow() warns and stops correctly", {
  expect_warning(grow("randomtext_aslkdasdkfjhkj", from = "base"))
  expect_warning(grow("mtcars", from = "datasets"))
  expect_error(grow(some_function, from = list()))
})
