#' Create Package LICENSE.
#'
#' Creates package \code{LICENSE} and \code{LICENSE.md}
#' by extracting information
#' from an external \code{csv} \code{input_file}.
#' See \code{system.file("extdata", "DESCRIPTION.csv", package = "jeksterslabRpkg", mustWork = TRUE)}
#' For the \code{input_file} template.
#' THIS FUNCTION OVERWRITES AN EXISTING \code{LICENSE} and \code{LICENSE.md} FILE
#' IN THE SPECIFIED PACKAGE ROOT DIRECTORY.
#' USE WITH CAUTION.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @export
pkg_license <- function(pkg_dir = getwd(),
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
  license <- paste0(
    "YEAR: ",
    format(Sys.time(), "%Y"),
    "\n",
    "COPYRIGHT HOLDER: ",
    input[["Given"]],
    " ",
    input[["Family"]]
  )
  util_txt2file(
    text = license,
    dir = root,
    fn = "LICENSE"
  )
  license_md <- readLines(
    con = system.file(
      "extdata",
      "LICENSE.md",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  license_md <- sub(
    pattern = "YEAR",
    replacement = format(Sys.time(), "%Y"),
    x = license_md
  )
  license_md <- sub(
    pattern = "AUTHOR",
    replacement = paste(
      input[["Given"]],
      input[["Family"]]
    ),
    x = license_md
  )
  util_txt2file(
    text = license_md,
    dir = root,
    fn = "LICENSE.md"
  )
  pkg_rbuildignore(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = "^LICENSE\\.md$"
  )
}
