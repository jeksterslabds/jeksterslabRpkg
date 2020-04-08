#' Create a Boilerplate Package `.gitignore` File.
#'
#' Creates a boilerplate package `.gitignore` file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' If `.gitignore` exists in the specified package root directory,
#' it will **NOT** be overwritten.
#' Additional entries in the `add` argument will be appended.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param add Character string.
#'   Entries to the \code{.gitignore}
#'   in addition to the boilerplate example.
#' @inheritParams pkg_rbuildignore
#' @examples
#' \dontrun{
#' pkg_gitignore(
#'   pkg_root = getwd()
#' )
#' }
#' @export
pkg_gitignore <- function(pkg_root,
                          add = NULL,
                          msg = ".gitignore file path:") {
  file <- file.path(pkg_root, ".gitignore")
  if (file.exists(file)) {
    output <- readLines(
      con = file
    )
  } else {
    output <- readLines(
      con = system.file(
        "extdata",
        "gitignore",
        package = "jeksterslabRpkg",
        mustWork = TRUE
      )
    )
  }
  if (!is.null(add)) {
    output <- unique(
      output,
      add
    )
  }
  util_txt2file(
    text = output,
    dir = pkg_root,
    fn = ".gitignore",
    msg = msg
  )
}
