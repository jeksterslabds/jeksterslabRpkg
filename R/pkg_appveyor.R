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
#' @inheritParams pkg_rbuildignore
#' @param add Character string.
#'   Entries to the `appveyor.yml`
#'   in addition to the boilerplate example.
#' @examples
#' \dontrun{
#' pkg_appveyor(
#'   pkg_root = "~/boilerplatePackage"
#' )
#' }
#' @importFrom jeksterslabRutils util_txt2file
#' @export
pkg_appveyor <- function(pkg_root,
                         add = NULL,
                         msg = "appveyor.yml file path:") {
  output <- readLines(
    con = system.file(
      "extdata",
      "appveyor",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  if (!is.null(add)) {
    output <- union(
      output,
      add
    )
  }
  util_txt2file(
    text = output,
    dir = pkg_root,
    fn = "appveyor.yml",
    msg = msg
  )
  pkg_rbuildignore(
    pkg_root = pkg_root,
    add = "^appveyor.yml$"
  )
}
