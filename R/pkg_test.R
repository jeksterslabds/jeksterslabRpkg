#' Create a Boilerplate Package Test File.
#'
#' Creates a boilerplate package test file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @examples
#' \dontrun{
#' pkg_test(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage"
#' )
#' }
#' @export
pkg_test <- function(pkg_dir = getwd(),
                     pkg_name) {
  tests <- file.path(
    pkg_dir,
    pkg_name,
    "tests"
  )
  testthat <- paste0(
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
    text = testthat,
    dir = tests,
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
      tests,
      "testthat"
    ),
    fn = "test_z.R"
  )
}
