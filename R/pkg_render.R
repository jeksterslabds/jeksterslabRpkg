#' Render `R` Markdown Files in the Package Directory.
#'
#' Renders `R` Markdown files in the package directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param readme Logical.
#'   Render `README.Rmd`.
#' @param vignettes Logical.
#'   Render `vignettes/*.Rmd`.
#' @param tests Logical.
#'   Render `tests/testhat/*.R`.
#' @inheritParams pkg_build
#' @inheritParams util_lapply
#' @importFrom utils glob2rx
#' @importFrom rmarkdown render
#' @examples
#' \dontrun{
#' pkg_render(
#'   pkg_root = getwd(),
#'   readme = TRUE,
#'   vignettes = TRUE,
#'   tests = TRUE,
#'   par = FALSE
#' )
#' }
#' @export
pkg_render <- function(pkg_root = NULL,
                       readme = TRUE,
                       vignettes = TRUE,
                       tests = TRUE,
                       par = TRUE,
                       ncores = NULL) {
  if (is.null(pkg_root)) {
    pkg_root <- getwd()
  }
  if (!file.exists(
    file.path(
      pkg_root,
      "DESCRIPTION"
    )
  )
  ) {
    stop("Not a valid package root directory.\n")
  }
  if (readme) {
    render_readme <- file.path(
      pkg_root,
      "README.Rmd"
    )
    util_render(
      recursive = FALSE,
      files = render_readme,
      par = par,
      ncores = ncores
    )
  }
  if (vignettes) {
    pattern <- paste0(
      glob2rx("*.Rmd"),
      "|",
      glob2rx("*.rmd"),
      "|",
      glob2rx("*.R"),
      "|",
      glob2rx("*.r")
    )
    render_vignette <- list.files(
      path = file.path(
        pkg_root,
        "vignettes"
      ),
      pattern = pattern,
      full.names = TRUE,
      recursive = TRUE,
      include.dirs = TRUE
    )
    util_render(
      recursive = FALSE,
      files = render_vignette,
      par = par,
      ncores = ncores
    )
  }
  if (tests) {
    pattern <- paste0(
      glob2rx("*.R"),
      "|",
      glob2rx("*.r")
    )
    render_test <- list.files(
      path = file.path(
        pkg_root,
        "tests",
        "testthat"
      ),
      pattern = pattern,
      full.names = TRUE,
      recursive = TRUE,
      include.dirs = TRUE
    )
    util_render(
      recursive = FALSE,
      files = render_test,
      par = par,
      ncores = ncores
    )
  }
  # files <- c(
  #  render_readme,
  #  render_vignette,
  #  render_test
  # )
  # if (all(is.na(files))) {
  #  stop(
  #    "No files to render.\n"
  #  )
  # }
  # files <- files[!is.na(files)]
}
