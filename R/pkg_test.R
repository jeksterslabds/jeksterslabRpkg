#' Create Boilerplate Package Test File.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @examples
#' pkg_test(pkg_dir = tempdir(), pkg_name = "boilerplatePackage")
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
      "test_z.R",
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
