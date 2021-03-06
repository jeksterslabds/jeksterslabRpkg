#' Render `R` and `R` Markdown Files in the Package Directory
#'
#' Renders `R` and `R` Markdown files in the package directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_build
#' @param readme Logical.
#' Render `README.Rmd`.
#' @param vignettes Logical.
#' Render `vignettes/*.Rmd|*.R`.
#' @param tests Logical.
#' Render `tests/testhat/*.Rmd|*.R`.
#' @examples
#' \dontrun{
#' pkg_render(
#'   pkg_root = "~/boilerplatePackage",
#'   readme = TRUE,
#'   vignettes = TRUE,
#'   tests = TRUE,
#'   par = FALSE
#' )
#' }
#' @importFrom rmarkdown render
#' @importFrom jeksterslabRutils util_render
#' @export
pkg_render <- function(pkg_root = getwd(),
                       readme = TRUE,
                       vignettes = TRUE,
                       tests = TRUE,
                       par = FALSE,
                       ncores = NULL) {
  foo <- function(pkg_root,
                  readme,
                  vignettes,
                  tests,
                  par,
                  ncores) {
    if (!pkg_checkroot(dir = pkg_root)) {
      stop(
        paste(
          pkg_root,
          "is an invalid package directory."
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
    bar <- function(render = c(
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
        path <- normalizePath(path)
        files <- util_search_r(
          dir = path,
          rscript = TRUE,
          rmd = TRUE,
          all.files = FALSE,
          full.names = TRUE,
          recursive = TRUE,
          ignore.case = TRUE,
          no.. = FALSE
        )
      }
      if (length(files) > 0) {
        util_render(
          files = files,
          par = par,
          ncores = ncores
        )
      }
    }
    if (readme == FALSE && tests == FALSE && vignettes == FALSE) {
      message(
        "Nothing to render."
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
        bar(render = render[i])
      }
    }
  }
  message(
    "Rendering..."
  )
  tryCatch(
    {
      foo(
        pkg_root = pkg_root,
        readme = readme,
        vignettes = vignettes,
        tests = tests,
        par = par,
        ncores = ncores
      )
    },
    error = function(err) {
      warning(
        "Error in rendering."
      )
    }
  )
}
