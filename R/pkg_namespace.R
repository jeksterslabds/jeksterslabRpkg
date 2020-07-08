#' Create a Boilerplate Package `NAMESPACE`
#'
#' Creates a boilerplate package `NAMESPACE`.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' If you are going to document, check, and build your package using `devtools`,
#' you may delete the boilerplate `NAMESPACE` file.
#'
#' **THIS FUNCTION OVERWRITES AN EXISTING `NAMESPACE` FILE
#' IN THE SPECIFIED PACKAGE ROOT DIRECTORY.
#' USE WITH CAUTION.**
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_rbuildignore
#' @param add Character string.
#' Entries to the \code{NAMESPACE}
#' in addition to the boilerplate example.
#' @examples
#' \dontrun{
#' pkg_namespace(
#'   pkg_root = "~/boilerplatePackage"
#' )
#' }
#' @export
pkg_namespace <- function(pkg_root,
                          add = NULL,
                          msg = "NAMESPACE file path:") {
  output <- c(
    "# This is a boilerplate example.",
    "# Delete this file if you are building documentation files with roxygen.",
    "export(z)",
    "import(utils)"
  )
  output <- paste0(
    output,
    collapse = "\n"
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
    fn = "NAMESPACE",
    msg = msg,
    overwrite = TRUE
  )
}
