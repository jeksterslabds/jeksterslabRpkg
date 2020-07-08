#' Style `R` and `R` Markdown Files in the Package Directory
#'
#' Styles `R` and `R` Markdown files in the package directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_build
#' @examples
#' \dontrun{
#' pkg_style(
#'   pkg_root = "~/boilerplatePackage",
#'   par = FALSE
#' )
#' }
#' @importFrom jeksterslabRutils util_style
#' @export
pkg_style <- function(pkg_root = getwd(),
                      par = TRUE,
                      ncores = NULL) {
  message(
    "Styling..."
  )
  tryCatch(
    {
      util_style(
        dir = pkg_root,
        recursive = TRUE,
        par = par,
        ncores = ncores
      )
    },
    error = function(err) {
      warning(
        "Error in styling."
      )
    }
  )
}
