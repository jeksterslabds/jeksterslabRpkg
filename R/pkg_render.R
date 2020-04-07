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
  if (!pkg_checkroot(dir = pkg_root)) {
    stop(
      paste(
        pkg_root,
        "is an invalid package directory.\n"
      )
    )
  }
  if (!file.exists(file.path(pkg_root, "README.Rmd"))) {
    readme <- FALSE
  }
  if (!pkg_checkroot_subdir(dir = pkg_root, subdir = file.path("tests", "testthat"))) {
    tests <- FALSE
  }
  if (!pkg_checkroot_subdir(dir = pkg_root, subdir = "vignettes")) {
    vignettes <- FALSE
  }
  exe <- function(render = c(
                    "readme",
                    "tests",
                    "vignettes"
                  )) {
    if (render == "readme") {
      files <- file.path(
        pkg_root,
        "README.Rmd"
      )
    }
    if (render %in% c("tests", "vignettes")) {
      pattern <- paste0(
        glob2rx("*.Rmd"),
        "|",
        glob2rx("*.rmd"),
        "|",
        glob2rx("*.R"),
        "|",
        glob2rx("*.r")
      )
      if (render == "vignettes") {
        path <- file.path(
          pkg_root,
          "vignettes"
        )
      }
      if (render == "tests") {
        path <- file.path(
          pkg_root,
          "tests",
          "testthat"
        )
      }
      files <- list.files(
        path = path,
        pattern = pattern,
        full.names = TRUE,
        recursive = TRUE,
        include.dirs = TRUE
      )
    }
    if (length(files) > 0) {
      util_render(
        recursive = FALSE,
        files = files,
        par = par,
        ncores = ncores
      )
    }
  }
  if (readme == FALSE && tests == FALSE && vignettes == FALSE) {
    message(
      "Nothing to render.\n"
    )
  } else {
    render <- rep(x = NA, times = 3)
    if (readme) {
      render[1] <- "readme"
    }
    if (tests) {
      render[2] <- "tests"
    }
    if (tests) {
      render[3] <- "vignettes"
    }
    render <- render[!is.na(render)]
    for (i in seq_along(render)) {
      exe(render = render[i])
    }
  }
}
