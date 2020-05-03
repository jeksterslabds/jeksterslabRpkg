#' Create a Boilerplate Package `R` Script.
#'
#' Creates a boilerplate package `R` script.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_rbuildignore
#' @examples
#' \dontrun{
#' pkg_r(
#'   pkg_root = "~/boilerplatePackage"
#' )
#' }
#' @export
pkg_r <- function(pkg_root,
                  msg = "z.R file path:") {
  root_r <- file.path(
    pkg_root,
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
    fn = "z.R",
    msg = msg,
    overwrite = TRUE
  )
}
