#' Render R Markdown Files in the Package Directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_create
#' @examples
#' \dontrun{
#' pkg_rmd()
#' }
#' @importFrom utils glob2rx
#' @importFrom rmarkdown render
#' @export
pkg_rmd <- function(pkg_dir = getwd()) {
  root <- find_root(
    criterion = "DESCRIPTION",
    path = pkg_dir
  )
  files <- list.files(
    path = root,
    pattern = glob2rx("^*.Rmd$"),
    recursive = TRUE,
    include.dirs = TRUE
  )
  for (i in seq_along(files)) {
    render(files[i])
  }
  files <- list.files(
    path = file.path(
      root
    ),
    pattern = glob2rx("^test_*.R$"),
    recursive = TRUE,
    include.dirs = TRUE
  )
  for (i in seq_along(files)) {
    render(files[i])
  }
}
