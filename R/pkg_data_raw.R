#' Source `R` Files in data_raw.
#'
#' Sources `R` files in data_raw.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_build
#' @examples
#' \dontrun{
#' pkg_data_raw(
#'   pkg_root = "~/boilerplatePackage"
#' )
#' }
#' @export
pkg_data_raw <- function(pkg_root = getwd()) {
  wd <- getwd()
  message(
    "Generating data..."
  )
  data_raw <- file.path(
    pkg_root,
    "data_raw"
  )
  if (dir.exists(data_raw)) {
    setwd(data_raw)
    files <- util_search_r(
      dir = normalizePath(data_raw),
      all.files = FALSE,
      rscript = TRUE,
      rmd = TRUE,
      full.names = TRUE,
      recursive = TRUE,
      ignore.case = TRUE,
      no.. = FALSE
    )
    if (length(files) > 0) {
      tryCatch(
        {
          lapply(
            X = files,
            FUN = source
          )
        },
        error = function(err) {
          warning(
            "Error in data generation."
          )
        }
      )
    } else {
      message("No R files in data_raw.")
    }
  } else {
    message("data_raw does not exist.")
  }
  setwd(wd)
}
