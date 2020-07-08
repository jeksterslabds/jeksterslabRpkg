#' Clean Package
#'
#' Cleans the following:
#' - `docs/*`
#' - `man/*`
#' - `vignettes/*.html`
#' - `vignettes/*.md`
#' - `vignettes/articles/*.html`
#' - `vignettes/articles/*.md`
#' - `vignettes/articles/*_files`
#' - `vignettes/notes/*_cache`
#' - `vignettes/notes/*.html`
#' - `vignettes/notes/*.md`
#' - `vignettes/notes/*_files`
#' - `vignettes/notes/*_cache`
#' - `vignettes/tests/*`
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_git
#' @importFrom jeksterslabRutils util_clean_dir
#' @export
pkg_clean <- function(pkg_root = getwd()) {
  namespace <- file.path(pkg_root, "NAMESPACE")
  readme_md <- file.path(pkg_root, "README.md")
  readme_html <- file.path(pkg_root, "README.html")
  unlink(
    c(
      namespace,
      readme_md,
      readme_html
    )
  )
  path_doc <- file.path(pkg_root, "docs")
  if (dir.exists(path_doc)) {
    util_clean_dir(
      dir = path_doc,
      create_dir = TRUE,
      recursive = TRUE,
      force = TRUE
    )
  }
  path_man <- file.path(pkg_root, "man")
  if (dir.exists(path_man)) {
    util_clean_dir(
      dir = path_man,
      create_dir = TRUE,
      recursive = TRUE,
      force = TRUE
    )
  }
  path_vignettes_tests <- file.path(pkg_root, "vignettes", "tests")
  if (dir.exists(path_vignettes_tests)) {
    util_clean_dir(
      dir = path_vignettes_tests,
      create_dir = FALSE,
      recursive = TRUE,
      force = TRUE
    )
  }
  path_vignettes <- file.path(pkg_root, "vignettes")
  if (dir.exists(path_vignettes)) {
    wd <- getwd()
    setwd(path_vignettes)
    unlink(x = "*.html")
    unlink(x = "*.md")
    setwd(wd)
  }
  path_vignettes_notes <- file.path(pkg_root, "vignettes", "articles", "notes")
  if (dir.exists(path_vignettes_notes)) {
    wd <- getwd()
    setwd(path_vignettes_notes)
    unlink(x = "*.html")
    unlink(x = "*.md")
    unlink(x = "*_files", recursive = TRUE)
    unlink(x = "*_cache", recursive = TRUE)
    setwd(wd)
  }
  path_tests_testthat <- file.path(pkg_root, "tests", "testthat")
  if (dir.exists(path_tests_testthat)) {
    wd <- getwd()
    setwd(path_tests_testthat)
    unlink(x = "*.html")
    unlink(x = "*.md")
    unlink(x = "*_files", recursive = TRUE)
    unlink(x = "*_cache", recursive = TRUE)
    setwd(wd)
  }
}
