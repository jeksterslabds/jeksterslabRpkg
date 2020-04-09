#' Check Package Root
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory.
#' @export
pkg_checkroot <- function(dir = getwd()) {
  if (file.exists(
    file.path(
      dir,
      "DESCRIPTION"
    )
  )
  ) {
    if (dir.exists(
      file.path(
        dir,
        "R"
      )
    )
    ) {
      return(TRUE)
    } else {
      return(FALSE)
    }
  } else {
    return(FALSE)
  }
}

#' Check pkg_root/subdir
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param subdir Character string.
#'   Sub directory.
#' @inheritParams pkg_checkroot
#' @export
pkg_checkroot_subdir <- function(dir = getwd(),
                                 subdir = c(
                                   "R",
                                   "data",
                                   "data_raw",
                                   "man",
                                   "tests",
                                   file.path("tests", "testthat"),
                                   "vignettes"
                                 )) {
  path <- file.path(
    dir,
    subdir
  )
  if (dir.exists(path)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
