#' Render R Markdown Files in the Package Directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param readme Logical.
#'   Render \code{README.Rmd}.
#' @param vignettes Logical.
#'   Render vignettes.
#' @param tests Logical.
#'   Render tests.
#' @inheritParams pkg_create
#' @inheritParams jeksterslabRutils::util_lapply
#' @examples
#' \dontrun{
#' pkg_render()
#' }
#' @importFrom utils glob2rx
#' @importFrom rmarkdown render
#' @importFrom rprojroot find_root
#' @importFrom jeksterslabRutils util_lapply
#' @importFrom jeksterslabRutils util_render
#' @export
pkg_render <- function(pkg_dir = getwd(),
                       readme = TRUE,
                       vignettes = TRUE,
                       tests = TRUE,
                       par = TRUE,
                       ncores = NULL) {
  root <- find_root(
    criterion = "DESCRIPTION",
    path = pkg_dir
  )
  if (readme) {
    render_readme <- file.path(
      root,
      "README.Rmd"
    )
  } else {
    render_readme <- NA
  }
  if (vignettes) {
    render_vignette <- list.files(
      path = file.path(
        root,
        "vignettes"
      ),
      pattern = glob2rx("^*.Rmd$|^*.rmd$|^*.R$|^*.r$"),
      recursive = TRUE,
      include.dirs = TRUE
    )
  } else {
    render_vignette <- NA
  }
  if (tests) {
    render_test <- list.files(
      path = file.path(
        root,
        "tests",
        "testthat"
      ),
      pattern = glob2rx("^*.R$|^*.r$"),
      recursive = TRUE,
      include.dirs = TRUE
    )
  } else {
    render_test <- NA
  }
  files <- c(
    render_readme,
    render_vignette,
    render_test
  )
  if (all(is.na(files))) {
    stop("No files to render.")
  }
  files <- files[!is.na(files)]
  if (length(files) == 0) {
    stop("No files to render.")
  }
  util_render(
    recursive = FALSE,
    files = files,
    par = par,
    ncores = ncores
  )
}
