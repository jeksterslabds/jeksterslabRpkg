#' Create a Boilerplate Package Vignette File.
#'
#' Creates a boilerplate package vignette file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_rbuildignore
#' @examples
#' \dontrun{
#' pkg_vignette(
#'   pkg_root = "~/boilerplatePackage"
#' )
#' }
#' @export
pkg_vignette <- function(pkg_root,
                         msg = "z.Rmd file path:") {
  pkg_name <- basename(pkg_root)
  root_vignettes <- file.path(
    pkg_root,
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
    fn = "z.Rmd",
    msg = msg,
    overwrite = TRUE
  )
}
