# library(testthat); devtools::load_all()

context("environments")

test_that("grow() loads from an environment", {
  expect_error(1 %myfun% 1)
  expect_equal(functions(), character(0))
  e = new.env()
  expect_equal(functions(e), character(0))
  e$myfun = function(x, y) x + y
  expect_equal(functions(e), "myfun")
  expect_equal(bunch(e), character(0))
  expect_warning(grow(myfun))
  expect_error(1 %myfun% 1)
  grow(myfun, from = e)
  expect_equal(1 %myfun% 1, 2)
  grow(myfun, from = e, to = e)
  expect_equal(functions(e), "myfun")
  expect_equal(bunch(e), "%myfun%")
})

test_that("grow() assigns in an environment", {
  expect_error(1 %myfun% 1)
  e = new.env()
  e$x = "some_object"
  e$y = new.env()
  e$myfun = function(x, y) x + y
  expect_warning(grow(myfun))
  expect_error(1 %myfun% 1)
  e2 = new.env()
  e2$z = "nope"
  expect_equal(ls(e2), "z")
  grow(myfun, from = e, to = e2)
  expect_equal(ls(e2), c("%myfun%", "z"))
  out = eval(parse(text = "1 %myfun% 1"), envir = e2)
  expect_equal(out, 2)
  expect_equal(functions(e), "myfun")
  expect_equal(bunch(e), character(0))
  expect_equal(functions(e2), character(0))
  expect_equal(bunch(e2), "%myfun%")
})
