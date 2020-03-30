#' Create Boilerplate Package Vignette.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @export
pkg_vignettes <- function(pkg_dir = getwd(),
                          pkg_name) {
  root <- file.path(
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
    dir = root,
    fn = "z.Rmd"
  )
}
