#' Create a Boilerplate Package `R` Script.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @examples
#' \dontrun{
#' pkg_r(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage"
#' )
#' }
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
