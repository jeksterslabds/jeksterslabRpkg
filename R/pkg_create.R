#' Create a Boilerplate `R` Package
#'
#' Creates a boilerplate `R` package by generating the following:
#' - `DESCRIPTION` file
#'   (see [jeksterslabRpkg::pkg_description()]),
#' - `NAMESPACE` file
#'   (see [jeksterslabRpkg::pkg_namespace()]),
#' - `LICENSE` and `LICENSE.md`
#'   (see [jeksterslabRpkg::pkg_license()]),
#' - a simple `R` script and accompanying `Rd` documentation file
#'   (see [jeksterslabRpkg::pkg_r()] and [jeksterslabRpkg::pkg_rd()]),
#' - sample data, test, and vignette
#'   (see [jeksterslabRpkg::pkg_data()], [jeksterslabRpkg::pkg_test()], and
#'   [jeksterslabRpkg::pkg_vignette()]),
#' - optional `pkgdown` and `travis` `YAML` files
#'   (see [jeksterslabRpkg::pkg_pkgdown()] and [jeksterslabRpkg::pkg_travis()]),
#' - optional `README.Rmd` file
#'   (see [jeksterslabRpkg::pkg_readme()]), and
#' - other files like `.Rbuildignore`, `.gitignore`, and `Rproj`.
#'
#' Optionally, the function can also set up a `Git` repository
#' and push the created repo to `Github`.
#' This requires that `git` and `hub` are installed
#' and configured in the system.
#'
#' If you are going to document, check, and build your package using `devtools`,
#' you may delete the boilerplate `NAMESPACE` and `MAN` files.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_gitignore
#' @inheritParams pkg_description
#' @inheritParams pkg_git
#' @param pkgdown Logical.
#' Create `pkgdown` `YAML` file.
#' @param travis Logical.
#' Create `travis` `YAML` file.
#' @param appveyor Logical.
#' Create `appveyor` `YAML` file.
#' @param readme Logical.
#' Create `README.Rmd` file.
#' @param add_description Character string.
#' Additional entries to the `DESCRIPTION` file
#' not included in `input_file`.
#' @param add_namespace Character string.
#' Entries to the `NAMESPACE`
#' in addition to the boilerplate example.
#' @param add_rbuildignore Character string.
#' Entries to the `.Rbuildignore`
#' in addition to the boilerplate example.
#' @param add_gitignore Character string.
#' Entries to the `.gitignore`
#' in addition to the boilerplate example.
#' @param add_travis Character string.
#' Entries to the `.travis.yml`
#' in addition to the boilerplate example.
#' @param add_appveyor Character string.
#' Entries to the `appveyor.yml`
#' in addition to the boilerplate example.
#' @param git Logical.
#' Set up a git repository.
#' @examples
#' \dontrun{
#' pkg_create(
#'   pkg_dir = getwd(),
#'   pkg_name = "boilerplatePackage",
#'   input_file = "DESCRIPTION.csv",
#'   git = TRUE,
#'   github = TRUE
#' )
#' }
#' @export
pkg_create <- function(pkg_dir = getwd(),
                       input_file = NULL,
                       docs = TRUE,
                       pkgdown = FALSE,
                       travis = FALSE,
                       appveyor = FALSE,
                       readme = FALSE,
                       add_description = NULL,
                       add_namespace = NULL,
                       add_rbuildignore = NULL,
                       add_gitignore = NULL,
                       add_travis = NULL,
                       add_appveyor = NULL,
                       git = FALSE,
                       github = FALSE,
                       commit_msg = "And so, it begins") {
  yml <- pkg_description_yml(
    input_file = input_file,
    fields = "Package",
    required = FALSE,
    dependencies = FALSE
  )
  input <- yml[["single"]]
  Package <- input[["Package"]]
  pkg_root <- file.path(
    pkg_dir,
    Package
  )
  message(
    paste(
      "Creating",
      pkg_root
    )
  )
  # It is important to create the .Rbuildignore and .gitignore first
  # because other functions add entries to it.
  pkg_rbuildignore(
    pkg_root = pkg_root,
    add = add_rbuildignore
  )
  pkg_gitignore(
    pkg_root = pkg_root,
    add = add_gitignore,
    docs = docs
  )
  pkg_description(
    pkg_dir = pkg_dir,
    input_file = input_file,
    add = add_description
  )
  pkg_license(
    pkg_root = pkg_root,
    input_file = input_file
  )
  pkg_namespace(
    pkg_root = pkg_root,
    add = add_namespace
  )
  pkg_r(
    pkg_root = pkg_root
  )
  pkg_rd(
    pkg_root = pkg_root
  )
  pkg_vignette(
    pkg_root = pkg_root
  )
  pkg_test(
    pkg_root = pkg_root
  )
  pkg_data(
    pkg_root = pkg_root
  )
  pkg_rproj(
    pkg_root = pkg_root
  )
  pkg_news(
    pkg_root = pkg_root
  )
  pkg_getstarted(
    pkg_root = pkg_root
  )
  if (travis) {
    pkg_travis(
      pkg_root = pkg_root,
      add = add_travis
    )
  }
  if (appveyor) {
    pkg_appveyor(
      pkg_root = pkg_root,
      add = add_appveyor
    )
  }
  if (pkgdown) {
    pkg_pkgdown(
      pkg_root = pkg_root,
      input_file = input_file
    )
  }
  if (readme) {
    pkg_readme(
      pkg_root = pkg_root,
      input_file = input_file
    )
  }
  message(
    paste0(
      Package,
      " has been saved in ",
      pkg_root,
      "."
    )
  )
  message(
    paste(
      "If you are going to document, check, and build",
      Package,
      "using `devtools`, you may delete the boilerplate `NAMESPACE` and `MAN` files."
    )
  )
  if (git) {
    pkg_git(
      pkg_root = pkg_root,
      github = github,
      commit_msg = commit_msg
    )
  }
}
