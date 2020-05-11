#' Tests to Vignettes
#'
#' Copy and spin `tests/testhat/*.R`
#' to `vignettes/tests/*.Rmd`.
#' It is assumed that `tests/testhat/*.R`
#' are written using `Roxygen` comments.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_build
#' @importFrom tools file_path_sans_ext
#' @importFrom jeksterslabRutils util_spin
#' @export
pkg_tests2vignettes <- function(pkg_root = getwd(),
                                par = TRUE,
                                ncores = NULL) {
  tests <- file.path(
    pkg_root,
    "tests",
    "testthat"
  )
  vignettes <- file.path(
    pkg_root,
    "vignettes"
  )
  vignettes_tests <- file.path(
    vignettes,
    "tests"
  )
  if (!dir.exists(vignettes_tests)) {
    dir.create(
      path = vignettes_tests,
      recursive = TRUE
    )
  }
  files_r <- util_search_r(
    dir = tests,
    rscript = TRUE,
    rmd = FALSE,
    all.files = FALSE,
    full.names = TRUE,
    recursive = FALSE,
    ignore.case = TRUE,
    no.. = FALSE
  )
  util_spin(
    files = files_r,
    knit = FALSE,
    par = par,
    ncores = ncores
  )
  from_files_rmd <- file.path(
    tests,
    paste0(
      file_path_sans_ext(
        basename(
          files_r
        )
      ),
      ".Rmd"
    )
  )
  to_files_rmd <- file.path(
    vignettes_tests,
    paste0(
      file_path_sans_ext(
        basename(
          files_r
        )
      ),
      ".Rmd"
    )
  )
  file.copy(
    from = from_files_rmd,
    to = to_files_rmd
  )
  unlink(
    from_files_rmd
  )
}
