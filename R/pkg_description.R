#' Create Package DESCRIPTION.
#'
#' Creates package \code{DESCRIPTION}
#' by extracting information
#' from an external \code{csv} \code{input_file}.
#' See \code{system.file("extdata", "DESCRIPTION.csv", package = "jeksterslabRpkg", mustWork = TRUE)}
#' For the \code{input_file} template.
#' THIS FUNCTION OVERWRITES AN EXISTING \code{DESCRIPTION} FILE
#' IN THE SPECIFIED PACKAGE ROOT DIRECTORY.
#' USE WITH CAUTION.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param pkg_dir Directory where the package is initialized.
#' @param pkg_name Character string.
#'   Package name.
#' @param input_file csv file containing \code{DESCRIPTION} fields and entries.
#' @param add Character string.
#'   Additional entries to the \code{DESCRIPTION} file
#'   not included in \code{input_file}
#' @importFrom utils read.csv
#' @importFrom jeksterslabRutils util_txt2file
#' @examples
#' pkg_description(pkg_dir = tempdir(), pkg_name = "boilerplatePackage")
#' @export
pkg_description <- function(pkg_dir = getwd(),
                            pkg_name,
                            input_file = NULL,
                            add = NULL) {
  if (is.null(input_file)) {
    input_file <- system.file(
      "extdata",
      "DESCRIPTION.csv",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  }
  input <- t(
    read.csv(
      file = input_file,
      stringsAsFactors = FALSE,
      row.names = "field"
    )
  )
  input_names <- colnames(input)
  input <- as.vector(input[-1, ])
  names(input) <- input_names
  if (
    !all(
      c(
        "Title",
        "Version",
        "Given",
        "Family",
        "Email",
        "Github",
        "License",
        "Encoding",
        "LazyData"
      )
      %in%
        names(input)
    )
  ) {
    stop(
      "input_csv does not have the necessary fields.\n"
    )
  }
  root <- file.path(
    pkg_dir,
    pkg_name
  )
  Package <- paste(
    "Package:",
    pkg_name
  )
  Title <- paste(
    "Title:",
    input[["Title"]]
  )
  Version <- paste(
    "Version:",
    input[["Version"]]
  )
  Github <- input[["Github"]]
  URL <- paste(
    "URL:",
    paste0(
      "https://github.com/",
      Github,
      "/",
      pkg_name
    )
  )
  BugReports <- paste(
    "BugReports:",
    paste0(
      "https://github.com/",
      Github,
      "/",
      pkg_name,
      "/issues"
    )
  )
  if (is.na(input[["ORCID"]])) {
    ORCID <- "\n"
  } else {
    ORCID <- paste0(
      ",",
      "\n",
      "        ",
      "comment = c(ORCID = ",
      "\"",
      input[["ORCID"]],
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
    input[["Given"]],
    "\"",
    ",",
    "\n",
    "        ",
    "family = ",
    "\"",
    input[["Family"]],
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
    input[["Email"]],
    "\"",
    ORCID,
    "    ",
    ")"
  )
  author <- paste(
    input[["Given"]],
    input[["Family"]]
  )
  input_description <- strwrap(
    x = input["Description"],
    width = 65,
    exdent = 4
  )
  Description <- vector(
    length = length(input_description)
  )
  for (i in seq_along(input_description)) {
    if (i == 1) {
      Description[i] <- paste(
        "Description:",
        input_description[i]
      )
    } else {
      Description[i] <- input_description[i]
    }
  }
  Description <- paste0(
    Description,
    collapse = "\n"
  )
  License <- paste(
    "License:",
    input[["License"]]
  )
  Encoding <- paste(
    "Encoding:",
    input[["Encoding"]]
  )
  LazyData <- paste(
    "LazyData:",
    tolower(input[["LazyData"]])
  )
  output <- paste(
    Package,
    Title,
    Version,
    AuthorR,
    Description,
    License,
    URL,
    BugReports,
    Encoding,
    LazyData,
    sep = "\n"
  )
  if ("Language" %in% names(input)) {
    Language <- paste(
      "Language:",
      input[["Language"]]
    )
    output <- paste(
      output,
      Language,
      sep = "\n"
    )
  }
  if ("Depends" %in% names(input)) {
    Depends <- paste(
      "Depends:",
      input[["Depends"]]
    )
    output <- paste(
      output,
      Depends,
      sep = "\n"
    )
  }
  if ("Imports" %in% names(input)) {
    Imports <- paste(
      "Imports:",
      input[["Imports"]]
    )
    output <- paste(
      output,
      Imports,
      sep = "\n"
    )
  }
  if ("Suggests" %in% names(input)) {
    Suggests <- paste(
      "Suggests:",
      input[["Suggests"]]
    )
    output <- paste(
      output,
      Suggests,
      sep = "\n"
    )
  }
  if ("VignetteBuilder" %in% names(input)) {
    VignetteBuilder <- paste(
      "VignetteBuilder:",
      input[["VignetteBuilder"]]
    )
    output <- paste(
      output,
      VignetteBuilder,
      sep = "\n"
    )
  }
  if (!is.null(add)) {
    output <- paste0(
      output,
      "\n",
      add
    )
  }
  util_txt2file(
    text = output,
    dir = root,
    fn = "DESCRIPTION"
  )
}
