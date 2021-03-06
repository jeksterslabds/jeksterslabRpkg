% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pkg_checkroot.R
\name{pkg_checkroot_subdir}
\alias{pkg_checkroot_subdir}
\title{Check pkg_root/subdir}
\usage{
pkg_checkroot_subdir(
  dir = getwd(),
  subdir = c("R", "data", "data_raw", "man", "tests", file.path("tests", "testthat"),
    "vignettes")
)
}
\arguments{
\item{dir}{Character string.
Directory.}

\item{subdir}{Character string.
Sub directory.}
}
\description{
Check pkg_root/subdir
}
\examples{
\dontrun{
pkg_checkroot_subdir(
  dir = getwd()
)
}
}
\author{
Ivan Jacob Agaloos Pesigan
}
