#' Aliases styler::style_dir()
#'
#' @export
rsty <- function() {
  styler::style_dir()
}
#' Aliases styler::style_pkg()
#'
#' @export
rspkg <- function() {
  styler::style_pkg()
}
#' Aliases devtools::test()
#'
#' @export
rtest <- function() {
  devtools::test()
}
#' Aliases devtools::check()
#'
#' @export
rchk <- function() {
  devtools::check()
}
#' Aliases pkg_build()
#'
#' @export
rbuild <- function() {
  pkg_build()
}
#' Aliases styler::style_pkg(); devtools::check(); devtools::install()
#'
#' @export
rpkg <- function() {
  styler::style_pkg()
  devtools::check()
  devtools::install()
}
