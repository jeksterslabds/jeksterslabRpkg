#' Create a Boilerplate Package Data File
#'
#' Creates a boilerplate package data file.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_rbuildignore
#' @examples
#' \dontrun{
#' pkg_data(
#'   pkg_root = "~/boilerplatePackage"
#' )
#' }
#' @export
pkg_data <- function(pkg_root,
                     msg = "Data script file path:") {
  Rbuildignore <- file.path(
    pkg_root,
    ".Rbuildignore"
  )
  if (!file.exists(Rbuildignore)) {
    pkg_rbuildignore(
      pkg_root = pkg_root
    )
  }
  Rbuildignore <- paste0(
    readLines(
      con = Rbuildignore
    ),
    collapse = "\n"
  )
  if (
    !any(
      grepl(
        pattern = "data_raw",
        x = Rbuildignore
      )
    )
  ) {
    Rbuildignore <- paste0(
      Rbuildignore,
      "\n",
      "^data_raw$"
    )
    util_txt2file(
      text = Rbuildignore,
      dir = pkg_root,
      fn = ".Rbuildignore",
      overwrite = TRUE
    )
  }
  wd <- getwd()
  root_data_raw <- file.path(
    pkg_root,
    "data_raw"
  )
  data_raw_galton_r <- "data_raw_galton.R"
  output_data_raw_galton_r <- readLines(
    con = system.file(
      "extdata",
      "data_raw_galtonR",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  util_txt2file(
    text = output_data_raw_galton_r,
    dir = root_data_raw,
    fn = data_raw_galton_r,
    msg = msg,
    overwrite = TRUE
  )
  data_galton_tsv <- "data_galton.tsv"
  output_data_galton_tsv <- readLines(
    con = system.file(
      "extdata",
      "data_galton.tsv",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  util_txt2file(
    text = output_data_galton_tsv,
    dir = root_data_raw,
    fn = data_galton_tsv,
    overwrite = TRUE
  )
  setwd(root_data_raw)
  source(data_raw_galton_r)
  setwd(wd)
  data_galton_r <- "data_galton.R"
  output_data_galton_r <- readLines(
    con = system.file(
      "extdata",
      "data_galtonR",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  util_txt2file(
    text = output_data_galton_r,
    dir = file.path(pkg_root, "R"),
    fn = data_galton_r,
    overwrite = TRUE
  )
  root_man <- file.path(
    pkg_root,
    "man"
  )
  output_galton_rd <- readLines(
    con = system.file(
      "extdata",
      "galtonRd",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  )
  util_txt2file(
    text = output_galton_rd,
    dir = root_man,
    fn = "galton.Rd",
    overwrite = TRUE
  )
}
