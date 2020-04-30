#' Aliases
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @export
rsty <- function() {
  styler::style_dir()
}
rspkg <- function() {
  styler::style_pkg()
}
rtest <- function() {
  devtools::test()
}
rchk <- function() {
  devtools::check()
}
rchk <- function() {
  jeksterslabRpkg::pkg_build()
}
rpkg <- function() {
  styler::style_pkg()
  devtools::check()
  devtools::install()
}
rbuild <- function() {
  pkg_build()
}
rpkg <- function() {
  styler::style_pkg()
  devtools::check()
  devtools::install()
}
