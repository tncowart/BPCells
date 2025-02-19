% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/atacQC.R
\name{qc_scATAC}
\alias{qc_scATAC}
\title{Calculate ArchR-compatible per-cell QC statistics}
\usage{
qc_scATAC(fragments, genes, blacklist, zero_based_coords = TRUE)
}
\arguments{
\item{fragments}{IterableFragments object}

\item{genes}{GenomicRanges object with genes coordinates (e.g. ArchR::geneAnnoHg38$TSS)}

\item{blacklist}{GenomicRanges object with blacklist regions (e.g. ArchR::genomeAnnoHg38$blacklist)}

\item{zero_based_coords}{Boolean for whether the input ranges are in a 0-based
or a 1-based coordinate system. (1-based will be converted to 0-based)
(see http://genome.ucsc.edu/blog/the-ucsc-genome-browser-coordinate-counting-systems/)}
}
\value{
data.frame with QC data
}
\description{
Calculate ArchR-compatible per-cell QC statistics
}
\details{
This implementation mimics ArchR's default parameters. For uses requiring more flexibility to tweak default parameters,
the best option is to re-implement this function with required changes.
Output columns of data.frame:
\itemize{
\item cellName: cell name for each cell
\item nFrags: number of fragments per cell
\item subNucleosomal, monoNucleosomal, multiNucleosomal: number of fragments of size 1-146bp, 147-254bp, and 255bp + respectively.
equivalent to ArchR's nMonoFrags, nDiFrags, nMultiFrags respectively
\item TSSEnrichment: AvgInsertInTSS / max(AvgInsertFlankingTSS, 0.1), where AvgInsertInTSS ReadsInTSS / 101 (window size),
and AvgInsertFlankingTSS is ReadsFlankingTSS / (100*2) (window size). The max(0.1) ensures that very low-read cells
do not get assigned spuriously high TSSEnrichment.
\item ReadsInPromoter: Number of reads from 2000bp upstream of TSS to 101bp downstream of TSS
\item ReadsInBlacklist: Number of reads in the provided blacklist region
\item ReadsInTSS: Number of reads overlapping the 101bp centered around each TSS
\item ReadsFlankingTSS: Number of reads overlapping 1901-2000bp +/- each TSS
}

Differences from ArchR:
Note that ArchR by default uses a different set of annotations to derive TSS sites and promoter sites.
This function uses just one annotation for gene start+end sites, so must be called twice to exactly
re-calculate the ArchR QC stats.

ArchR's PromoterRatio and BlacklistRatio are not included in the output, as they can be easily calculated
from ReadsInPromoter / nFrags and  ReadsInBlacklist / nFrags. Similarly, ArchR's NucleosomeRatio can be calculated
as (monoNucleosomal + multiNucleosomal) / subNucleosomal.
}
