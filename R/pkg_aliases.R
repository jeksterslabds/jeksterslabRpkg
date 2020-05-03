#' Alias for jeksterslabRutils::util_render()
#'
#' Alias for [`jeksterslabRutils::util_render()`]
#' with the following arguments:
#' - `dir = getwd()`
#' - `recursive = TRUE`
#' - `files = NULL`
#' - `par = TRUE`
#' - `ncores = NULL`
#'
#' @inheritParams jeksterslabRutils::util_render
#' @seealso [`jeksterslabRutils::util_render()`]
#' @export
rrender <- function(dir = getwd(),
                    recursive = TRUE,
                    files = NULL,
                    par = TRUE,
                    ncores = NULL) {
  jeksterslabRutils::util_render(
    dir = dir,
    recursive = recursive,
    files = files,
    par = par,
    ncores = ncores
  )
}

#' Alias for styler::style_dir()
#'
#' @inheritParams styler::style_dir
#' @seealso [`styler::style_dir()`]
#' @export
rsty <- function(path = ".",
                 ...,
                 style = styler::tidyverse_style,
                 transformers = style(...),
                 filetype = c("R", "Rprofile"),
                 recursive = TRUE,
                 exclude_files = NULL,
                 exclude_dirs = c("packrat", "renv"),
                 include_roxygen_examples = TRUE) {
  styler::style_dir(
    path = path,
    ...,
    style = style,
    transformers = transformers,
    filetype = filetype,
    recursive = recursive,
    exclude_files = exclude_files,
    exclude_dirs = exclude_dirs,
    include_roxygen_examples = include_roxygen_examples
  )
}
#' Aliases styler::style_pkg()
#'
#' @inheritParams styler::style_pkg
#' @seealso [`styler::style_pkg()`]
#' @export
rspkg <- function(pkg = ".",
                  ...,
                  style = styler::tidyverse_style,
                  transformers = style(...),
                  filetype = c("R", "Rprofile"),
                  exclude_files = "R/RcppExports.R",
                  exclude_dirs = c("packrat", "renv"),
                  include_roxygen_examples = TRUE) {
  styler::style_pkg(
    pkg = pkg,
    ...,
    style = style,
    transformers = transformers,
    filetype = filetype,
    exclude_files = exclude_files,
    exclude_dirs = exclude_dirs,
    include_roxygen_examples = include_roxygen_examples
  )
}

#' Alias for jeksterslabRutils::util_style()
#'
#' Alias for [`jeksterslabRutils::util_style()`]
#' with the following arguments:
#' - `dir = getwd()`
#' - `recursive = TRUE`
#' - `par = TRUE`
#' - `ncores = NULL`
#'
#' @inheritParams jeksterslabRutils::util_style
#' @seealso [`jeksterslabRutils::util_style()`]
#' @export
rstyle <- function(dir = getwd(),
                   recursive = TRUE,
                   par = TRUE,
                   ncores = NULL) {
  jeksterslabRutils::util_style(
    dir = dir,
    recursive = recursive,
    par = par,
    ncores = ncores
  )
}

#' Alias for devtools::test()
#'
#' @inheritParams devtools::test
#' @seealso [`devtools::test()`]
#' @export
rtest <- function(pkg = ".",
                  filter = NULL,
                  stop_on_failure = FALSE,
                  export_all = TRUE,
                  ...) {
  devtools::test(
    pkg = pkg,
    filter = filter,
    stop_on_failure = stop_on_failure,
    export_all = export_all,
    ...
  )
}
#' Alias for devtools::check()
#'
#' @inheritParams devtools::check
#' @seealso [`devtools::check()`]
#' @export
rchk <- function(pkg = ".",
                 document = NA,
                 build_args = NULL,
                 ...,
                 manual = FALSE,
                 cran = TRUE,
                 remote = FALSE,
                 incoming = remote,
                 force_suggests = FALSE,
                 run_dont_test = FALSE,
                 args = "--timings",
                 env_vars = c(NOT_CRAN = "true"),
                 quiet = FALSE,
                 check_dir = tempdir(),
                 cleanup = TRUE,
                 vignettes = TRUE,
                 error_on = c("never", "error", "warning", "note")) {
  devtools::check(
    pkg = pkg,
    document = document,
    build_args = build_args,
    ...,
    manual = manual,
    cran = cran,
    remote = remote,
    incoming = incoming,
    force_suggests = force_suggests,
    run_dont_test = run_dont_test,
    args = args,
    env_vars = env_vars,
    quiet = quiet,
    check_dir = check_dir,
    cleanup = cleanup,
    vignettes = vignettes,
    error_on = error_on
  )
}

#' Alias for jeksterslabRpkg::pkg_build()
#'
#' Alias for [`jeksterslabRpkg::pkg_build()`]
#' with the following arguments:
#' - `pkg_root = NULL`
#' - `minimal = FALSE`
#' - `style = TRUE`
#' - `data = TRUE`
#' - `render = TRUE`
#' - `readme = TRUE`
#' - `vignettes = TRUE`
#' - `tests = TRUE`
#' - `pkgdown = TRUE`
#' - `par = TRUE`
#' - `ncores = NULL`
#' - `git = FALSE`
#' - `github = FALSE`
#' - `commit_msg = "BUILD`
#'
#' @inheritParams pkg_build
#' @seealso [`jeksterslabRpkg::pkg_build()`]
#' @export
rbuild <- function(pkg_root = NULL,
                   minimal = FALSE,
                   style = TRUE,
                   data = TRUE,
                   render = TRUE,
                   readme = TRUE,
                   vignettes = TRUE,
                   tests = TRUE,
                   pkgdown = TRUE,
                   par = TRUE,
                   ncores = NULL,
                   git = FALSE,
                   github = FALSE,
                   commit_msg = "BUILD") {
  jeksterslabRpkg::pkg_build(
    pkg_root = pkg_root,
    minimal = minimal,
    style = style,
    data = data,
    render = render,
    readme = readme,
    vignettes = vignettes,
    tests = tests,
    pkgdown = pkgdown,
    par = par,
    ncores = ncores,
    git = git,
    github = github,
    commit_msg = commit_msg
  )
}

#' Alias for styler::style_pkg(); devtools::check(); devtools::install()
#'
#' Alias for
#' [`styler::style_pkg()`],
#' [`devtools::check()`],
#' [`devtools::install()`]
#' with default arguments.
#'
#' @seealso [`styler::style_pkg()`]
#' @seealso [`devtools::check()`]
#' @seealso [`devtools::install()`]
#' @export
rpkg <- function() {
  styler::style_pkg()
  devtools::check()
  devtools::install()
}
