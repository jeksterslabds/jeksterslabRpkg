#' Create a Boilerplate Package Get Started Vignette.
#'
#' Creates a boilerplate package Get Started vignette.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_rbuildignore
#' @examples
#' \dontrun{
#' pkg_getstarted(
#'   pkg_root = "~/boilerplatePackage"
#' )
#' }
#' @export
pkg_getstarted <- function(pkg_root,
                           msg = "Get started file path:") {
  pkg_name <- basename(pkg_root)
  root_vignettes <- file.path(
    pkg_root,
    "vignettes"
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "getstarted",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  output <- gsub(
    pattern = "BOILERPLATEPACKAGE",
    replacement = pkg_name,
    x = output
  )
  output <- paste0(
    output,
    collapse = "\n"
  )
  util_txt2file(
    text = output,
    dir = root_vignettes,
    fn = paste0(pkg_name, ".Rmd"),
    msg = msg,
    overwrite = TRUE
  )
}
