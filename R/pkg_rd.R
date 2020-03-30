#' Create Boilerplate Package RD Function Documentation.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @export
pkg_rd <- function(pkg_dir = getwd(),
                   pkg_name) {
  man <- file.path(
    pkg_dir,
    pkg_name,
    "man"
  )
  output <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "zRd",
        package = "jeksterslabRpkg",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  output <- paste0(
    "% This is a boilerplate example.",
    "\n",
    "% Delete this file if you are building documentation files with roxygen.",
    "\n",
    output
  )
  util_txt2file(
    text = output,
    dir = man,
    fn = "z.Rd"
  )
}
