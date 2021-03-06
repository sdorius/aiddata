% Generated by roxygen2 (4.0.2): do not edit by hand
\name{get_gis}
\alias{get_gis}
\title{Download GIS Information for AidData Projects}
\usage{
get_gis(rec = NULL, donor = NULL, start = NULL, end = NULL,
  proj.info = FALSE)
}
\arguments{
\item{rec}{Character vector of recipient countries (ISO-2 country codes, e.g.
"AO" for Angola). Donor organizations not yet implemented.}

\item{donor}{Character vector of donor countries (ISO-2 country codes, e.g.
"US"). Donor organizations not yet implemented.}

\item{start}{First year of data.}

\item{end}{Last year of data.}

\item{proj.info}{Logical. Defaults to \code{FALSE}. Should complete project
  information be downloaded?}
}
\value{
Data frame in which one row represents one point information of an
  aid project.
}
\description{
Downloads geographic information for aid projects in the AidData 3.0
database, parses resulting JSON files, and returns a data frame with the
point information for the projects.
}
\details{
This function downloads all point information for aid projects in
  country \code{rec} between \code{start} and \code{end} years. Since many
  projects are implemented in different locations, the number of point
  locations typically exceeds the number of projects.

  The API GIS returns a set of basic information:

  \itemize{ \item{\code{project_id: }}{Unique AidData project ID}
  \item{\code{score: }}{Not entirely clear (Precision Code?)}
  \item{\code{loc_geo_name: }}{Name of the geo-referenced point, e.g.
  province name, town, village} \item{\code{lat: }}{Latitude}
  \item{\code{long: }}{Longitude} }

  If \code{proj.info = TRUE}, \code{get_gis} calls \code{get_aid} to match
  point information with project information. See \code{\link{get_aid}}
  documentation for list of variables returned by \code{get_aid}. Since this
  procedure downloads a lot of unnecessary information (only a fraction of
  all aid projects are geocoded), this process may take a while.
}
\examples{
\dontrun{
 # Download and store GIS information for aid projects in Angola between
 # 2005 and 2007; get all project information for these projects
 aidprojects_gis <- get_gis(rec = "AO", start = 2005, end = 2007, proj.info = TRUE)
}
}
\references{
Tierney, Michael J., Daniel L. Nielson, Darren G. Hawkins, J. Timmons
Roberts, Michael G. Findley, Ryan M. Powers, Bradley Parks, Sven E. Wilson,
and Robert L. Hicks. 2011. More Dollars than Sense: Refining Our Knowledge of
Development Finance Using AidData. \emph{World Development} 39 (11):
1891-1906.

Strandow, Daniel, Michael Findley, Daniel Nielson, and Joshua Powell. 2011.
\emph{The UCDP-AidData codebook on Geo-referencing Foreign Aid.} Version 1.1.
Uppsala Conflict Data Program. Uppsala, Sweden: Uppsala University.

\url{http://aiddata.org}

\url{http://aiddata.org/user-guide}
}
\seealso{
\code{\link{get_aid}}
}

