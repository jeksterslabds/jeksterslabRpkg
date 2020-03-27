#' Create Boilerplate Package NAMESPACE.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @param add Character string.
#'   Entries to the \code{NAMESPACE}
#'   in addition to the boilerplate example.
#' @examples
#' pkg_namespace(pkg_dir = tempdir(), pkg_name = "boilerplatePackage")
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
