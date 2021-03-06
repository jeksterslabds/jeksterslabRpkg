#' Create a Boilerplate Package `.travis.yml` File
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
#' @inheritParams pkg_rbuildignore
#' @param add Character string.
#' Entries to the `.travis.yml`
#' in addition to the boilerplate example.
#' @examples
#' \dontrun{
#' pkg_travis(
#'   pkg_root = "~/boilerplatePackage"
#' )
#' }
#' @export
pkg_travis <- function(pkg_root,
                       add = NULL,
                       msg = ".travis.yml file path:") {
  output <- readLines(
    con = system.file(
      "extdata",
      "travis",
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
    fn = ".travis.yml",
    msg = msg,
    overwrite = TRUE
  )
  pkg_rbuildignore(
    pkg_root = pkg_root,
    add = "^.travis.yml$\n^.covrignore$"
  )
}
