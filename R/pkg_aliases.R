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
#' Aliases jeksterslabRpkg::util_style() Recursive and Parallel
#' 
#' `jeksterslabRpkg::util_style(
#'   dir = getwd(),
#'   recursive = TRUE,
#'   par = TRUE,
#'   ncores = NULL
#' )`
#'
#' @inheritParams util_style
#' @export
rstyle <- function(dir = getwd(),
  recursive = TRUE,
  par = TRUE,
  ncores = NULL) {
  jeksterslabRpkg::util_style(
    dir = dir,
    recursive = recursive,
    par = par,
    ncores = ncores
  )
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
