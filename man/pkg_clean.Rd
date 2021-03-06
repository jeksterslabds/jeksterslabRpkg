% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pkg_clean.R
\name{pkg_clean}
\alias{pkg_clean}
\title{Clean Package}
\usage{
pkg_clean(pkg_root = getwd())
}
\arguments{
\item{pkg_root}{Character string.
Package root directory.}
}
\description{
Cleans the following:
\itemize{
\item \verb{docs/*}
\item \verb{man/*}
\item \verb{vignettes/*.html}
\item \verb{vignettes/*.md}
\item \verb{vignettes/articles/*.html}
\item \verb{vignettes/articles/*.md}
\item \verb{vignettes/articles/*_files}
\item \verb{vignettes/notes/*_cache}
\item \verb{vignettes/notes/*.html}
\item \verb{vignettes/notes/*.md}
\item \verb{vignettes/notes/*_files}
\item \verb{vignettes/notes/*_cache}
\item \verb{vignettes/tests/*}
}
}
\author{
Ivan Jacob Agaloos Pesigan
}
