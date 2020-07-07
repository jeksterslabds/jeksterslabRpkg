#' Parse Description `YAML`
#'
#' @param input_file Character string.
#' `YAML` file containing `DESCRIPTION` fields and entries.
#' @param fields Character vector.
#' Fields from `DESCRIPTION.yml` to extract.
#' Note that this only works for fields that contain a single value.
#' @param required Logical.
#' Check required fields.
#' @param dependencies Logical.
#' Extract dependencies
#' (`SystemRequirements`, `Depends`, `Imports`, `Suggests`).
#' @examples
#' \dontrun{
#' pkg_description_yml(
#'   input_file = "DESCRIPTION.yml",
#'   fields = c(
#'     "Package",
#'     "Given",
#'     "Family",
#'     "Email",
#'     "ORCID",
#'     "Version",
#'     "Title",
#'     "Description",
#'     "License",
#'     "Github",
#'     "Encoding",
#'     "Language",
#'     "LazyData",
#'     "VignetteBuilder",
#'     "Roxygen"
#'   ),
#'   required = TRUE,
#'   dependencies = TRUE
#' )
#' }
#' @importFrom jeksterslabRutils util_list2vector
#' @importFrom yaml read_yaml
#' @importFrom tools toTitleCase
#' @export
pkg_description_yml <- function(input_file = NULL,
                                fields = c(
                                  "Package",
                                  "Given",
                                  "Family",
                                  "Email",
                                  "ORCID",
                                  "Version",
                                  "Title",
                                  "Description",
                                  "License",
                                  "Github",
                                  "Encoding",
                                  "Language",
                                  "LazyData",
                                  "VignetteBuilder",
                                  "Roxygen"
                                ),
                                required = TRUE,
                                dependencies = TRUE) {
  if (is.null(input_file)) {
    input_file <- system.file(
      "extdata",
      "DESCRIPTION.yml",
      package = "jeksterslabRpkg",
      mustWork = TRUE
    )
  }
  input <- read_yaml(
    file = input_file
  )
  if (required) {
    required <- c(
      "Package",
      "Version",
      "License",
      "Description",
      "Title",
      "Given",
      "Family"
    )
    for (i in seq_along(required)) {
      if (!required[i] %in% fields) {
        stop(
          paste0(
            "The required field ",
            required[i],
            " is NOT PRESENT in the argument fields."
          )
        )
      }
    }
  }
  pkg_valid_name(pkg_name = input[["Package"]])
  output <- util_list2vector(
    fields = fields,
    index = input
  )
  output <- output[!is.na(output)]
  output["Title"] <- toTitleCase(
    text = output["Title"]
  )
  if (dependencies) {
    SystemRequirements <- input[["SystemRequirements"]]
    Depends <- input[["Depends"]]
    Imports <- input[["Imports"]]
    Suggests <- input[["Suggests"]]
  } else {
    SystemRequirements <- NA
    Depends <- NA
    Imports <- NA
    Suggests <- NA
  }
  list(
    single = output,
    SystemRequirements = SystemRequirements,
    Depends = Depends,
    Imports = Imports,
    Suggests = Suggests
  )
}
