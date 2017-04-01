# library(testthat); devtools::load_all()

context("grapes")

test_that("grapes() loads from ellipsis", {
  expect_error(1 %cbind% 1)
  expect_error(1 %rbind% 1)
  grapes(rbind, cbind, from = "base")
  expect_equal(1 %rbind% 1 %cbind% 1, matrix(1, nrow = 2, ncol = 2))
})

test_that("grapes() loads from ellipsis with quotes", {
  expect_error(1 %cbind% 1)
  expect_error(1 %rbind% 1)
  grapes("rbind", "cbind", from = "base")
  expect_equal(1 %rbind% 1 %cbind% 1, matrix(1, nrow = 2, ncol = 2))
})

test_that("grapes() loads from the list argument", {
  expect_error(1 %cbind% 1)
  expect_error(1 %rbind% 1)
  grapes(list = c("rbind", "cbind"), from = "base")
  expect_equal(1 %rbind% 1 %cbind% 1, matrix(1, nrow = 2, ncol = 2))
})

test_that("grapes() loads from workspace automatically", {
  expect_error(1 %myfun% 1)
  myfun = function(x, y) x + y
  grapes(myfun)
  expect_equal(1 %myfun% 1, 2)
})

test_that("grapes() loads from an environment", {
  expect_error(1 %myfun% 1)
  e = new.env()
  e$myfun = function(x, y) x + y
  expect_warning(grapes(myfun))
  expect_error(1 %myfun% 1)
  grapes(myfun, from = e)
  expect_equal(1 %myfun% 1, 2)
})

test_that("grapes() assigns in an environment", {
  expect_error(1 %myfun% 1)
  e = new.env()
  e$myfun = function(x, y) x + y
  expect_warning(grapes(myfun))
  expect_error(1 %myfun% 1)
  e2 = new.env()
  expect_equal(ls(e2), character(0))
  grapes(myfun, from = e, to = e2)
  expect_equal(ls(e2), "%myfun%")
  out = eval(parse(text = "1 %myfun% 1"), envir = e2)
  expect_equal(out, 2)
})

test_that("grapes() warns and stops correctly", {
  expect_warning(grapes("randomtext_aslkdasdkfjhkj", from = "base"))
  expect_warning(grapes("mtcars", from = "datasets"))
  expect_error(grapes(some_function, from = list()))
})
