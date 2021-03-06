% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/REMICConstructor.R
\docType{class}
\name{RAID-class}
\alias{RAID-class}
\title{An S4 class the REMIC At Issuance Disclosure (RAID) Information}
\description{
The RAID File contains the REMIC at issuance discloure data.  The data is
static data describing the REMIC at the time of issuance
}
\section{Slots}{

\describe{
\item{\code{DealName}}{A character the deal name.}

\item{\code{Issuer}}{A character the deal Issuer.}

\item{\code{DealNumber}}{A character the deal number.}

\item{\code{DealPriceDate}}{A character the pricing date of the transaction.}

\item{\code{DealSettlementDate}}{A character the settlement date.}

\item{\code{Underwriter}}{A character the Underwriter of the deal.}

\item{\code{Trustee}}{A character the Trustee of the deal.}

\item{\code{PricingSpeed}}{A numeric value the PricingSpeed of the deal.}

\item{\code{JumpReferenceSpeed1}}{A numeric value the Jump Bond Reference Speed1.}

\item{\code{JumpReferenceSpeed2}}{A numeric value the Jump Bond Reference Speed2.}

\item{\code{JumpReferenceSpeed3}}{A numeric value the Jump Bond Reference Speed3.}

\item{\code{JumpReferenceSpeed4}}{A numeric value the Jump Bond Reference Speed4.}

\item{\code{JumpReferenceSpeed5}}{A numeric value the Jump Bond Reference Speed5.}

\item{\code{NumberofTranches}}{A numeric value the number of Tranches.}

\item{\code{NumberofComponentTranches}}{A numeric value the number of Component
Tranches in the deal.}

\item{\code{NumberofCombinedTranches}}{A numeric value the number of Combined 
Tranches in the deal.}

\item{\code{NumberofPools}}{A numeric value the number of pools in the deal.}

\item{\code{PacSchedulesIncluded}}{A logical value the indicating if PAC Schedules
are included as part of the REMIC at issuance disclosure.}

\item{\code{NumberofPacSchedules}}{A numeric value number of PAC Schedules reported
at the time of the REMIC issuance.}

\item{\code{NumberofGroups}}{A numeric value the number of collateral groups in the
REMIC transaction.}

\item{\code{DealSize}}{A numeric value the at issuance original balance of the 
REMIC.}

\item{\code{CollateralAmount}}{A numeric value the current balance of the
collateral at REMIC issuance.}

\item{\code{CollateralAvgLife}}{A numeric value the at issuance average life of the 
collateral.}

\item{\code{BondValue}}{A numeric value the bond value.}

\item{\code{BondValueMethod}}{A numeric value the bond value method.}

\item{\code{BondValueCap}}{A numeric value the bond value cap.}

\item{\code{BondValueDiscountRate}}{A numeric value the bond value discount rate}

\item{\code{BondValueReinvestmentRate}}{A numeric value the bond value reinvestment
rate}

\item{\code{ExpenseBasisPointFee}}{A numeric value the deal expense fee 
in basis points.}

\item{\code{ExpenseFixed}}{A numeric value the fixed expenses charged to the deal.}

\item{\code{ExpensePeriodicity}}{A numeric value the frequency at which expenses
are charged to the deal.}

\item{\code{InitialReserveFund}}{= A numeric value the initial reserve fund.}
}}

