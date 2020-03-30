#' Create Boilerplate Package R Package.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams pkg_description
#' @param add_description Character string.
#'   Additional entries to the \code{DESCRIPTION} file
#'   not included in \code{input_file}
#' @param add_namespace Character string.
#'   Entries to the \code{NAMESPACE}
#'   in addition to the boilerplate example.
#' @param add_rbuildignore Character string.
#'   Entries to the \code{.Rbuildignore}
#'   in addition to the boilerplate example.
#' @param add_gitignore Character string.
#'   Entries to the \code{.gitignore}
#'   in addition to the boilerplate example.
#' @param add_travis Character string.
#'   Entries to the \code{.travis.yml}
#'   in addition to the boilerplate example.
#' @param git Logical.
#'   Set up a git repository.
#' @param github Logical.
#'   Set up and push to a github repository.
#' @export
pkg_create <- function(pkg_dir = getwd(),
                       pkg_name = "boilerplatePackage",
                       input_file = NULL,
                       add_description = NULL,
                       add_namespace = NULL,
                       add_rbuildignore = NULL,
                       add_gitignore = NULL,
                       add_travis = NULL,
                       git = FALSE,
                       github = FALSE) {
  root <- file.path(
    pkg_dir,
    pkg_name
  )
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
  pkg_vignettes(
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
  pkg_travis(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    add = add_travis
  )
  pkg_pkgdown(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name
  )
  pkg_readme(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name,
    input_file = input_file
  )
  pkg_rproj(
    pkg_dir = pkg_dir,
    pkg_name = pkg_name
  )
  cat(
    paste0(
      pkg_name,
      " has been saved in ",
      root,
      ".",
      "\n"
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
