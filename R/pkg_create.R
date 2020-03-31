#' Create a Boilerplate `R` Package.
#'
#' Creates a boilerplate `R` package by generating the following:
#'   - `DESCRIPTION` file
#'     (see [jeksterslabRpkg::pkg_description()]),
#'   - `NAMESPACE` file
#'     (see [jeksterslabRpkg::pkg_namespace()]),
#'   - `LICENSE` and `LICENSE.md`
#'     (see [jeksterslabRpkg::pkg_license()]),
#'   - a simple `R` script and accompanying `Rd` documentation file
#'     (see [jeksterslabRpkg::pkg_r()] and [jeksterslabRpkg::pkg_rd()]),
#'   - sample data, test, and vignette
#'     (see [jeksterslabRpkg::pkg_data()], (see [jeksterslabRpkg::pkg_test()], and
#'     [jeksterslabRpkg::pkg_vignette()]),
#'   - optional `pkgdown` and `travis` `YAML` files
#'     (see [jeksterslabRpkg::pkg_pkgdown()] and [jeksterslabRpkg::pkg_travis()]),
#'   - optional `README.Rmd` file
#'     (see [jeksterslabRpkg::pkg_readme()]), and
#'   - other files like `.Rbuildignore`, `.gitignore`, and `Rproj`.
#'
#' Optionally, the function can also set up a `Git` repository
#' and push the created repo to `Github`.
#' This requires that `git` and `hub` are installed
#' and configured in the system.
#'
#' If you are going to document, check, and build your package using `devtools`,
#' you may delete the boillerplate `NAMESPACE` and `MAN` files.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @param pkgdown Logical.
#'   Create `pkgdown` `YAML` file.
#' @param travis Logical.
#'   Create `travis` `YAML` file.
#' @param appveyor Logical.
#'   Create `appveyor` `YAML` file.
#' @param readme Logical.
#'   Create `README.Rmd` file.
#' @param add_description Character string.
#'   Additional entries to the `DESCRIPTION` file
#'   not included in `input_file`.
#' @param add_namespace Character string.
#'   Entries to the `NAMESPACE`
#'   in addition to the boilerplate example.
#' @param add_rbuildignore Character string.
#'   Entries to the `.Rbuildignore`
#'   in addition to the boilerplate example.
#' @param add_gitignore Character string.
#'   Entries to the `.gitignore`
#'   in addition to the boilerplate example.
#' @param add_travis Character string.
#'   Entries to the `.travis.yml`
#'   in addition to the boilerplate example.
#' @param add_appveyor Character string.
#'   Entries to the `appveyor.yml`
#'   in addition to the boilerplate example.
#' @param git Logical.
#'   Set up a git repository.
#' @param github Logical.
#'   Set up and push to a github repository.
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
                       pkg_name = "boilerplatePackage",
                       input_file = NULL,
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
                       github = FALSE) {
  root <- file.path(
    pkg_dir,
    pkg_name
  )
  # It is important to create the .Rbuildignore and .gitignore first
  # because other functions add entries to it.
  pkg_rbuildignore(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = add_rbuildignore
  )
  pkg_gitignore(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = add_gitignore
  )
  pkg_description(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    input_file = input_file,
    add = add_description
  )
  pkg_license(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    input_file = input_file
  )
  pkg_namespace(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = add_namespace
  )
  pkg_r(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name
  )
  pkg_rd(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name
  )
  pkg_vignette(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name
  )
  pkg_test(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name
  )
  pkg_data(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name
  )
  pkg_rproj(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name
  )
  if (travis) {
    pkg_travis(
      pkg_dir = pkg_dir,
      pkg_name = pkg_name,
      add = add_travis
    )
  }
  if (appveyor) {
    pkg_appveyor(
      pkg_dir = pkg_dir,
      pkg_name = pkg_name,
      add = add_appveyor
    )
  }
  if (pkgdown) {
    pkg_pkgdown(
      pkg_dir = pkg_dir,
      pkg_name = pkg_name
    )
  }
  if (readme) {
    pkg_readme(
      pkg_dir = pkg_dir,
      pkg_name = pkg_name,
      input_file = input_file
    )
  }
  cat(
    paste0(
      pkg_name,
      " has been saved in ",
      root,
      ".",
      "\n"
    )
  )
  cat(
    paste(
      "If you are going to document, check, and build",
      pkg_name,
      "using `devtools`, you may delete the boilerplate `NAMESPACE` and `MAN` files.\n"
    )
  )
  if (git) {
    cat("Setting up git repository.\n")
    try(
      system(
        paste(
          "git -C",
          shQuote(root),
          "init"
        )
      )
    )
    try(
      system(
        paste(
          "git -C",
          shQuote(root),
          "add --all"
        )
      )
    )
    try(
      system(
        paste(
          "git -C",
          shQuote(root),
          "commit -m \"And so, it begis.\""
        )
      )
    )
    if (github) {
      cat("Creating and pushing to a remote GiHub repository.\n")
      try(
        system(
          paste(
            "hub -C",
            shQuote(root),
            "create"
          )
        )
      )
      try(
        system(
          paste(
            "git -C",
            shQuote(root),
            "push -u origin HEAD"
          )
        )
      )
    }
  }
}
