% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{getFootprints}
\alias{getFootprints}
\title{Calculate footprinting matrix}
\usage{
getFootprints(
  fragments,
  motif_positions,
  cell_groups,
  cell_normalization_factors = rep_along(cell_groups, 1),
  flank = 125
)
}
\arguments{
\item{fragments}{IterableFragments object}

\item{motif_positions}{GRanges object with motif positions. Footprinting will
be centered around the middle of these ranges}

\item{cell_groups}{Character or factor assigning a group to each cell, in order of
\code{cellNames(fragments)}}

\item{cell_normalization_factors}{Numeric vector assigning normalization factors
(e.g. total reads) to each cell, in order of \code{cellNames(fragments)}}

\item{flank}{Number of flanking basepairs to include on either side of the motif}
}
\value{
Matrix of dimensions cell_groups x basepairs (2*flank + 1). Each entry
in the matrix contains the average normalized insertions for a given cell_group
at a given position
}
\description{
Calculate footprinting matrix
}
