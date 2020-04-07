#' Create a Boilerplate Package `.gitattributes` File with Git LFS Settings.
#'
#' @param ext Character vector.
#'   File extensions.
#' @inheritParams pkg_description
#' @examples
#' \dontrun{
#' pkg_gitlfs(
#'   pkg_root = getwd(),
#'   ext = c("pdf", "jpg")
#' )
#' }
#' @export
pkg_gitlsf <- function(pkg_dir = getwd(),
                       pkg_name,
                       ext = c(
                         "gz",
                         "zip",
                         "Rds",
                         "rds",
                         "Rda",
                         "rda",
                         "jpg",
                         "jpeg",
                         "png",
                         "pdf"
                       )) {
  pkg_root <- file.path(
    pkg_dir,
    pkg_name
  )
  gitlfs <- sort(
    paste0(
      "*.",
      ext,
      " filter=lfs diff=lfs merge=lfs -text"
    )
  )
  file <- file.path(
    pkg_root,
    ".gitattributes"
  )
  if (file.exists(file)) {
    output <- paste0(
      readLines(
        con = file
      ),
      collapse = "\n"
    )
  } else {
    output <- paste0(
      output,
      "\n",
      gitlfs
    )
  }
  util_txt2file(
    text = output,
    dir = pkg_root,
    fn = ".gitattributes"
  )
}
