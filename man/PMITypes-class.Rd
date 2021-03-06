% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PMITypes.R
\docType{class}
\name{PMITypes-class}
\alias{PMITypes-class}
\title{An S4 class representing PMI (primary mortgage insurance) PMITypes}
\description{
This class is used to calculate and pass PMITypes reported to the investor
and used in cashflow analytics.  For example, PMI is reported to the investor
as a numeric decimal or decimal string but basis is used to determime the PMI
amount paid to the insurer by the homeowner.
}
\section{Slots}{

\describe{
\item{\code{PMIDecimal}}{a numeric value the PMI fee expressed as decimal numeric}

\item{\code{PMIBasis}}{a numeric value the PMI free expresed as basis in decimal 
numeric form}

\item{\code{PMIDecimalString}}{a character string the PMI expressed in decimal 
form.}
}}

