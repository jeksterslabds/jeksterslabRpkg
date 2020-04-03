#' Build Package.
#'
#' Builds the `R` package on `pkg_root` by:
#'   - styling the `R` scripts and `R` Markdown files,
#'   - building package data by running `R` scripts stored in `data_raw`,
#'   - rendering the `R` scripts and `R` Markdown files using [rmarkdown::render()], and
#'   - building `pkgdown` site.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param minimal Logical.
#'   If `TRUE`, minimal check, build, and install
#'   using `R CMD` will be performed,
#'   ignoring all the other function arguments.
#'   If `FALSE`, a more thorough check is performed
#'   with additional options.
#' @param style Logical.
#'   Style `R` scripts and `R` Markdown files.
#' @param data Logical.
#'   Generate data from `data_raw`.
#' @param render Logical.
#'   Render `R` scripts and `R` Markdown files.
#' @param readme Logical.
#'   Render `README.Rmd`.
#'   Ignored if `render = FALSE`.
#' @param vignettes Logical.
#'   Render `vignettes/*.Rmd`.
#'   Ignored if `render = FALSE`.
#' @param tests Logical.
#'   Render `tests/testhat/*.R`.
#'   Ignored if `render = FALSE`.
#' @param pkgdown Logical.
#'   Build `pkgdown` site.
#' @inheritParams pkg_description
#' @inheritParams util_lapply
#' @inheritParams pkg_git
#' @inheritParams pkg_create
#' @importFrom devtools document
#' @importFrom devtools load_all
#' @importFrom devtools check
#' @importFrom devtools install
#' @examples
#' \dontrun{
#' pkg_build(
#'   pkg_root = "~/boilerplatePackage",
#'   minimal = TRUE
#' )
#' }
#' @export
pkg_build <- function(pkg_root = NULL,
                      minimal = FALSE,
                      style = TRUE,
                      data = TRUE,
                      render = TRUE,
                      readme = TRUE,
                      vignettes = TRUE,
                      tests = TRUE,
                      pkgdown = TRUE,
                      par = TRUE,
                      ncores = NULL,
                      git = FALSE,
                      github = FALSE,
                      msg = "BUILD") {
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
  pkg_name <- basename(pkg_root)
  message(
    paste0(
      "Building ",
      pkg_name,
      "\n",
      "Path: ",
      pkg_root,
      "\n"
    )
  )
  wd <- getwd()

  if (minimal) {
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
          "Error in `R CMD build`.\n"
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
          "Error in `R CMD check`.\n"
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
          "Error in `R CMD INSTALL`.\n"
        )
      }
    )
  } else {
    if (style) {
      message(
        "Styling...\n"
      )
      tryCatch(
        {
          util_style(
            dir = pkg_root,
            par = par,
            ncores = ncores
          )
        },
        error = function(err) {
          warning(
            "Error in styling.\n"
          )
        }
      )
    }
    document(
      pkg = pkg_root
    )
    load_all(
      path = pkg_root
    )
    # tryCatch(
    #  {
    #    unloadNamespace(
    #      pkg_name
    #    )
    #    requireNamespace(
    #      pkg_name
    #    )
    #  },
    #  error = function(err) err
    # )
    if (data) {
      message(
        "Generating data...\n"
      )
      data_raw <- file.path(
        pkg_root,
        "data_raw"
      )
      if (dir.exists(data_raw)) {
        pattern <- paste0(
          glob2rx("*.Rmd"),
          "|",
          glob2rx("*.rmd"),
          "|",
          glob2rx("*.R"),
          "|",
          glob2rx("*.r")
        )
        files <- list.files(
          path = data_raw,
          pattern = pattern
        )
        tryCatch(
          {
            util_lapply(
              FUN = source,
              args = list(
                file = files
              ),
              par = par,
              ncores = ncores
            )
          },
          error = function(err) {
            warning(
              "Error in data generation.\n"
            )
          }
        )
      }
    }
    if (render) {
      message(
        "Rendering...\n"
      )
      tryCatch(
        {
          pkg_render(
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
            "Error in rendering.\n"
          )
        }
      )
    }
    check(
      pkg = pkg_root
    )
    install(
      pkg = pkg_root
    )
    if (pkgdown) {
      build_site(
        pkg = pkg_root
      )
    }
    message(
      paste(
        "Build process for",
        pkg_name,
        "complete.\n"
      )
    )
  }
  if (git) {
    pkg_git(
      pkg_root = pkg_root,
      github = github,
      msg = msg
    )
  }
  setwd(wd)
}
