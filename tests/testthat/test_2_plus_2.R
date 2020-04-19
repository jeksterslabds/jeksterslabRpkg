#' ---
#' title: "Test: 2 + 2"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::github_document:
#'     toc: true
#' ---
#'
#+ setup
library(testthat)
context("Test 2 + 2.")
#'
#+ test that_01, echo=TRUE
test_that("2 + 2 = 4", {
  expect_equivalent(
    2 + 2,
    4
  )
})
