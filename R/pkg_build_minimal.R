#' Build Package (Minimal)
#'
#' Minimal check, build, and install
#' using `R CMD`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_git
#' @export
pkg_build_minimal <- function(pkg_root = getwd()) {
  wd <- getwd()
  tmp <- tempdir()
  setwd(tmp)
  gz <- paste0(
    file.path(
      basename(pkg_root)
    ),
    "*.tar.gz"
  )
  tryCatch(
    {
      system(
        paste(
          "R CMD build",
          "--no-build-vignettes ",
          "--no-manual",
          pkg_root
        )
      )
    },
    error = function(err) {
      warning(
        "Error in `R CMD build`."
      )
    }
  )
  tryCatch(
    {
      system(
        paste(
          "R CMD check",
          "--no-clean",
          "--no-codoc",
          "--no-examples",
          "--no-install",
          "--no-tests",
          "--no-manual",
          "--no-vignettes",
          "--no-build-vignettes",
          "--no-multiarch",
          gz
        )
      )
    },
    error = function(err) {
      warning(
        "Error in `R CMD check`."
      )
    }
  )
  tryCatch(
    {
      system(
        paste(
          "R CMD INSTALL",
          gz
        )
      )
    },
    error = function(err) {
      warning(
        "Error in `R CMD INSTALL`."
      )
    }
  )
  setwd(wd)
}
