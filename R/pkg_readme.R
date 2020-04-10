#' Create a Boilerplate Package README File.
#'
#' Creates a boilerplate package `README.Rmd` file
#' by extracting information
#' from an external `yml` `input_file`.
#' See `system.file("extdata", "DESCRIPTION.yml", package = "jeksterslabRpkg", mustWork = TRUE)`
#' for the `input_file` template.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' **THIS FUNCTION OVERWRITES AN EXISTING `README.Rmd` FILE
#' IN THE SPECIFIED PACKAGE ROOT DIRECTORY.
#' USE WITH CAUTION.**
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_rbuildignore
#' @inheritParams pkg_description
#' @examples
#' \dontrun{
#' pkg_readme(
#'   pkg_root = "~/boilerplatePackage",
#'   input_file = "DESCRIPTION.yml"
#' )
#' }
#' @export
pkg_readme <- function(pkg_root,
                       input_file = NULL,
                       msg = "README.Rmd file path:") {
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
    fields = c(
      "Given",
      "Family",
      "Github"
    ),
    required = FALSE,
    dependencies = FALSE
  )
  input <- yml[["single"]]
  Given <- input[["Given"]]
  Family <- input[["Family"]]
  Github <- input[["Github"]]
  author <- paste(
    input[["Given"]],
    input[["Family"]]
  )
  readme <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "README",
        package = "jeksterslabRpkg",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  readme <- gsub(
    pattern = "BOILERPLATEPACKAGE",
    replacement = pkg_name,
    x = readme
  )
  readme <- gsub(
    pattern = "AUTHOR",
    replacement = author,
    x = readme
  )
  readme <- gsub(
    pattern = "GITHUBACCOUNT",
    replacement = Github,
    x = readme
  )
  util_txt2file(
    text = readme,
    dir = pkg_root,
    fn = "README.Rmd",
    msg = msg
  )
  pkg_rbuildignore(
    pkg_root = pkg_root,
    add = paste(
      "^README\\.Rmd$",
      "^README\\.md$",
      "^README\\.html$",
      sep = "\n"
    )
  )
}
