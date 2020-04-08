#' Validate Package Name
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param pkg_name Character string.
#'   Package name.
#' @export
pkg_valid_name <- function(pkg_name) {
  pattern <- c(
    "^([a-zA-Z0-9.]{2,})", # at least two characters with alpha-numeric and dot values
    "^[[:alpha:]]", # begins with a letter
    "([^.])$" # does not end with a dot
  )
  output <- all(
    sapply(
      X = pattern,
      FUN = grepl,
      x = pkg_name
    )
  )
  if (!output) {
    stop(
      paste0(
        "Invalid package name.",
        "\n",
        "A valid package name should contain only letters, numbers and dot,",
        "\n",
        "have at least two characters,",
        "\n",
        "start with a letter and not end in a dot.",
        "\n"
      )
    )
  }
  output
}
