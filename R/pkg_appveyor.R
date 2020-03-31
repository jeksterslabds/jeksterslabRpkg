#' Create a Boilerplate Package `appveyor.yml` File.
#'
#' Creates an `appveyor.yml` build file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' **THIS FUNCTION OVERWRITES AN EXISTING `appveyor.yml` FILE
#' IN THE SPECIFIED PACKAGE ROOT DIRECTORY.
#' USE WITH CAUTION.**
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @param add Character string.
#'   Entries to the `appveyor.yml`
#'   in addition to the boilerplate example.
#' @examples
#' \dontrun{
#' pkg_appveyor(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage"
#' )
#' }
#' @export
pkg_appveyor <- function(pkg_dir = getwd(),
                         pkg_name,
                         add = NULL) {
  root <- file.path(
    pkg_dir,
    pkg_name
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "appveyor",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  if (!is.null(add)) {
    output <- paste0(
      output,
      "\n",
      add
    )
  }
  util_txt2file(
    text = output,
    dir = root,
    fn = "appveyor.yml"
  )
  pkg_rbuildignore(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = "^appveyor.yml$"
  )
}
