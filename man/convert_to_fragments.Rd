% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fragments.R
\name{convert_to_fragments}
\alias{convert_to_fragments}
\title{Build a Fragments object from an R data frame or GRanges object}
\usage{
convert_to_fragments(x, zero_based_coords = !is(x, "GRanges"))
}
\arguments{
\item{x}{An input GRanges, list or data frame. Lists and dataframes
must have chr, start, end, cell_id. GRanges must have a metadata column
for cell_id}

\item{zero_based_coords}{Whether to convert the ranges from a 1-based end-inclusive
coordinate system to a 0-based end-exclusive coordinate system. Defaults to true
for GRanges and false for other formats
(see http://genome.ucsc.edu/blog/the-ucsc-genome-browser-coordinate-counting-systems/)}
}
\value{
UnpackedMemFragments object representing the given fragments
}
\description{
Build a Fragments object from an R data frame or GRanges object
}
