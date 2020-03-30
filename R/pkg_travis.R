#' Create Boilerplate Package .travis.yml.
#'
#' Creates .travis.yml with \code{codecov}.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @param add Character string.
#'   Entries to the \code{.gitignore}
#'   in addition to the boilerplate example.
#' @examples
#' pkg_travis(pkg_dir = tempdir(), pkg_name = "boilerplatePackage")
#' @export
pkg_travis <- function(pkg_dir = getwd(),
                       pkg_name,
                       add = NULL) {
  root <- file.path(
    pkg_dir,
    pkg_name
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "travis",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  if (!is.null(add)) {
    output <- paste0(
      output,
      "\n",
      add
    )
  }
  util_txt2file(
    text = output,
    dir = root,
    fn = ".travis.yml"
  )
  pkg_rbuildignore(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = "^.travis.yml$"
  )
}
