#' Create a Boilerplate Package NEWS.md File.
#'
#' Creates a boilerplate package NEWS.md file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @inheritParams pkg_rbuildignore
#' @examples
#' \dontrun{
#' pkg_news(
#'   pkg_root = "~/boilerplatePackage",
#'   input_file = "DESCRIPTION.yml"
#' )
#' }
#' @export
pkg_news <- function(pkg_root,
                     input_file = NULL,
                     msg = "NEWS.md file path:") {
  if (is.null(input_file)) {
    input_file <- system.file(
      "extdata",
      "DESCRIPTION.yml",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  }
  yml <- pkg_description_yml(
    input_file = input_file
  )
  input <- yml[["single"]]
  Version <- input[["Version"]]
  pkg_name <- basename(pkg_root)
  output <- readLines(
    con = system.file(
      "extdata",
      "NEWS",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  output <- gsub(
    pattern = "BOILERPLATEPACKAGE",
    replacement = pkg_name,
    x = output
  )
  output <- gsub(
    pattern = "VERSION",
    replacement = Version,
    x = output
  )
  output <- paste0(
    output,
    collapse = "\n"
  )
  util_txt2file(
    text = output,
    dir = pkg_root,
    fn = "NEWS.md",
    msg = msg
  )
  pkg_rbuildignore(
    pkg_root = pkg_root,
    add = "^NEWS.md$"
  )
}
