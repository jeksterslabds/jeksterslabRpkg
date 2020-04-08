#' Create a Boilerplate Package Test File.
#'
#' Creates a boilerplate package test file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_rbuildignore
#' @examples
#' \dontrun{
#' pkg_test(
#'   pkg_root = getwd()
#' )
#' }
#' @export
pkg_test <- function(pkg_root,
                     msg = "test_z.R file path:") {
  pkg_name <- basename(pkg_root)
  root_tests <- file.path(
    pkg_root,
    "tests"
  )
  root_testthat <- paste0(
    "library(testthat)",
    "\n",
    "library(",
    pkg_name,
    ")",
    "\n\n",
    "test_check(\"",
    pkg_name,
    "\")"
  )
  util_txt2file(
    text = root_testthat,
    dir = root_tests,
    fn = "testthat.R"
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "test_zR",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  output <- sub(
    pattern = "BOILERPLATEPACKAGE",
    replacement = pkg_name,
    x = output
  )
  util_txt2file(
    text = output,
    dir = file.path(
      root_tests,
      "testthat"
    ),
    fn = "test_z.R",
    msg = msg
  )
}
