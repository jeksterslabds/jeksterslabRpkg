#' Build Package.
#'
#' Builds the `R` package on `pkg_root` by:
#'   - styling the `R` scripts and `R` Markdown files,
#'   - building package data by running `R` scripts stored in `data_raw`,
#'   - rendering the `R` scripts and `R` Markdown files using [rmarkdown::render()], and
#'   - building `pkgdown` site.
#'
#' Some features of this function requires
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param pkg_root Character string.
#'   Package root directory.
#' @param style Logical.
#'   Style R scripts and R Markdown files.
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
#' @inheritParams jeksterslabRutils::util_lapply
#' @importFrom devtools document
#' @importFrom devtools load_all
#' @importFrom devtools check
#' @importFrom devtools install
#' @importFrom jeksterslabRutils util_style
#' @examples
#' \dontrun{
#' pkg_build(
#'   pkg_root = getwd(),
#'   style = FALSE,
#'   data = FALSE,
#'   render = FALSE,
#'   readme = FALSE,
#'   vignettes = FALSE,
#'   tests = FALSE,
#'   pkgdown = FALSE,
#'   par = FALSE
#' )
#' }
#' @export
pkg_build <- function(pkg_root = getwd(),
                      style = FALSE,
                      data = FALSE,
                      render = FALSE,
                      readme = FALSE,
                      vignettes = FALSE,
                      tests = FALSE,
                      pkgdown = FALSE,
                      par = TRUE,
                      ncores = NULL) {
  if (style) {
    util_style(
      dir = pkg_root,
      par = par,
      ncores = ncores
    )
  }
  document(
    pkg = pkg_root
  )
  # load_all(
  #  path = pkg_root
  # )
  install(
    pkg = pkg_root
  )
  if (data) {
    data_raw <- file.path(
      pkg_root,
      "data_raw"
    )
    if (dir.exists(data_raw)) {
      files <- list.files(
        path = data_raw,
        pattern = "^*.R$|^*.r$"
      )
      util_lapply(
        FUN = source,
        args = list(
          file = files
        ),
        par = par,
        ncores = ncores
      )
    }
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
  if (pkgdown) {
    build_site(
      pkg = pkg_root
    )
  }
  check(
    pkg = pkg_root
  )
  install(
    pkg = pkg_root
  )
}
