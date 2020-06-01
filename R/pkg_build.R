#' Build Package.
#'
#' Builds the `R` package on `pkg_root` by:
#'   - styling the `R` scripts and `R` Markdown files,
#'   - building package data by running `R` scripts stored in `data_raw`,
#'   - rendering the `R` scripts and `R` Markdown files using [rmarkdown::render()], and
#'   - building `pkgdown` site.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param clean Logical.
#'   Clean output that were automatically generated
#'   by previous builds
#'   before initiating the current build.
#'   See [`pkg_clean()`] for details.
#' @param minimal Logical.
#'   If `TRUE`, minimal check, build, and install
#'   using `R CMD` will be performed,
#'   ignoring all the other function arguments.
#'   If `FALSE`, a more thorough check is performed
#'   with additional options.
#'   See [`pkg_build_minimal()`] for details.
#' @param style Logical.
#'   Style `R` scripts and `R` Markdown files.
#'   See [`pkg_style()`] for details.
#' @param data Logical.
#'   Generate data from `data_raw`.
#'   See [`pkg_data_raw()`] for details.
#' @param render Logical.
#'   Render `R` scripts and `R` Markdown files.
#'   See [`pkg_render()`] for details.
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
#'   See [`pkg_tests2vignettes()`] for details.
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
                      clean = TRUE,
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
        "is an invalid package directory."
      )
    )
  }
  if (clean) {
    pkg_clean(pkg_root = pkg_root)
  }
  pkg_name <- basename(pkg_root)
  message(
    paste0(
      "Building ",
      pkg_name,
      "\n",
      "Path: ",
      normalizePath(pkg_root)
    )
  )
  wd <- getwd()
  if (minimal) {
    pkg_build_minimal(pkg_root = pkg_root)
  } else {
    if (style) {
      pkg_style(
        pkg_root = pkg_root,
        par = par,
        ncores = ncores
      )
    }
    document(
      pkg = pkg_root
    )
    load_all(
      path = pkg_root
    )
    if (data) {
      pkg_data_raw(pkg_root = pkg_root)
    }
    if (tests2vignettes) {
      pkg_tests2vignettes(
        pkg_root = pkg_root,
        par = par,
        ncores = ncores
      )
    }
    if (render) {
      pkg_render(
        pkg_root = pkg_root,
        readme = readme,
        vignettes = vignettes,
        tests = tests,
        par = par,
        ncores = ncores
      )
    }
    check(
      pkg = pkg_root
    )
    install(
      pkg = pkg_root
    )
    if (pkgdown) {
      if (file.exists(file.path(pkg_root, "_pkgdown.yml"))) {
        build_site(
          pkg = pkg_root
        )
      }
    }
    message(
      paste(
        "Build process for",
        pkg_name,
        "complete."
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
