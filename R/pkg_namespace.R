#' Create a Boilerplate Package `NAMESPACE`.
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
#' @inheritParams pkg_description
#' @param add Character string.
#'   Entries to the \code{NAMESPACE}
#'   in addition to the boilerplate example.
#' @examples
#' \dontrun{
#' pkg_namespace(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage"
#' )
#' }
#' @export
pkg_namespace <- function(pkg_dir = getwd(),
                          pkg_name,
                          add = NULL) {
  root <- file.path(
    pkg_dir,
    pkg_name
  )
  output <- paste0(
    "# This is a boilerplate example.",
    "\n",
    "# Delete this file if you are building documentation files with roxygen.",
    "\n",
    "export(z)",
    "\n",
    "import(utils)",
    "\n"
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
    fn = "NAMESPACE"
  )
}
