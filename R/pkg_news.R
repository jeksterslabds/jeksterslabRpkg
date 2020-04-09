#' Create a Boilerplate Package NEWS.md File.
#'
#' Creates a boilerplate package NEWS.md file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_rbuildignore
#' @examples
#' \dontrun{
#' pkg_news(
#'   pkg_root = "~/boilerplatePackage"
#' )
#' }
#' @export
pkg_news <- function(pkg_root,
                     msg = "NEWS.md file path:") {
  pkg_name <- basename(pkg_root)
  root_vignettes <- file.path(
    pkg_root,
    "vignettes"
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "NEWS",
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
    fn = "NEWS.md",
    msg = msg
  )
}
