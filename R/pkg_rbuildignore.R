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
#' @inheritParams pkg_description
#' @param add Character string.
#'   Entries to the \code{.Rbuildignore}
#'   in addition to the boilerplate example.
#' @examples
#' \dontrun{
#' pkg_rbuildignore(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage"
#' )
#' }
#' @export
pkg_rbuildignore <- function(pkg_dir = getwd(),
                             pkg_name,
                             add = NULL) {
  pkg_root <- file.path(
    pkg_dir,
    pkg_name
  )
  file <- file.path(pkg_root, ".Rbuildignore")
  if (file.exists(file)) {
    output <- paste0(
      readLines(
        con = file
      ),
      collapse = "\n"
    )
  } else {
    output <- paste0(
      readLines(
        con = system.file(
          "extdata",
          "Rbuildignore",
          package = "jeksterslabRpkg",
          mustWork = TRUE
        )
      ),
      collapse = "\n"
    )
  }
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
    fn = ".Rbuildignore"
  )
}
