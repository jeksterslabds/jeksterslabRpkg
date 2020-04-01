#' Create a Package `.Rproj` File.
#'
#' Creates a package `.Rproj` file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' **THIS FUNCTION OVERWRITES AN EXISTING `.Rproj` FILE
#' IN THE SPECIFIED PACKAGE ROOT DIRECTORY.
#' USE WITH CAUTION.**
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @examples
#' \dontrun{
#' pkg_rproj(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage"
#' )
#' }
#' @export
pkg_rproj <- function(pkg_dir = getwd(),
                      pkg_name) {
  root <- file.path(
    pkg_dir,
    pkg_name
  )
  rproj <- readLines(
    con = system.file(
      "extdata",
      "Rproj",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  util_txt2file(
    text = rproj,
    dir = root,
    fn = paste0(
      pkg_name,
      ".Rproj"
    )
  )
  pkg_rbuildignore(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = paste0(
      "^",
      pkg_name,
      ".Rproj$"
    )
  )
}
