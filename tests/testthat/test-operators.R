# library(testthat); devtools::load_all()

context("operators")

test_that("grow() loads from ellipsis", {
  expect_error(1 %cbind% 1)
  expect_error(1 %rbind% 1)
  expect_equal(bunch(), character(0))
  expect_equal(functions(), character(0))
  grow(rbind, cbind, from = "base")
  expect_equal(bunch(), c("%cbind%", "%rbind%"))
  expect_equal(functions(), character(0))
  expect_equal(1 %rbind% 1 %cbind% 1, matrix(1, nrow = 2, ncol = 2))
})

test_that("grow() loads from ellipsis with quotes", {
  expect_error(1 %cbind% 1)
  expect_error(1 %rbind% 1)
  expect_equal(bunch(), character(0))
  grow("rbind", "cbind", from = "base")
  expect_equal(bunch(), c("%cbind%", "%rbind%"))
  expect_equal(1 %rbind% 1 %cbind% 1, matrix(1, nrow = 2, ncol = 2))
})

test_that("grow() loads from the list argument", {
  expect_error(1 %cbind% 1)
  expect_error(1 %rbind% 1)
  expect_equal(bunch(), character(0))
  grow(list = c("rbind", "cbind"), from = "base")
  expect_equal(bunch(), c("%cbind%", "%rbind%"))
  expect_equal(1 %rbind% 1 %cbind% 1, matrix(1, nrow = 2, ncol = 2))
})

test_that("grow() loads from workspace automatically", {
  expect_error(1 %myfun% 1)
  expect_equal(functions(), character(0))
  myfun = function(x, y) x + y
  expect_equal(functions(), "myfun")
  expect_equal(bunch(), character(0))
  grow(myfun)
  expect_equal(bunch(), c("%myfun%"))
  expect_equal(functions(), "myfun")
  expect_equal(1 %myfun% 1, 2)
})
