pkg_gitlsf <- function(ext = c(
                         "gz",
                         "zip",
                         "Rds",
                         "rds",
                         "Rda",
                         "rda"
                       )) {
  if (is.null(pkg_root)) {
    pkg_root <- getwd()
  }
  if (!file.exists(
    file.path(
      pkg_root,
      "DESCRIPTION"
    )
  )
  ) {
    stop("Not a valid package root directory.\n")
  }
  output <- sort(
    paste0(
      "*.",
      ext,
      " filter=lfs diff=lfs merge=lfs -text"
    )
  )
  # add script to check if .gitattributes exists first and append line by line
  util_txt2file(
    text = output,
    dir = pkg_root,
    fn = ".gitattributes"
  )
}
