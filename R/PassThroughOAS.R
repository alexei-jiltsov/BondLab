# Bond Lab is a software application for the analysis of 
# fixed income securities it provides a suite of applications
# in addition to standard fixed income analysis bond lab provides 
# for the specific analysis of structured products residential mortgage backed securities, 
# asset backed securities, and commerical mortgage backed securities
# License GPL3
# Copyright (C) 2014  Glenn M Schultz, CFA
# Fair use of the Bond Lab trademark is limited to promotion of the use of the software or 
# book "Investing in Mortgage Backed Securities Using Open Source Analytics"

#setGeneric("PassThroughOAS", function(bond.id = "character", trade.date = "character", settlement.date = "character", original.bal = numeric(), 
#                             price = numeric(), short.rate = numeric(), sigma = numeric(), paths = numeric(), PrepaymentAssumption = "character", 
#                             ..., begin.cpr = numeric(), end.cpr = numeric(), seasoning.period = numeric(), CPR = numeric())
#                             {standardGeneric("PassThroughOAS")})

setMethod("initialize",
          signature("PassThroughOAS"),
          function(.Object,
                   Cusip = "character",
                   ID = "character",
                   BondType = "character",
                   Sector ="character",
                   Coupon = "numeric",
                   IssueDate = "character",
                   DatedDate = "character",
                   Maturity = "character",
                   LastPmtDate = "character",
                   NextPmtDate = "character",
                   PaymentDelay = "numeric",
                   Moody = "character",
                   SP = "character",
                   BondLab  = "character",
                   Frequency = "numeric",
                   BondBasis = "character",
                   GWac = "numeric",
                   AmortizationType = "character",
                   AmortizationTerm = "numeric",
                   Index = "character",
                   Margin = "numeric",
                   FirstPmtDate = "character",
                   FinalPmtDate = "character",
                   Servicing = "numeric",
                   PMI = "numeric",
                   Gfee = "numeric",
                   InitialInterest = "character",
                   InterestOnlyPeriod = "numeric",
                   FirstPrinPaymentDate = "character",
                   BalloonPmt = "character",
                   BalloonDate = "character",
                   MBSFactor = "numeric",
                   Model = "character",
                   Burnout = "numeric",
                   SATO = "numeric",
                   Price = "numeric",
                   Accrued = "numeric",
                   YieldToMaturity = "numeric",
                   WAL = "numeric",
                   ModDuration = "numeric",
                   Convexity = "numeric",
                   Period = "numeric",
                   PmtDate = "character",
                   TimePeriod = "numeric",
                   BeginningBal = "numeric",
                   MonthlyPmt = "numeric",
                   MonthlyInterest = "numeric",
                   PassThroughInterest = "numeric",
                   ScheduledPrin = "numeric",
                   PrepaidPrin = "numeric",
                   EndingBal = "numeric",
                   ServicingIncome = "numeric",
                   PMIPremium = "numeric",
                   GFeePremium = "numeric",  
                   TotalCashFlow = "numeric",
                   OAS = "numeric",
                   ZVSpread = "numeric",
                   SpreadToCurve = "numeric",
                   PriceDist = "vector",
                   PathSpread = "vector",
                   PathWAL = "vector",
                   PathModDur = "vector",
                   PathYTM = "vector"){
            
            .Object@Cusip = Cusip
            .Object@ID = ID
            .Object@BondType = BondType
            .Object@Sector = Sector
            .Object@Coupon = Coupon
            .Object@IssueDate = IssueDate
            .Object@DatedDate = DatedDate
            .Object@Maturity = Maturity
            .Object@LastPmtDate = LastPmtDate
            .Object@NextPmtDate = NextPmtDate
            .Object@PaymentDelay = PaymentDelay
            .Object@Moody = Moody
            .Object@SP = SP
            .Object@BondLab  = BondLab
            .Object@Frequency = Frequency
            .Object@BondBasis = BondBasis
            .Object@GWac = GWac
            .Object@AmortizationType = AmortizationType
            .Object@AmortizationTerm = AmortizationTerm
            .Object@Index = Index
            .Object@Margin = Margin
            .Object@FirstPmtDate = FirstPmtDate
            .Object@FinalPmtDate = FinalPmtDate
            .Object@Servicing = Servicing
            .Object@PMI = PMI
            .Object@Gfee = Gfee
            .Object@InitialInterest = InitialInterest
            .Object@InterestOnlyPeriod = InterestOnlyPeriod
            .Object@FirstPrinPaymentDate = FirstPrinPaymentDate
            .Object@BalloonPmt = BalloonPmt
            .Object@BalloonDate = BalloonDate
            .Object@MBSFactor = MBSFactor
            .Object@Model = Model
            .Object@Burnout = Burnout
            .Object@SATO = SATO
            .Object@Price = Price
            .Object@Accrued = Accrued
            .Object@YieldToMaturity = YieldToMaturity
            .Object@WAL = WAL
            .Object@ModDuration = ModDuration
            .Object@Convexity = Convexity
            .Object@Period = Period
            .Object@PmtDate = PmtDate
            .Object@TimePeriod = TimePeriod
            .Object@BeginningBal = BeginningBal
            .Object@MonthlyPmt = MonthlyPmt
            .Object@MonthlyInterest = MonthlyInterest
            .Object@PassThroughInterest = PassThroughInterest
            .Object@ScheduledPrin = ScheduledPrin
            .Object@PrepaidPrin = PrepaidPrin
            .Object@EndingBal = EndingBal
            .Object@ServicingIncome = ServicingIncome
            .Object@PMIPremium = PMIPremium
            .Object@GFeePremium = GFeePremium 
            .Object@TotalCashFlow = TotalCashFlow
            .Object@OAS = OAS
            .Object@ZVSpread = ZVSpread
            .Object@SpreadToCurve = SpreadToCurve
            .Object@PriceDist = PriceDist
            .Object@PathSpread = PathSpread
            .Object@PathWAL = PathWAL
            .Object@PathModDur = PathModDur
            .Object@PathYTM = PathYTM
          
            return(.Object)
            callNextMethod(.Object,...)})

#---------------------------------
#This function is for Pass Through OAS Analysis and serves constructor for OAS Analysis

PassThroughOAS <- function(bond.id = "character", 
                           trade.date = "character", 
                           settlement.date = "character", 
                           original.bal = numeric(), 
                           price = numeric(), 
                           #short.rate = numeric(), 
                           sigma = numeric(), 
                           paths = numeric(), 
                           PrepaymentAssumption = "character", 
                           ..., 
                           begin.cpr = numeric(), 
                           end.cpr = numeric(), 
                           seasoning.period = numeric(), 
                           CPR = numeric()){
  
  #Error Trap Settlement Date and Trade Date order.  
  #This is not done in the Error Trap Function because that function is 
  #to trap errors in bond information that is passed into the functions.  
  #It is trapped here because this is the first use of trade date
  if(trade.date > settlement.date) stop ("Trade Date Must be less than settlement date")
  
  
  #Rate Delta is set to 1 (100 basis points) for effective convexity calculation                          
  Rate.Delta = .25
  
  #The first step is to read in the Bond Detail, rates, and Prepayment Model Tuning Parameters
  conn1 <-  gzfile(description = paste("~/BondLab/BondData/",bond.id, ".rds", sep = ""), open = "rb")
  bond.id <- readRDS(conn1)
  
  #Call the desired curve from rates data folder
  conn2 <- gzfile(description = paste("~/BondLab/RatesData/", as.Date(trade.date, "%m-%d-%Y"), ".rds", sep = ""), open = "rb")
  rates.data <- readRDS(conn2)
  
  #Call Mortgage Rate Functions
  conn3 <- gzfile("~/BondLab/PrepaymentModel/MortgageRate.rds", open = "rb")
  MortgageRate <- readRDS(conn3)  
  
  Burnout = bond.id@Burnout
  
  #Call Prepayment Model Tuning Parameters
  conn4 <- gzfile(description = paste("~/BondLab/PrepaymentModel/", bond.id@Model, ".rds", sep =""), open = "rb")        
  ModelTune <- readRDS(conn4)
  
  short.rate <- as.numeric(rates.data[1,2])/100
  
  #Call OAS Term Strucuture to Pass to the Prepayment Model 
  #- upgrade this function for 40-years to match termstrc for key rate duration function
  TermStructure <- Mortgage.OAS(bond.id = bond.id@ID, 
                                trade.date = trade.date, 
                                settlement.date = settlement.date, 
                                original.bal = original.bal, 
                                price = price, 
                                sigma = sigma, 
                                paths = 1, 
                                TermStructure = "TRUE")
  
  #Third if mortgage security call the prepayment model
  PrepaymentAssumption <- PrepaymentAssumption(bond.id = bond.id, 
                                               MortgageRate = MortgageRate, 
                                               TermStructure = TermStructure, 
                                               PrepaymentAssumption = PrepaymentAssumption, 
                                               ModelTune = ModelTune, 
                                               Burnout = Burnout, 
                                               begin.cpr = begin.cpr, 
                                               end.cpr = end.cpr, 
                                               seasoning.period = seasoning.period, 
                                               CPR = CPR)
  
  #The fourth step is to call the bond cusip details and calculate 
  #Bond Yield to Maturity, Duration, Convexity and CashFlow.
  MortgageCashFlow <- MortgageCashFlow(bond.id = bond.id, 
                                       original.bal = original.bal, 
                                       settlement.date = settlement.date, 
                                       price = price, 
                                       PrepaymentAssumption = PrepaymentAssumption)
  
  #Calculate effective duration, convexity, and key rate durations and key rate convexities
  #This is done with the MtgTermStructureFunction this creates the class BondTermStructure
  #MortgageTermStructure <- MtgTermStructure(bond.id = MortgageCashFlow, original.bal = original.bal, Rate.Delta = Rate.Delta, TermStructure = TermStructure, 
  #settlement.date = settlement.date, principal = original.bal *  MortgageCashFlow@MBSFactor, price = price, cashflow = MortgageCashFlow)
  
  MortgageOAS  <- Mortgage.OAS(bond.id = bond.id@ID, 
                               trade.date = trade.date, 
                               settlement.date = settlement.date, 
                               original.bal = original.bal, 
                               price = price, 
                               sigma = sigma, 
                               paths = paths, 
                               TermStructure = "FALSE")
  
  #Calculate the spread to the curve and pass to OAS                                   
  #InterpolateCurve <- loess(as.numeric(rates.data[1,2:12]) ~ 
  #                            as.numeric(rates.data[2,2:12]), data = data.frame(rates.data))
  
  #MortgageOAS@SpreadToCurve <- ((MortgageCashFlow@YieldToMaturity  * 100) - 
  #                                predict(InterpolateCurve, MortgageCashFlow@WAL ))/100
  
  new("PassThroughOAS",
      Cusip = bond.id@Cusip,
      ID = bond.id@ID,
      BondType = bond.id@BondType,
      Sector = bond.id@Sector,
      Coupon = bond.id@Coupon,
      IssueDate = bond.id@IssueDate,
      DatedDate = bond.id@DatedDate,
      Maturity = bond.id@Maturity,
      LastPmtDate = bond.id@LastPmtDate,
      NextPmtDate = bond.id@NextPmtDate,
      PaymentDelay = bond.id@PaymentDelay,
      Moody = bond.id@Moody,
      SP = bond.id@SP,
      BondLab  = bond.id@BondLab,
      Frequency = bond.id@Frequency,
      BondBasis = bond.id@BondBasis,
      GWac = bond.id@GWac,
      AmortizationType = bond.id@AmortizationType,
      AmortizationTerm = bond.id@AmortizationTerm,
      Index = bond.id@Index,
      Margin = bond.id@Margin,
      FirstPmtDate = bond.id@FirstPmtDate,
      FinalPmtDate = bond.id@FinalPmtDate,
      Servicing = bond.id@Servicing,
      PMI = bond.id@PMI,
      Gfee = bond.id@Gfee,
      InitialInterest = bond.id@InitialInterest,
      InterestOnlyPeriod = bond.id@InterestOnlyPeriod,
      FirstPrinPaymentDate = bond.id@FirstPrinPaymentDate,
      BalloonPmt = bond.id@BalloonPmt,
      BalloonDate = bond.id@BalloonDate,
      MBSFactor = bond.id@MBSFactor,
      Model = bond.id@Model,
      Burnout = bond.id@Burnout,
      SATO = bond.id@SATO,
      Price = MortgageCashFlow@Price,
      Accrued = MortgageCashFlow@Accrued,
      YieldToMaturity = MortgageCashFlow@YieldToMaturity,
      WAL = MortgageCashFlow@WAL,
      ModDuration = MortgageCashFlow@ModDuration,
      Convexity = MortgageCashFlow@Convexity,
      Period = MortgageCashFlow@Period,
      PmtDate = MortgageCashFlow@PmtDate,
      TimePeriod = MortgageCashFlow@TimePeriod,
      BeginningBal = MortgageCashFlow@BeginningBal,
      MonthlyPmt = MortgageCashFlow@MonthlyPmt,
      MonthlyInterest = MortgageCashFlow@MonthlyInterest,
      PassThroughInterest = MortgageCashFlow@PassThroughInterest,
      ScheduledPrin = MortgageCashFlow@ScheduledPrin,
      PrepaidPrin = MortgageCashFlow@PrepaidPrin,
      EndingBal = MortgageCashFlow@EndingBal,
      ServicingIncome = MortgageCashFlow@ServicingIncome,
      PMIPremium = MortgageCashFlow@PMIPremium,
      GFeePremium = MortgageCashFlow@GFeePremium,  
      TotalCashFlow = MortgageCashFlow@TotalCashFlow,
      OAS = MortgageOAS@OAS,
      ZVSpread = MortgageOAS@ZVSpread,
      SpreadToCurve = MortgageOAS@SpreadToCurve,
      PriceDist = MortgageOAS@PriceDist,
      PathSpread = MortgageOAS@PathSpread,
      PathWAL = MortgageOAS@PathWAL,
      PathModDur = MortgageOAS@PathModDur,
      PathYTM = MortgageOAS@PathYTM)
}