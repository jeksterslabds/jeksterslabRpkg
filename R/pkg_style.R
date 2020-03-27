#' Style Package R and RMD Files.
#'
#' Styles all \code{R} scripts and \code{R Markdown} files
#' in the package directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_create
#' @examples
#' \dontrun{
#' pkg_style()
#' }
#' @importFrom rprojroot find_root
#' @importFrom styler style_file
#' @export
pkg_style <- function(pkg_dir = getwd()) {
  root <- find_root(
    criterion = "DESCRIPTION",
    path = pkg_dir
  )
  rscripts <- list.files(
    pattern = "*.R$",
    recursive = TRUE
  )
  rmds <- rscripts <- list.files(
    pattern = "*.Rmd$",
    recursive = TRUE
  )
  for (i in seq_along(rscripts)) {
    style_file(
      file.path(
        root,
        rscripts[i]
      )
    )
  }
  for (i in seq_along(rmds)) {
    style_file(
      file.path(
        root,
        rmds[i]
      )
    )
  }
}
