#' Create a Package `.Rproj` File
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
#' @inheritParams pkg_rbuildignore
#' @examples
#' \dontrun{
#' pkg_rproj(
#'   pkg_root = "~/boilerplatePackage"
#' )
#' }
#' @export
pkg_rproj <- function(pkg_root = getwd(),
                      msg = "Rproj file path:") {
  pkg_name <- basename(pkg_root)
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
    dir = pkg_root,
    fn = paste0(
      pkg_name,
      ".Rproj"
    ),
    msg = msg,
    overwrite = TRUE
  )
  pkg_rbuildignore(
    pkg_root = pkg_root,
    add = paste0(
      "^",
      pkg_name,
      ".Rproj$"
    )
  )
}
