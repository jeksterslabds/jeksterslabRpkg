#' Find Package Root Directory
#'
#' Finds package root directory by seraching for
#' tne DESCRIPTION file that contains
#' `Package: pkg_name`.
#'
#' The function starts searching the specified `dir`.
#' If the search does not return the root directory
#' for the specified `pkg_name`,
#' If the function fails to find a valid package root directory in dir,
#' the following directories will be searched:
#'   - `../dir`
#'   - `../../dir`
#'   - `working directory` (`getwd()`)
#'   - `Sys.getenv("HOME")`
#'   - "/"
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   Directory to search.
#'   If unspecified, defaults to `Sys.getenv("HOME")`.
#' @param pkg_name Character string.
#'   Package name.
#' @inheritParams pkg_description
#' @inheritParams util_lapply
#' @export
pkg_find_root <- function(dir = getwd(),
                          pkg_name,
                          par = TRUE,
                          ncores = NULL) {
  wd <- getwd()
  setwd(dir)
  setwd("..")
  dir_dotdot <- getwd()
  setwd(dir)
  setwd("../..")
  dir_dotdotdotdot <- getwd()
  setwd(wd)
  dir_vec <- c(
    dir_dotdot,
    dir_dotdotdotdot,
    wd,
    Sys.getenv("HOME"),
    "/"
  )
  setwd(wd)
  foo <- function(dir,
                  pkg_name,
                  par,
                  ncores) {
    message(
      paste(
        "Searching",
        dir,
        "\n"
      )
    )
    files <- list.files(
      path = dir,
      pattern = "^DESCRIPTION$",
      recursive = TRUE,
      full.names = TRUE,
      include.dirs = TRUE
    )
    # Return pkg_dir character(0)
    # if length(files) == 0
    if (length(files) == 0) {
      warning(
        "No files matched the filename DESCRIPTION.\n"
      )
      pkg_dir <- character(0)
      return(pkg_dir)
    } else {
      # continue only if length(file) > 0
      # remove matches from R libraries
      libs <- .libPaths()
      for (i in seq_along(libs)) {
        files <- files[!grepl(pattern = libs[i], x = files)]
      }
      # match Package: pkg_name in froun DESCRIPTION
      bar <- function(file, pkg_name) {
        file <- readLines(file)
        any(
          grepl(
            pattern = paste0(
              "^Package:[[:space:]]*",
              pkg_name,
              "[[:space:]]*$"
            ),
            x = file
          )
        )
      }
      pkg_dir <- util_lapply(
        FUN = bar,
        args = list(
          file = files,
          pkg_name = pkg_name
        ),
        par = par,
        ncores = ncores
      )
      pkg_dir <- unlist(pkg_dir, use.names = FALSE)
      names(pkg_dir) <- files
      pkg_dir <- dirname(names(pkg_dir[pkg_dir]))
      # basename == pkg_name
      # basename should be the same as pkg_name
      temp_pkg_dir <- rep(
        x = NA,
        times = length(pkg_dir)
      )
      for (i in seq_along(pkg_dir)) {
        if (basename(pkg_dir[i]) == pkg_name) {
          temp_pkg_dir[i] <- pkg_dir[i]
        } else {
          temp_pkg_dir[i] <- NA
        }
      }
      pkg_dir <- temp_pkg_dir[!is.na(temp_pkg_dir)]
      # return single match
      if (length(pkg_dir) == 1) {
        return(
          normalizePath(
            pkg_dir
          )
        )
      }
      # return multiple match
      if (length(pkg_dir) > 1) {
        return(
          normalizePath(
            pkg_dir
          )
        )
      }
      if (length(pkg_dir) == 0) {
        message(
          "basename != pkg_name.\n"
        )
        pkg_dir <- character(0)
        return(pkg_dir)
      }
    }
  }
  pkg_dir <- foo(
    dir = dir,
    pkg_name = pkg_name,
    par = par,
    ncores = ncores
  )
  # single output
  if (length(pkg_dir) == 1) {
    return(
      normalizePath(
        pkg_dir
      )
    )
  }
  # multiple output
  if (length(pkg_dir) > 1) {
    warning(
      "More than one package root directory found.\n"
    )
    return(
      normalizePath(
        pkg_dir
      )
    )
  }
  # rerun id no match found in dir
  for (i in seq_along(dir_vec)) {
    if (length(pkg_dir) == 0) {
      pkg_dir <- foo(
        dir = dir_vec[i],
        pkg_name = pkg_name,
        par = par,
        ncores = ncores
      )
    }
  }
  # no match
  if (length(pkg_dir) == 0) {
    stop(
      "No valid package root directory found.\n"
    )
  }
}
