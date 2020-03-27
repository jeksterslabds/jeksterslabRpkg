#' ---
#' title: "Test: 2 + 2"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::html_vignette:
#'     toc: true
#' ---

#+ setup
library(testthat)
library(jeksterslabRpkg)

#+ test that_01, echo=FALSE
test_that("2 + 2 = 4", {
  expect_equivalent(
    2 + 2,
    4
  )
})
