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
#' @param tests2vignettes Logical.
#'   Copy and spin `tests/testhat/*.R`
#'   to `vignettes/tests/*.Rmd`.
#'   It is assumed that `tests/testhat/*.R`
#'   are written using `Roxygen` comments.
#' @param pkgdown Logical.
#'   Build `pkgdown` site.
#' @inheritParams pkg_description
#' @inheritParams jeksterslabRutils::util_lapply
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
#' @importFrom jeksterslabRutils util_lapply
#' @importFrom jeksterslabRutils util_style
#' @importFrom jeksterslabRutils util_search_r
#' @export
pkg_build <- function(pkg_root = getwd(),
                      minimal = FALSE,
                      style = TRUE,
                      data = FALSE,
                      render = TRUE,
                      readme = TRUE,
                      vignettes = TRUE,
                      tests = TRUE,
                      tests2vignettes = TRUE,
                      pkgdown = TRUE,
                      par = TRUE,
                      ncores = NULL,
                      git = FALSE,
                      github = FALSE,
                      commit_msg = "BUILD") {
  if (!pkg_checkroot(dir = pkg_root)) {
    stop(
      paste(
        pkg_root,
        "is an invalid package directory.\n"
      )
    )
  }
  pkg_name <- basename(pkg_root)
  message(
    paste0(
      "Building ",
      pkg_name,
      "\n",
      "Path: ",
      normalizePath(pkg_root),
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
    if (!pkg_checkroot_subdir(dir = pkg_root, subdir = "data_raw")
    ) {
      data <- FALSE
    }
    if (!file.exists(file.path(pkg_root, "_pkgdown.yml"))) {
      pkgdown <- FALSE
    }
    if (style) {
      message(
        "Styling...\n"
      )
      tryCatch(
        {
          util_style(
            dir = pkg_root,
            recursive = TRUE,
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
    if (data) {
      message(
        "Generating data...\n"
      )
      data_raw <- file.path(
        pkg_root,
        "data_raw"
      )
      if (dir.exists(data_raw)) {
        setwd(data_raw)
        files <- util_search_r(
          dir = normalizePath(data_raw),
          all.files = FALSE,
          rscript = TRUE,
          rmd = TRUE,
          full.names = TRUE,
          recursive = TRUE,
          ignore.case = TRUE,
          no.. = FALSE
        )
        if (length(files) > 0) {
          tryCatch(
            {
              lapply(
                X = files,
                FUN = source
              )
            },
            error = function(err) {
              warning(
                "Error in data generation.\n"
              )
            }
          )
        } else {
          message("No R files in data_raw.\n")
        }
        setwd(wd)
      }
    }
    if (tests2vignettes) {
      pkg_tests2vignettes(
        pkg_root = pkg_root,
        par = par,
        ncores = ncores
      )
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
      commit_msg = commit_msg
    )
  }
  setwd(wd)
}
