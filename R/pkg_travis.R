#' Create a Boilerplate Package `.travis.yml` File.
#'
#' Creates a `.travis.yml` build file
#' with additional entries for `codecov`.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' **THIS FUNCTION OVERWRITES AN EXISTING `.travis.yml` FILE
#' IN THE SPECIFIED PACKAGE ROOT DIRECTORY.
#' USE WITH CAUTION.**
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @param add Character string.
#'   Entries to the `.travis.yml`
#'   in addition to the boilerplate example.
#' @examples
#' \dontrun{
#' pkg_travis(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage"
#' )
#' }
#' @export
pkg_travis <- function(pkg_dir = getwd(),
                       pkg_name,
                       add = NULL) {
  root <- file.path(
    pkg_dir,
    pkg_name
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "travis",
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
    fn = ".travis.yml"
  )
  pkg_rbuildignore(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = "^.travis.yml$"
  )
}
