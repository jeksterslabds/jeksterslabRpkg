#' Create Package .Rproj.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @export
pkg_rproj <- function(pkg_dir = getwd(),
                      pkg_name) {
  root <- file.path(
    pkg_dir,
    pkg_name
  )
  rproj <- readLines(
    con = system.file(
      "extdata",
      "Rproj",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  util_txt2file(
    text = rproj,
    dir = root,
    fn = paste0(
      pkg_name,
      ".Rproj"
    )
  )
  pkg_rbuildignore(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = paste0(
      "^",
      pkg_name,
      ".Rproj$"
    )
  )
}
