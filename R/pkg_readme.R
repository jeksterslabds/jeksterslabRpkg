#' Create a Boilerplate Package README File.
#'
#' Creates a boilerplate package `README.Rmd` file
#' by extracting information
#' from an external `csv` `input_file`.
#' See `system.file("extdata", "DESCRIPTION.csv", package = "jeksterslabRpkg", mustWork = TRUE)`
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
#' @inheritParams pkg_description
#' @examples
#' \dontrun{
#' pkg_readme(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage",
#'   input_file = "DESCRIPTION.csv"
#' )
#' }
#' @export
pkg_readme <- function(pkg_dir = getwd(),
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
        "Given",
        "Family"
      )
      %in%
        names(input)
    )
  ) {
    stop(
      "input_csv does not have the necessary fields.\n"
    )
  }
  root <- file.path(
    pkg_dir,
    pkg_name
  )
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
    dir = root,
    fn = "README.Rmd"
  )
  pkg_rbuildignore(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = paste(
      "^README\\.Rmd$",
      "^README\\.md$",
      "^README\\.html$",
      sep = "\n"
    )
  )
}
