setwd('c:\\users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\r_programming\\week_four\\')
outcome <- read.csv("data\\outcome-of-care-measures.csv", colClasses = "character")

numeric <- c('Lower.Mortality.Estimate',
             'Upper.Mortality.Estimate',
             'Number.of.Patients',
             'Hospital.30.Day.Death..Mortality..Rates.From.Heart.Attack')

function clean_outcomes(outcomes) {
  outcomes <-   
}