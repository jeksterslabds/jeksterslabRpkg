#' Create a Package License.
#'
#' Creates a package `LICENSE` and `LICENSE.md`
#' by extracting information
#' from an external `yml` `input_file`.
#' See `system.file("extdata", "DESCRIPTION.yml", package = "jeksterslabRpkg", mustWork = TRUE)`
#' for the `input_file` template.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' **THIS FUNCTION OVERWRITES EXISTING `LICENSE` and `LICENSE.md` FILES
#' IN THE SPECIFIED PACKAGE ROOT DIRECTORY.
#' USE WITH CAUTION.**
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @inheritParams pkg_rbuildignore
#' @examples
#' \dontrun{
#' pkg_license(
#'   pkg_root = "~/boilerplatePackage",
#'   input_file = "DESCRIPTION.yml"
#' )
#' }
#' @export
pkg_license <- function(pkg_root,
                        input_file = NULL,
                        msg = "LICENSE file path:") {
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
      "Package",
      "Given",
      "Family"
    ),
    required = FALSE,
    dependencies = FALSE
  )
  input <- yml[["single"]]
  Package <- input[["Package"]]
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
    dir = pkg_root,
    fn = "LICENSE",
    msg = msg,
    overwrite = TRUE
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
    pattern = ":YEAR:",
    replacement = format(Sys.time(), "%Y"),
    x = license_md
  )
  license_md <- sub(
    pattern = ":AUTHOR:",
    replacement = paste(
      input[["Given"]],
      input[["Family"]]
    ),
    x = license_md
  )
  util_txt2file(
    text = license_md,
    dir = pkg_root,
    fn = "LICENSE.md",
    msg = msg,
    overwrite = TRUE
  )
  pkg_rbuildignore(
    pkg_root = pkg_root,
    add = "^LICENSE\\.md$"
  )
}
