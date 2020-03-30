#' Create Boilerplate Package R Script.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @export
pkg_r <- function(pkg_dir = getwd(),
                  pkg_name) {
  r <- file.path(
    pkg_dir,
    pkg_name,
    "R"
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "zR",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  util_txt2file(
    text = output,
    dir = r,
    fn = "z.R"
  )
}
