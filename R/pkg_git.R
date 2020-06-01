#' Git and Github
#'
#' Set up a `Git` repository
#' and push the created repo to `Github`.
#' This requires that `git` and `hub` are installed
#' and configured in the system.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param pkg_root Character string.
#'   Package root directory.
#' @param github Logical.
#'   Set up and push to a github repository.
#' @param commit_msg Character string.
#'   Git commit message.
#' @examples
#' \dontrun{
#' pkg_git(
#'   pkg_root = "boilerplatePackage",
#'   github = TRUE,
#'   commit_msg = "Meaningful commit message"
#' )
#' }
#' @export
pkg_git <- function(pkg_root,
                    github = TRUE,
                    commit_msg = "AUTOMATED BUILD") {
  if (nchar(Sys.which("git")) == 0) {
    stop(
      "`git` command is not installed in the system."
    )
  }
  message(
    "Setting up `git` repository."
  )
  tryCatch(
    {
      system(
        paste(
          "git -C",
          shQuote(pkg_root),
          "init"
        )
      )
    },
    error = function(err) {
      warning(
        "Error in `git -C init`."
      )
    }
  )
  tryCatch(
    {
      system(
        paste(
          "git -C",
          shQuote(pkg_root),
          "add --all"
        )
      )
    },
    error = function(err) {
      warning(
        "Error in `git -C add --all`."
      )
    }
  )
  tryCatch(
    {
      system(
        paste0(
          "git -C ",
          shQuote(pkg_root),
          " commit -m \"",
          commit_msg,
          ".\""
        )
      )
    },
    error = function(err) {
      warning(
        "Error in `git -C commit`."
      )
    }
  )
  if (github) {
    if (nchar(Sys.which("hub")) == 0) {
      stop(
        "`hub` command is not installed in the system."
      )
    }
    message(
      "Creating and pushing to a remote GiHub repository."
    )
    tryCatch(
      {
        system(
          paste(
            "hub -C",
            shQuote(pkg_root),
            "create"
          )
        )
      },
      error = function(err) {
        warning(
          "Error in `hub -C create`."
        )
      }
    )
    tryCatch(
      {
        system(
          paste(
            "git -C",
            shQuote(pkg_root),
            "push -u origin HEAD"
          )
        )
      },
      error = function(err) {
        warning(
          "Error in `git -C push -u origin HEAD`."
        )
      }
    )
  }
}
