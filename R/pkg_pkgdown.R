#' Create a Boilerplate Package `_pkgdown.yml`.
#'
#' Creates a `_pkgdown.yml` build file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' and the argument `pkgdown = TRUE` is specified,
#' this function will be called.
#'
#' **THIS FUNCTION OVERWRITES AN EXISTING `_pkgdown.yml` FILE
#' IN THE SPECIFIED PACKAGE ROOT DIRECTORY.
#' USE WITH CAUTION.**
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @importFrom pkgdown build_site
#' @examples
#' \dontrun{
#' pkg_pkgdown(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage",
#'   input_file = "DESCRIPTION.csv"
#' )
#' }
#' @export
pkg_pkgdown <- function(pkg_dir = getwd(),
                        pkg_name,
                        input_file = NULL) {
  if (is.null(input_file)) {
    input_file <- system.file(
      "extdata",
      "DESCRIPTION.csv",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  }
  input <- t(
    read.csv(
      file = input_file,
      stringsAsFactors = FALSE,
      row.names = "field"
    )
  )
  input_names <- colnames(input)
  input <- as.vector(input[-1, ])
  names(input) <- input_names
  if (
    !all(
      c(
        "Github"
      )
      %in%
        names(input)
    )
  ) {
    stop(
      "input_csv does not have the necessary fields.\n"
    )
  }
  Github <- input[["Github"]]
  root <- file.path(
    pkg_dir,
    pkg_name
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "pkgdown",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  output <- gsub(
    pattern = "GITHUBACCOUNT",
    replacement = Github,
    x = output
  )
  output <- gsub(
    pattern = "BOILERPLATEPACKAGE",
    replacement = pkg_name,
    x = output
  )
  util_txt2file(
    text = output,
    dir = root,
    fn = "_pkgdown.yml"
  )
  build_site(pkg = root)
  pkg_rbuildignore(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = "^_pkgdown.yml$\n^docs$"
  )
}
