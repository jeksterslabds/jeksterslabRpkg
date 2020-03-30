#' Build Package
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param style Logical.
#'   Style R scripts and R Markdown files.
#' @param data Logical.
#'   Generate data from \code{data_raw}.
#' @param render Logical.
#'   Render R scripts and R Markdown files.
#' @param readme Logical.
#'   Render \code{README.Rmd}.
#'   Ignored if \code{render = FALSE}.
#' @param vignettes Logical.
#'   Render \code{vignettes}.
#'   Ignored if \code{render = FALSE}.
#' @param tests Logical.
#'   Render \code{tests}.
#'   Ignored if \code{render = FALSE}.
#' @param pkgdown Logical.
#'   Build \code{pkgdown} site.
#' @inheritParams pkg_description
#' @inheritParams jeksterslabRutils::util_lapply
#' @importFrom devtools document
#' @importFrom devtools load_all
#' @importFrom devtools check
#' @importFrom devtools install
#' @importFrom jeksterslabRutils util_style
#' @export
pkg_build <- function(pkg_dir = getwd(),
                      style = TRUE,
                      data = TRUE,
                      render = TRUE,
                      readme = TRUE,
                      vignettes = TRUE,
                      tests = TRUE,
                      pkgdown = TRUE,
                      par = TRUE,
                      ncores = NULL) {
  if (style) {
    util_style(
      dir = pkg_dir,
      par = par,
      ncores = ncores
    )
  }
  document(
    pkg = pkg_dir
  )
  load_all(
    path = pkg_dir
  )
  if (data) {
    data_raw <- file.path(
      pkg_dir,
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
      pkg_dir = pkg_dir,
      readme = readme,
      vignettes = vignettes,
      tests = tests,
      par = par,
      ncores = ncores
    )
  }
  if (pkgdown) {
    build_site(pkg = pkg_dir)
  }
  check(pkg = pkg_dir)
  install(pkg = pkg_dir)
}
