#' Create a Boilerplate Package `R` Script.
#'
#' Creates a boilerplate package `R` script.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @examples
#' \dontrun{
#' pkg_r(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage"
#' )
#' }
#' @export
pkg_r <- function(pkg_dir = getwd(),
                  pkg_name) {
  root_r <- file.path(
    pkg_dir,
    pkg_name,
    "R"
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "zR",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  util_txt2file(
    text = output,
    dir = root_r,
    fn = "z.R"
  )
}
