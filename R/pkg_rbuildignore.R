#' Create Boilerplate Package .Rbuildignore.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @param add Character string.
#'   Entries to the \code{.Rbuildignore}
#'   in addition to the boilerplate example.
#' @examples
#' pkg_rbuildignore(pkg_dir = tempdir(), pkg_name = "boilerplatePackage")
#' @export
pkg_rbuildignore <- function(pkg_dir = getwd(),
                             pkg_name,
                             add = NULL) {
  root <- file.path(
    pkg_dir,
    pkg_name
  )
  if (file.exists(file.path(root, ".Rbuildignore"))) {
    output <- paste0(
      readLines(
        con = file.path(
          root,
          ".Rbuildignore"
        )
      ),
      collapse = "\n"
    )
  } else {
    output <- paste0(
      readLines(
        con = system.file(
          "extdata",
          "Rbuildignore",
          package = "jeksterslabRpkg",
          mustWork = TRUE
        )
      ),
      collapse = "\n"
    )
  }
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
    fn = ".Rbuildignore"
  )
}
