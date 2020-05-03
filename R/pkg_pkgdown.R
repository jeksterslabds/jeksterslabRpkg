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
#' @inheritParams pkg_rbuildignore
#' @importFrom pkgdown build_site
#' @examples
#' \dontrun{
#' pkg_pkgdown(
#'   pkg_root = "~/boilerplatePackage",
#'   input_file = "DESCRIPTION.yml"
#' )
#' }
#' @export
pkg_pkgdown <- function(pkg_root,
                        input_file = NULL,
                        msg = "_pkgdown.yml file path:") {
  pkg_name <- basename(pkg_root)
  if (is.null(input_file)) {
    input_file <- system.file(
      "extdata",
      "DESCRIPTION.yml",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  }
  yml <- pkg_description_yml(
    input_file = input_file,
    fields = "Github",
    required = FALSE,
    dependencies = FALSE
  )
  input <- yml[["single"]]
  Github <- input[["Github"]]
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
    dir = pkg_root,
    fn = "_pkgdown.yml",
    msg = msg,
    overwrite = TRUE
  )
  build_site(pkg = pkg_root)
  pkg_rbuildignore(
    pkg_root = pkg_root,
    add = "^_pkgdown.yml$\n^docs$"
  )
}
