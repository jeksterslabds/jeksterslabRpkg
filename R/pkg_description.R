#' Create a Package `DESCRIPTION` File.
#'
#' Creates a package `DESCRIPTION` file
#' by extracting information
#' from an external `yml` `input_file`.
#' See `system.file("extdata", "DESCRIPTION.yml", package = "jeksterslabRpkg", mustWork = TRUE)`
#' for the `input_file` template.
#'
#' Note that if [jeksterslabRpkg::pkg_create()] is used,
#' this function will be called.
#'
#' **THIS FUNCTION OVERWRITES AN EXISTING `DESCRIPTION` FILE
#' IN THE SPECIFIED PACKAGE ROOT DIRECTORY.
#' USE WITH CAUTION.**
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param pkg_dir Character string.
#'   Directory where the package is initialized.
#' @param add Character string.
#'   Additional entries to the `DESCRIPTION` file
#'   not included in `input_file`
#' @param msg Character string.
#'   Prints optional message and output directory.
#' @inheritParams pkg_description_yml
#' @examples
#' \dontrun{
#' pkg_description(
#'   pkg_dir = getwd(),
#'   input_file = "DESCRIPTION.yml"
#' )
#' }
#' @export
pkg_description <- function(pkg_dir = getwd(),
                            input_file = NULL,
                            add = NULL,
                            msg = "DESCRIPTION file path:") {
  if (is.null(input_file)) {
    input_file <- system.file(
      "extdata",
      "DESCRIPTION.yml",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  }
  yml <- pkg_description_yml(
    input_file = input_file
  )
  input <- yml[["single"]]
  Package <- input[["Package"]]
  SystemRequirements <- yml[["SystemRequirements"]]
  Depends <- yml[["Depends"]]
  Imports <- yml[["Imports"]]
  Suggests <- yml[["Suggests"]]
  author <- c(
    "Given",
    "Family",
    "Email",
    "ORCID",
    "Github"
  )
  author <- input[author]
  input <- input[!input %in% author]
  ORCID <- author[["ORCID"]]
  if (is.na(ORCID) | is.null(ORCID)) {
    ORCID <- "\n"
  } else {
    ORCID <- paste0(
      ",",
      "\n",
      "        ",
      "comment = c(ORCID = ",
      "\"",
      ORCID,
      "\"",
      ")",
      "\n"
    )
  }
  AuthorR <- paste0(
    "Authors@R:",
    "\n",
    "    ",
    "person(",
    "\n",
    "        ",
    "given = ",
    "\"",
    author[["Given"]],
    "\"",
    ",",
    "\n",
    "        ",
    "family = ",
    "\"",
    author[["Family"]],
    "\"",
    ",",
    "\n",
    "        ",
    "role = c(\"aut\", \"cre\")",
    ",",
    "\n",
    "        ",
    "email = ",
    "\"",
    author[["Email"]],
    "\"",
    ORCID, # this has already been extracted previously
    "    ",
    ")"
  )
  Github <- author[["Github"]]
  if (!is.null(Github) && !is.na(Github)) {
    URL <- paste(
      "URL:",
      paste0(
        "https://github.com/",
        Github,
        "/",
        Package
      )
    )
    BugReports <- paste(
      "BugReports:",
      paste0(
        "https://github.com/",
        Github,
        "/",
        Package,
        "/issues"
      )
    )
  }
  if (!is.null(SystemRequirements) && !is.na(SystemRequirements)) {
    SystemRequirements <- paste0(
      "\t",
      SystemRequirements,
      collapse = ",\n"
    )
    SystemRequirements <- paste0(
      "SystemRequirements:",
      "\n",
      SystemRequirements
    )
  }
  if (!is.null(Depends) && !is.na(Depends)) {
    Depends <- paste0(
      "\t",
      Depends,
      collapse = ",\n"
    )
    Depends <- paste0(
      "Depends:",
      "\n",
      Depends
    )
  }
  if (!is.null(Imports) && !is.na(Imports)) {
    Imports <- paste0(
      "\t",
      Imports,
      collapse = ",\n"
    )
    Imports <- paste0(
      "Imports:",
      "\n",
      Imports
    )
  }
  if (!is.null(Suggests) && !is.na(Suggests)) {
    Suggests <- paste0(
      "\t",
      Suggests,
      collapse = ",\n"
    )
    Suggests <- paste0(
      "Suggests:",
      "\n",
      Suggests
    )
  }
  input <- paste0(
    names(input),
    ": ",
    input
  )
  input <- strwrap(
    x = input,
    width = 80,
    exdent = 4
  )
  input <- append(
    x = input,
    values = AuthorR,
    after = 3
  )
  if (!is.null(Github) && !is.na(Github)) {
    input <- append(
      x = input,
      values = c(URL, BugReports),
    )
  }
  if (!is.null(SystemRequirements) && !is.na(SystemRequirements)) {
    input <- append(
      x = input,
      values = SystemRequirements
    )
  }
  if (!is.null(Depends) && !is.na(Depends)) {
    input <- append(
      x = input,
      values = Depends
    )
  }
  if (!is.null(Imports) && !is.na(Imports)) {
    input <- append(
      x = input,
      values = Imports
    )
  }
  if (!is.null(Suggests) && !is.na(Suggests)) {
    input <- append(
      x = input,
      values = Suggests
    )
  }
  output <- paste0(
    input,
    collapse = "\n"
  )
  if (!is.null(add)) {
    output <- union(
      output,
      add
    )
  }
  util_txt2file(
    text = output,
    dir = file.path(
      pkg_dir,
      Package
    ),
    fn = "DESCRIPTION",
    msg = msg
  )
}
