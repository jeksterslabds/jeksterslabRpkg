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
#' @param add Character string.
#'   Entries to the `.travis.yml`
#'   in addition to the boilerplate example.
#' @inheritParams pkg_rbuildignore
#' @examples
#' \dontrun{
#' pkg_travis(
#'   pkg_root = getwd()
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
    output <- paste0(
      output,
      "\n",
      add
    )
  }
  util_txt2file(
    text = output,
    dir = pkg_root,
    fn = ".travis.yml",
    msg = msg
  )
  pkg_rbuildignore(
    pkg_root = pkg_root,
    add = "^.travis.yml$\n^.covrignore$"
  )
}
