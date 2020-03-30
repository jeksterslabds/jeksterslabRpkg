#' Create Boilerplate Package .gitignore.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @param add Character string.
#'   Entries to the \code{.gitignore}
#'   in addition to the boilerplate example.
#' @examples
#' pkg_gitignore(pkg_dir = tempdir(), pkg_name = "boilerplatePackage")
#' @export
pkg_gitignore <- function(pkg_dir = getwd(),
                          pkg_name,
                          add = NULL) {
  root <- file.path(
    pkg_dir,
    pkg_name
  )
  if (file.exists(file.path(root, ".gitignore"))) {
    output <- paste0(
      readLines(
        con = file.path(
          root,
          ".gitignore"
        )
      ),
      collapse = "\n"
    )
  } else {
    output <- paste0(
      readLines(
        con = system.file(
          "extdata",
          "gitignore",
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
    fn = ".gitignore"
  )
}
