# library(testthat); devtools::load_all()

context("examples")

test_that("bunch() example", {
  expect_equal(bunch(), character(0))
  grow(rbind, from = "base") 
  expect_equal(bunch(), "%rbind%")
  myfun = function(x, y) x + y
  env = new.env()
  grow(myfun, to = env)
  expect_equal(bunch(), "%rbind%")
  expect_equal(bunch(from = env), "%myfun%")
})

test_that("grow() example", {
  grow(rbind, from = "base")
  expect_equal(nrow(sleep), 20)
  longer = sleep %rbind% sleep %rbind% sleep
  expect_equal(nrow(longer), 60)
})

test_that("functions() example", {
  expect_equal(functions(), character(0))
  myfun = function(x, y) x + y
  expect_equal(functions(), "myfun")
  expect_true(length(functions("grapes")) > 0)
  expect_true(length(functions("knitr")) > 0)
  detach("package:knitr")
})
