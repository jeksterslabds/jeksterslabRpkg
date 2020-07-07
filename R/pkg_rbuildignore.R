#' Create a Boilerplate Package `.Rbuildignore` File.
#'
#' Creates a boilerplate package `.Rbuildignore` file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' If `.Rbuildignore` exists in the specified package root directory,
#' it will **NOT** be overwritten.
#' Additional entries in the `add` argument will be appended.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams jeksterslabRutils::util_txt2file
#' @param pkg_root Character string.
#' Package root directory.
#' @param add Character string.
#' Entries to the \code{.Rbuildignore}
#' in addition to the boilerplate example.
#' @examples
#' \dontrun{
#' pkg_rbuildignore(
#'   pkg_root = "~/boilerplatePackage"
#' )
#' }
#' @export
pkg_rbuildignore <- function(pkg_root,
                             add = NULL,
                             msg = ".Rbuildignore file path:") {
  file <- file.path(pkg_root, ".Rbuildignore")
  if (file.exists(file)) {
    output <- readLines(
      con = file
    )
  } else {
    output <- readLines(
      con = system.file(
        "extdata",
        "Rbuildignore",
        package = "jeksterslabRpkg",
        mustWork = TRUE
      )
    )
  }
  if (!is.null(add)) {
    output <- union(
      output,
      add
    )
  }
  util_txt2file(
    text = output,
    dir = pkg_root,
    fn = ".Rbuildignore",
    msg = msg,
    overwrite = TRUE
  )
}
