
  # Bond Lab is a software application for the analysis of 
  # fixed income securities it provides a suite of applications for the analysis
  # mortgage backed, asset backed securities, and commerical mortgage backed 
  # securities Copyright (C) 2016  Bond Lab Technologies, Inc.
  # 
  # This program is free software: you can redistribute it and/or modify
  # it under the terms of the GNU General Public License as published by
  # the Free Software Foundation, either version 3 of the License, or
  # (at your option) any later version.
  # 
  # This program is distributed in the hope that it will be useful,
  # but WITHOUT ANY WARRANTY; without even the implied warranty of
  # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  # GNU General Public License for more details.
  #
  # You should have received a copy of the GNU General Public License
  # along with this program.  If not, see <http://www.gnu.org/licenses/>.

  #' @include TermStructure.R MortgageKeyRate.R
  NULL

  #' An S4 class representing the bond term structure exposure
  #' 
  #' @slot SpotSpread a numeric value the spread to the spot curve
  #' @slot EffDuration a numeric value the effective duration
  #' @slot EffConvexity a numeric value the effective convexity
  #' @slot KeyRateTenor a vector of values the key rate tenors
  #' @slot KeyRateDuration a vector of values the key rate durations
  #' @slot KeyRateConvexity a vector of values the key rate convexities
  #' @exportClass BondTermStructure
  setClass("BondTermStructure",
         representation(
           SpotSpread = "numeric",   
           EffDuration = "numeric",
           EffConvexity = "numeric",
           KeyRateTenor = "numeric",
           KeyRateDuration = "numeric",
           KeyRateConvexity = "numeric"))

  setGeneric("BondTermStructure",function(bond.id = "character", 
                                 Rate.Delta = numeric(), 
                                 TermStructure = "character", 
                                 principal = numeric(), 
                                 price = numeric(), 
                                 cashflow = "character")
    {standardGeneric("BondTermStructure")})
  
  # Note: standard generic SpotSpread is defined in MortgageKeyRate
  # Note: standard generic EffDuration is defined in MortgageKeyRate
  # Note: standard generic EffConvexity is defined in MortgageKeyRate
  # Note: standard generic KeyRateTenor is defined in MortgageKeyRate
  # Note: standard generic KeyRateDuration is defined in MortgageKeyRate
  # Note: standard generic KeyRateConvexity is defined in MortgageKeyRate
  
  setMethod("initialize",
            signature("BondTermStructure"),
            function(.Object,
                     SpotSpread = "numeric",   
                     EffDuration = "numeric",
                     EffConvexity = "numeric",
                     KeyRateTenor = "numeric",
                     KeyRateDuration = "numeric",
                     KeyRateConvexity = "numeric",
                     ...){
              callNextMethod(.Object,
                             SpotSpread = SpotSpread,
                             EffDuration = EffDuration,
                             EffConvexity = EffConvexity,
                             KeyRateTenor = KeyRateTenor,
                             KeyRateDuration = KeyRateDuration,
                             KeyRateConvexity = KeyRateConvexity,
                             ...)
            })
  
  #' A method to get SpotSpread from the class BondTermStructure
  #' 
  #' @param object an object of the type BondTermStructure
  #' @exportMethod SpotSpread
  setMethod("SpotSpread", signature("BondTermStructure"),
            function(object){object@SpotSpread})
  
  #' A method to get EffDuration from the class BondTermStructure
  #' 
  #' @param object an object of the type BondTermStructure
  #' @exportMethod EffDuration
  setMethod("EffDuration", signature("BondTermStructure"),
            function(object){object@EffDuration})
  
  #' A method to get EffConvexity from the class BondTermStructure
  #' 
  #' @param object an object of the type BondTermStructure
  #' @exportMethod EffConvexity
  setMethod("EffConvexity", signature("BondTermStructure"),
            function(object){object@EffConvexity})
  
  #' A method to get KeyRateTenor from the class BondTermStructure
  #' 
  #' @param object an object of the type BondTermStructure
  #' @exportMethod KeyRateTenor
  setMethod("KeyRateTenor", signature("BondTermStructure"),
            function(object){object@KeyRateTenor})
  
  #' A method to get KeyRateDuration from the class BondTermStructure
  #' 
  #' @param object an object of the type BondTermStructure
  #' @exportMethod KeyRateDuration
  setMethod("KeyRateDuration", signature("BondTermStructure"),
            function(object){object@KeyRateDuration})
  
  #' A method to get KeyRateConvexity from the class BondTermStructure
  #' 
  #' @param object an object of the type BondTermStructure
  #' @exportMethod KeyRateConvexity
  setMethod("KeyRateConvexity", signature("BondTermStructure"),
            function(object){object@KeyRateConvexity})
  
  #' A function to calculate a bond key rate duration
  #' 
  #' This is a generic function used to contruct the object BondTermStructure
  #' @param bond.id A character string referencing an object of 
  #' type bond details.
  #' @param Rate.Delta A numeric value the rate delta used to calcualte the 
  #' bond KRDs.
  #' @param TermStructure A character string referencing an object of typre
  #' TermStructure.
  #' @param principal A numeric value the principal or face amount of the bond.
  #' @param price A character the price of the bond
  #' @param cashflow A character string referencing an object of the 
  #' BondCashFlow.
  #' @importFrom stats approx
  #' @export BondTermStructure
  BondTermStructure <- function(bond.id = "character", 
                                Rate.Delta = numeric(), 
                                TermStructure = "character", 
                                principal = numeric(), 
                                price = "character", 
                                cashflow = "character"){
  
  #Call the bond frequency to adjust the spot spread to the 
  #payment frequency of the bond
  frequency = Frequency(bond.id)
  maturity = Maturity(bond.id)
  accrued = Accrued(cashflow)
  
  Price <- PriceTypes(price)

  proceeds = (principal * PriceBasis(Price)) + accrued 
  
  #========== Set the functions that will be used ==========
  # These functions are set as internal functions to key rates
  # this insures that stored values will not be wrongly be passed to the funtion
  # internal functions used to compute key rate duration and convexity
  EffectiveMeasures <- function(rate.delta, 
                                cashflow, 
                                discount.rates, 
                                discount.rates.up, 
                                discount.rates.dwn, 
                                t.period, proceeds, type){
    Price.NC = sum((1/((1+discount.rates)^t.period)) * cashflow)
    Price.UP = sum((1/((1+discount.rates.up)^t.period)) * cashflow)
    Price.DWN = sum((1/((1+discount.rates.dwn)^t.period)) * cashflow)
    
    switch(
      type, 
      duration = (Price.UP - Price.DWN)/(2*proceeds*rate.delta),
      convexity = (Price.UP + Price.DWN - (2*proceeds))/(2 * proceeds * rate.delta^2)
    )
  }
  
  #The spot spread function is used to solve for the spread to the spot curve 
  #to normalize discounting
  Spot.Spread <- function(spread = numeric(), 
                          cashflow = vector(), 
                          discount.rates = vector(), 
                          t.period = vector(), 
                          proceeds = numeric()){
    Present.Value <- sum((1/(1+(discount.rates + spread))^t.period) * cashflow)
    return(proceeds - Present.Value)
  }
  
  # set up the index names for each array that will be used in 
  # the function Index names set names for columns in the KRIndex. This table 
  # set the control strucutre for the loop that will compute key rate duration 
  # given rates in the key rate table
  Index.Names <- c("Period", 
                   "Time", 
                   "Spot Curve", 
                   "Disc Curve", 
                   "KRDwn", 
                   "KRUp")
  
  # KR.Duration.Col set the column names for the table that hold the key rate 
  # results this table will output to class bond analytics slot KRTenor and 
  # KRDuration
  KR.Duration.Col <- c("Key Rate", 
                       "Key Rate Duration", 
                       "Key Rate Convexity")
  
  #sets the tenor of the key rate that will report a duration
  KR.Duration.Row <- c("0.25", 
                       "1", 
                       "2", 
                       "3", 
                       "5", 
                       "7", 
                       "10", 
                       "15", 
                       "20", 
                       "25", 
                       "30")
  
  # set the arrays for key rate duration calculation
  # key rate table holds data for the term structure and shifts in the key rates
  # DIM TO LENGTH OF CASH FLOW ARRAY AND SET LAST KR TO LENGTH LINE 604
  Key.Rate.Table <- array(data = NA, c(360,6), 
                          dimnames = list(seq(c(1:360)), Index.Names))
  
  #key rate duration array holds the key rates and the key rate duration
  KR.Duration <- array(data = NA, c(11,3), 
                       dimnames = list(seq(c(1:11)), KR.Duration.Col))
  
  KR.Duration[,1] <- as.numeric(KR.Duration.Row)
  
  # Create Index for Key Rate Table for interpolation of Key Rate Duration set 
  # outer knot points the outer points are the first and last elements in KR 
  # string this needs some logic to change the right knot point if the maturity 
  # or last payment of thebond is greater than 30-years should be adaptive
  KR <- c("0.083", 
          "0.25", 
          "1", 
          "2", 
          "3", 
          "5", 
          "7", 
          "10", 
          "15", 
          "20", 
          "25", 
          "30", 
          "30")   # Key Rates
  
  KRCount = length(KR)
  
  KRIndex <- array(data = NA, c(KRCount, 6), 
                   dimnames = list(seq(c(1:KRCount)), Index.Names))
  
  # Initialize the cash flow array for discounting and key rate caclulations
  # this will be populated from class BondCashFlows
  # DIM CASHFLOW ARRAY TO SIZE OF CASHFLOW
  CashFlowArray <- array(data = NA, c(360,2), 
                         dimnames = list(seq(1:360), c("period", "cashflow")))
  
  #Initialze the spot rate array for key rate duration calculations
  SpotRate <- as.matrix(SpotRate(TermStructure))
  
  # Populate Period, Time(t) and Spot Rate Curve of Key Rate Table using NS 
  # coefficients from Term Stucture and then populate and align the cashflow 
  # array for discounting and key rate computations
  #   SET LOOP TO LENGTH OF CASHFLOW ARRAY 
  for(x in 1:360){
    
  # Period (n) in which the cashflow is received
    Key.Rate.Table[x,1] = x
    
  # Time (t) at which the cashflow is received
    #Time period in which the cashflow was received for discounting
    Key.Rate.Table [x,2] = x/months.in.year
    
  # spot rates for discounting
    Key.Rate.Table[x,3] = SpotRate[x,1]/yield.basis  
    
  # Align Cash Flows and populated the CashFlowArray
  # Step One: Make sure all cash flows are set to zero
    CashFlowArray[x,1] = Key.Rate.Table[x,2]
    CashFlowArray[x,2] = 0
  }
  
  # Step Two: Initialize loop and set the cashflows in the array
  # This loops through the time period and set the cashflows into the property 
  # array location for discounts by indexing the cashflows to the array.  
  # The indexing is conditional on the integer of the first period less than or 
  # equal to 1
  
  if(as.integer(TimePeriod(cashflow)[1] * months.in.year) != 1) 
      CashFlowArray[as.integer(TimePeriod(cashflow) * months.in.year) + 1,2] = 
        TotalCashFlow(cashflow)
  
  if(as.integer(TimePeriod(cashflow)[1] * months.in.year) == 1) 
      CashFlowArray[as.integer(TimePeriod(cashflow) * months.in.year),2] = 
        TotalCashFlow(cashflow)
  
  #solve for spread to spot curve to equal price
  spot.spread <- uniroot(Spot.Spread, 
                         interval = c(-.75, .75), 
                         tol = .0000000001, 
                         CashFlowArray[,2],
                         discount.rates = Key.Rate.Table[,3], 
                         t.period = Key.Rate.Table[,2] , 
                         proceeds)$root

  #Step three add the spot spread to the spot curve to get the discount rates 
  #that are need for the key rate duration calculation
  #at a minimum the cash flow array should be 360 months
  
  for(i in 1:360){
    Key.Rate.Table[i,4] = Key.Rate.Table[i,3] + spot.spread 
  }
  
  # Populate KRIndex Table 
  # The key rate index table will serve as the control table for the looping
  # using this table allows for incremental looping of discontinous segments 
  # of the spot rate curve and is proprietary to bondlab
  # Step 1 populate Period (n)
  KRIndex[1:KRCount,1] <- round(as.numeric(KR) * months.in.year,0)
  
  # Step 2 populate time period (t)
  KRIndex[1:KRCount,2] <- as.numeric(KR) 
  
  # Step 3 Populate Index Table with the relevant points on the spot curve
  # this is done by looping through the key rate table and allows for term 
  # structure implementation other than Nelson Siegel 
  # (note: this capability needs to built into bondlab) the key rate index 
  # table (KRIndex) is used to populate the key rate table (KRTable)
  
  for (j in 1:KRCount){                                   
    for (i in 1:360){
      if (Key.Rate.Table[i,1] == round(KRIndex[j,2] * months.in.year,0)) {
        KRIndex[j,3] = Key.Rate.Table[i,3]} else {KRIndex[j,3] = KRIndex[j,3]}
    }
  }
  
  # Step 4 Populate KRIndex Table with the appropriate Discount Curve values 
  # from the key rate table these will be the reference points for the 
  # appropriate key rate shifts
  
  for (j in 1:KRCount){                                   
    for (i in 1:360){
      if (Key.Rate.Table[i,1] == round(KRIndex[j,2] * months.in.year,0)) {
        KRIndex[j,4] = Key.Rate.Table[i,4]} else {KRIndex[j,3] = KRIndex[j,3]}
    }
  }
  
  # Step 5 Populated KRIndex Table with KR Shifts
  for (j in 1:KRCount){
    KRIndex[j,5] = KRIndex[j,4] - (Rate.Delta/yield.basis)
    KRIndex[j,6] = KRIndex[j,4] + (Rate.Delta/yield.basis)
  }
  
  #===== Implement Shift of Spot Rates =======================
  # Once the KRIndex is populated implement the shift in the spot rates using 
  # the KRIndex table as the control w is the counter of the internal knot 
  # points used to compute key rate duration it ignores the boundary knots
  # used for interpolation at the end points.  x is the length of the array.  
  # Currently the analysis is limited to loans (bonds) with a maximum of 
  # 30-years to maturity.  This can be made dynamic at some point in the future
  # y is column counter used the key rate down and key rate up values
  
  for (w in 2:(KRCount-1)){ 
    for (x in 1:360){
      for(y in 5:6){
        
  # step 1: populate the spot curve outside the key rate shift =========
        if(Key.Rate.Table[x,2] <= KRIndex[w-1,2] || Key.Rate.Table[x,2] >= KRIndex[w+1,2]) 
        {Key.Rate.Table[x,y] = Key.Rate.Table[x,4]} else {Key.Rate.Table[x,y] = 0}
      }
    }
    
    #===== Begin Interpolation of Spot Curve ==================================
    # Maturity points on the spot rate curve to interpolate
    KRx <- c(KRIndex[w-1,2], KRIndex[w,2], KRIndex[w+1,2]) 
    
    # Spot rates that correspond to the maturity points Down and Up
    for(z in 1:2){                                       
      if (z == 1) 
      {KRy <- c(KRIndex[w-1,4], KRIndex[w,5], KRIndex[w+1,4])}         
      else 
      {KRy <- c(KRIndex[w-1,4], KRIndex[w,6], KRIndex[w+1,4])}                                     
      a = KRIndex[w-1,1]+ 1
      b = KRIndex[w+1,1] - 1
      for(h in a : b){
        Key.Rate.Table[h,(z+4)] <- approx(KRx,KRy, Key.Rate.Table[h,2])$y
      } # Loop through Key Rate Table and interpolation
    } # Inner Loop to set interpolation points from KRIndex
    
    # This line sets the end points for disocunting when the 30-year is last 
    if (KRIndex[w,2] == 30) {
      (Key.Rate.Table[x,5] = KRIndex[12,5]) & 
        (Key.Rate.Table[x,6] = KRIndex[12,6])}   
    
    # Calculate Key Rate Duration 
    KR.Duration[w-1,2] <- -EffectiveMeasures(
      rate.delta = Rate.Delta/yield.basis, 
      cashflow = CashFlowArray[,2], 
      discount.rates = Key.Rate.Table[,4], 
      discount.rates.up = Key.Rate.Table[,6],
      discount.rates.dwn = Key.Rate.Table[,5],
      t.period = Key.Rate.Table[,2],
      type = "duration",
      proceeds = proceeds
    ) 
    KR.Duration[w-1,3] <- EffectiveMeasures(
      rate.delta = Rate.Delta/yield.basis, 
      cashflow = CashFlowArray[,2], 
      discount.rates = Key.Rate.Table[,4], 
      discount.rates.up = Key.Rate.Table[,6],
      discount.rates.dwn = Key.Rate.Table[,5],
      t.period = Key.Rate.Table[,2],
      type = "convexity",
      proceeds = proceeds
    ) 
  } # Outer Loop around KRIndex
  new("BondTermStructure",
      SpotSpread = spot.spread * yield.basis,
      EffDuration = sum(KR.Duration[,2]),
      EffConvexity = sum(KR.Duration[,3]),
      KeyRateTenor = KR.Duration[,1],
      KeyRateDuration = KR.Duration[,2],
      KeyRateConvexity = KR.Duration[,3]
      
  )
} # End the function
