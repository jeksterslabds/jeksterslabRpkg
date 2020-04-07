#' Create a Boilerplate Package Vignette File.
#'
#' Creates a boilerplate package vignette file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @examples
#' \dontrun{
#' pkg_vignette(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage"
#' )
#' }
#' @export
pkg_vignette <- function(pkg_dir = getwd(),
                         pkg_name) {
  pkg_root <- file.path(
    pkg_dir,
    pkg_name,
    "vignettes"
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "vignette_z",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  output <- sub(
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
    dir = pkg_root,
    fn = "z.Rmd"
  )
}
