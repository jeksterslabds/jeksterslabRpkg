#' ---
#' title: "jeksterslabRpkg"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::github_document:
#'     toc: true
#' ---
#'
#+ setup
library(jeksterslabRutils)
library(jeksterslabRpkg)
tmp <- file.path(
  Sys.getenv("HOME"),
  util_rand_str()
)
dir.create(tmp)
on.exit(
  unlink(
    tmp,
    recursive = TRUE
  )
)
#'
#' ## Create a Boilerplate `R` Package.
#'
#' Creates a boilerplate `R` package by generating the following:
#'
#'   - `DESCRIPTION` file,
#'   - `NAMESPACE` file,
#'   - `LICENSE` and `LICENSE.md`,
#'   - a simple `R` script and accompanying `Rd` documentation file,
#'   - sample data, test, and vignette,
#'   - optional `pkgdown` and `travis` `YAML` files,
#'   - optional `README.Rmd` file, and
#'   - other files like `.Rbuildignore`, `.gitignore`, and `Rproj`.
#'
#' Optionally, the function can also set up a `Git` repository
#' and push the created repo to `Github`.
#' This requires that `git` and `hub` are installed
#' and configured in the system.
#'
#' If you are going to document, check, and build your package using `devtools`,
#' you may delete the boilerplate `NAMESPACE` and `MAN` files.
#'
#' ### input_file = NULL
#'
#+ create_01
pkg_create(
  pkg_dir = tmp,
  pkg_name = "boilerplatePackage",
  input_file = NULL,
  pkgdown = TRUE,
  travis = TRUE,
  appveyor = TRUE,
  readme = TRUE,
  add_description = NULL,
  add_namespace = NULL,
  add_rbuildignore = NULL,
  add_gitignore = NULL,
  add_travis = NULL,
  add_appveyor = NULL,
  git = FALSE,
  github = FALSE
)
#'
#' ### input_file = "DESCRIPTION.csv"
#'
#+ creare_02
input_file <- system.file(
  "extdata",
  "DESCRIPTION.csv",
  package = "jeksterslabRpkg",
  mustWork = TRUE
)
pkg_create(
  pkg_dir = tmp,
  pkg_name = "boilerplatePackage",
  input_file = input_file,
  pkgdown = TRUE,
  travis = TRUE,
  appveyor = TRUE,
  readme = TRUE,
  add_description = NULL,
  add_namespace = NULL,
  add_rbuildignore = NULL,
  add_gitignore = NULL,
  add_travis = NULL,
  add_appveyor = NULL,
  git = FALSE,
  github = FALSE
)
#'
#' ## Build Package.
#'
#' Builds the `R` package on `pkg_root` by:
#'
#'   - styling the `R` scripts and `R` Markdown files,
#'   - building package data by running `R` scripts stored in `data_raw`,
#'   - rendering the `R` scripts and `R` Markdown files using `rmarkdown::render()`, and
#'   - building `pkgdown` site.
#'
#' ### minimal = TRUE
#'
#+ build_01
pkg_build(
  pkg_root = file.path(
    tmp,
    "boilerplatePackage"
  ),
  minimal = TRUE,
  par = FALSE
)
#'
#' ### minimal = FALSE
#'
#+ build_02
# pkg_build(
#  pkg_root = file.path(
#    tmp,
#    "boilerplatePackage"
#  ),
#  minimal = FALSE,
#  style = TRUE,
#  data = TRUE,
#  render = TRUE,
#  readme = TRUE,
#  vignettes = TRUE,
#  tests = TRUE,
#  pkgdown = TRUE,
#  par = FALSE
# )
