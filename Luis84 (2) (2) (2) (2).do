clear all

cd c:/Eco387

capture log close
log using luis84.log, replace

local year "03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21"

local month "jan feb mar apr may jun jul aug sep oct nov dec"
/*
foreach y of local year {
foreach n of local month {
infix 	hrmonth		16-17 ///
		year		18-21 ///
		state     93 - 94	///
		race        139 - 140		///
		sex         129 - 130			///
		edu			137 - 138	///
		smsa        105		///	
		age			122 - 123	///
		marital		125 - 126 ///
		hisp		157 - 158 ///
		pemlr		180 - 181 ///
		finalwgt	613 - 622 ///
using c:/Eco387/CPS_data20`y'/`n'`y'pub.dat
save cpsb`y'`n'.dta, replace
su
clear
}
}
*/
use cpsb03jan.dta, clear

drop if year==2003 & hrmonth==1

foreach y of local year {
foreach n of local month {
append using cpsb`y'`n'.dta
}
}

keep if (age >= 18 & age <= 64) & pemlr<=4 

gen female=(sex==2)

gen less_hi=(edu==38)
gen hi_sch=(edu==39)
gen some_col=(edu>=40 & edu <=42)
gen more_col=(edu >=43)

gen white=(race==1 & hisp==2)					/* Generate the Non-Hispanic whites dummy */
gen black=(race==2 & hisp==2)					/* Generate the Non-Hispanic black dummy */
gen hispanic=(hisp==1)							/* Generate the Hispanic dummy */
gen other=(white==0 & black==0 & hispanic==0)  	/* Generate the other race dummy */

gen agesq=age*age

gen msa=(smsa==1) /* Metropolitan Statistical Area (urban area) dummy */

gen married=(marital==1)

gen weight=finalwgt/10000	

svyset [pweight=weight]		/* Declare survey design for dataset: the sampling weight, pweight, is the variable weight */



gen federal_min = 0 
replace federal_min = 5.15 if year == 2003 
 
gen state_min = 0 

replace state_min = 7.15 if year == 2003 & state== 2
replace state_min = 5.15 if year == 2003 & state== 5
replace state_min = 6.75 if year == 2003 & state== 6

replace state_min = 5.15 if year == 2003 & state== 8 
replace state_min = 6.90 if year == 2003 & state== 9 
replace state_min = 6.15 if year == 2003 & state== 10 
replace state_min = 5.15 if year == 2003 & state== 13

replace state_min = 6.25 if year == 2003 & state== 15 
replace state_min = 5.15 if year == 2003 & state== 16 
replace state_min = 5.15 if year == 2003 & state== 17 
replace state_min = 5.15 if year == 2003 & state== 18

replace state_min = 5.15 if year == 2003 & state== 19 
replace state_min = 2.65 if year == 2003 & state== 20 
replace state_min = 5.15 if year == 2003 & state== 21
replace state_min = 6.25 if year == 2003 & state== 23

replace state_min = 5.15 if year == 2003 & state== 24 
replace state_min = 6.75 if year == 2003 & state== 25 
replace state_min = 5.15 if year == 2003 & state== 26
replace state_min = 5.15 if year == 2003 & state== 27

replace state_min = 5.15 if year == 2003 & state== 29 
replace state_min = 5.15 if year == 2003 & state== 30
replace state_min = 5.15 if year == 2003 & state== 31
replace state_min = 5.15 if year == 2003 & state==32

replace state_min = 5.15 if year == 2003 & state== 33
replace state_min = 5.15 if year == 2003 & state== 34 
replace state_min = 4.25 if year == 2003 & state== 35 
replace state_min = 5.15 if year == 2003 & state== 36
 
replace state_min = 5.15 if year == 2003 & state== 37 
replace state_min = 5.15 if year == 2003 & state== 38 
replace state_min = 4.25 if year == 2003 & state== 39 
replace state_min = 5.15 if year == 2003 & state== 40 

replace state_min = 6.90 if year == 2003 & state== 41
replace state_min = 5.15 if year == 2003 & state== 42
replace state_min = 6.15 if year == 2003 & state== 44 
replace state_min = 5.15 if year == 2003 & state== 46
replace state_min = 5.25 if year == 2003 & state== 48 
replace state_min = 5.15 if year == 2003 & state== 49

replace state_min = 6.25 if year == 2003 & state== 50
replace state_min = 5.15 if year == 2003 & state== 51 
replace state_min = 7.01 if year == 2003 & state== 53 
replace state_min = 5.15 if year == 2003 & state== 54 

replace state_min = 5.15 if year == 2003 & state== 55 
replace state_min = 5.15 if year == 2003 & state== 56 
 
replace federal_min = 5.15 if year == 2004
  
replace state_min = 7.15 if year == 2004 & state== 2
replace state_min = 5.15 if year == 2004 & state== 5
replace state_min = 6.75 if year == 2004 & state== 6

replace state_min = 5.15 if year == 2004 & state== 8 
replace state_min = 7.10 if year == 2004 & state== 9 
replace state_min = 6.15 if year == 2004 & state== 10 
replace state_min = 5.15 if year == 2004 & state== 13

replace state_min = 6.25 if year == 2004 & state== 15 
replace state_min = 5.15 if year == 2004 & state== 16 
replace state_min = 5.50 if year == 2004 & state== 17 
replace state_min = 5.15 if year == 2004 & state== 18

replace state_min = 5.15 if year == 2004 & state== 19 
replace state_min = 2.65 if year == 2004 & state== 20 
replace state_min = 5.15 if year == 2004 & state== 21
replace state_min = 6.25 if year == 2004 & state== 23

replace state_min = 5.15 if year == 2004 & state== 24 
replace state_min = 6.75 if year == 2004 & state== 25 
replace state_min = 5.15 if year == 2004 & state== 26
replace state_min = 5.15 if year == 2004 & state== 27

replace state_min = 5.15 if year == 2004 & state== 29 
replace state_min = 5.15 if year == 2004 & state== 30
replace state_min = 5.15 if year == 2004 & state== 31
replace state_min = 5.15 if year == 2004 & state==32

replace state_min = 5.15 if year == 2004 & state== 33
replace state_min = 5.15 if year == 2004 & state== 34 
replace state_min = 5.15 if year == 2004 & state== 35 
replace state_min = 5.15 if year == 2004 & state== 36
 
replace state_min = 5.15 if year == 2004 & state== 37 
replace state_min = 5.15 if year == 2004 & state== 38 
replace state_min = 4.25 if year == 2004 & state== 39 
replace state_min = 5.15 if year == 2004 & state== 40 

replace state_min = 7.05 if year == 2004 & state== 41
replace state_min = 5.15 if year == 2004 & state== 42
replace state_min = 6.75 if year == 2004 & state== 44 
replace state_min = 5.15 if year == 2004 & state== 46
replace state_min = 5.25 if year == 2004 & state== 48 
replace state_min = 5.15 if year == 2004 & state== 49

replace state_min = 6.75 if year == 2004 & state== 50
replace state_min = 5.15 if year == 2004 & state== 51 
replace state_min = 7.16 if year == 2004 & state== 53 
replace state_min = 5.15 if year == 2004 & state== 54 

replace state_min = 5.15 if year == 2004 & state== 55 
replace state_min = 5.15 if year == 2004 & state== 56 
 
replace federal_min = 5.15 if year == 2005

replace state_min = 7.15 if year == 2005 & state== 2
replace state_min = 5.15 if year == 2005 & state== 5
replace state_min = 6.75 if year == 2005 & state== 6

replace state_min = 5.15 if year == 2005 & state== 8 
replace state_min = 7.10 if year == 2005 & state== 9 
replace state_min = 6.15 if year == 2005 & state== 10 
replace state_min = 5.15 if year == 2005 & state== 13

replace state_min = 6.25 if year == 2005 & state== 15 
replace state_min = 5.15 if year == 2005 & state== 16 
replace state_min = 6.50 if year == 2005 & state== 17 
replace state_min = 5.15 if year == 2005 & state== 18

replace state_min = 5.15 if year == 2005 & state== 19 
replace state_min = 2.65 if year == 2005 & state== 20 
replace state_min = 5.15 if year == 2005 & state== 21
replace state_min = 6.35 if year == 2005 & state== 23

replace state_min = 5.15 if year == 2005 & state== 24 
replace state_min = 6.75 if year == 2005 & state== 25 
replace state_min = 5.15 if year == 2005 & state== 26
replace state_min = 5.15 if year == 2005 & state== 27

replace state_min = 5.15 if year == 2005 & state== 29 
replace state_min = 5.15 if year == 2005 & state== 30
replace state_min = 5.15 if year == 2005 & state== 31
replace state_min = 5.15 if year == 2005 & state==32

replace state_min = 5.15 if year == 2005 & state== 33
replace state_min = 5.15 if year == 2005 & state== 34 
replace state_min = 5.15 if year == 2005 & state== 35 
replace state_min = 6.00 if year == 2005 & state== 36
 
replace state_min = 5.15 if year == 2005 & state== 37 
replace state_min = 5.15 if year == 2005 & state== 38 
replace state_min = 4.25 if year == 2005 & state== 39 
replace state_min = 5.15 if year == 2005 & state== 40 

replace state_min = 7.25 if year == 2005 & state== 41
replace state_min = 5.15 if year == 2005 & state== 42
replace state_min = 6.75 if year == 2005 & state== 44 
replace state_min = 5.15 if year == 2005 & state== 46
replace state_min = 5.25 if year == 2005 & state== 48 
replace state_min = 5.15 if year == 2005 & state== 49

replace state_min = 7.00 if year == 2005 & state== 50
replace state_min = 5.15 if year == 2005 & state== 51 
replace state_min = 7.35 if year == 2005 & state== 53 
replace state_min = 5.15 if year == 2005 & state== 54 

replace state_min = 5.15 if year == 2005 & state== 55 
replace state_min = 5.15 if year == 2005  & state== 56 
 
replace federal_min = 5.15 if year == 2006
 
replace state_min = 7.15 if year == 2006 & state== 2
replace state_min = 5.15 if year == 2006 & state== 5
replace state_min = 6.75 if year == 2006 & state== 6

replace state_min = 5.15 if year == 2006 & state== 8 
replace state_min = 7.40 if year == 2006 & state== 9
replace state_min = 6.15 if year == 2006 & state== 10
replace state_min = 6.40 if year == 2006 & state== 12
replace state_min = 5.15 if year == 2006 & state== 13

replace state_min = 6.75 if year == 2006 & state== 15 
replace state_min = 5.15 if year == 2006 & state== 16 
replace state_min = 6.50 if year == 2006 & state== 17 
replace state_min = 5.15 if year == 2006 & state== 18

replace state_min = 5.15 if year == 2006 & state== 19 
replace state_min = 2.65 if year == 2006 & state== 20 
replace state_min = 5.15 if year == 2006 & state== 21
replace state_min = 6.50 if year == 2006 & state== 23

replace state_min = 5.15 if year == 2006 & state== 24 
replace state_min = 6.75 if year == 2006 & state== 25 
replace state_min = 5.15 if year == 2006 & state== 26
replace state_min = 6.15 if year == 2006 & state== 27

replace state_min = 5.15 if year == 2006 & state== 29 
replace state_min = 5.15 if year == 2006 & state== 30
replace state_min = 5.15 if year == 2006 & state== 31
replace state_min = 5.15 if year == 2006 & state==32

replace state_min = 5.15 if year == 2006 & state== 33
replace state_min = 6.15 if year == 2006 & state== 34 
replace state_min = 5.15 if year == 2006 & state== 35 
replace state_min = 6.75 if year == 2006 & state== 36
 
replace state_min = 5.15 if year == 2006 & state== 37 
replace state_min = 5.15 if year == 2006 & state== 38 
replace state_min = 4.25 if year == 2006 & state== 39 
replace state_min = 5.15 if year == 2006 & state== 40 

replace state_min = 7.50 if year == 2006 & state== 41
replace state_min = 5.15 if year == 2006 & state== 42
replace state_min = 6.75 if year == 2006 & state== 44 
replace state_min = 5.15 if year == 2006 & state== 46
replace state_min = 5.25 if year == 2006 & state== 48 
replace state_min = 5.15 if year == 2006 & state== 49

replace state_min = 7.25 if year == 2006 & state== 50
replace state_min = 5.15 if year == 2006 & state== 51 
replace state_min = 7.63 if year == 2006 & state== 53 
replace state_min = 5.15 if year == 2006 & state== 54 

replace state_min = 5.70 if year == 2006 & state== 55 
replace state_min = 5.15 if year == 2006  & state== 56 
 
replace federal_min = 5.85 if year == 2007 
 
replace state_min = 7.15 if year == 2007 & state== 2
replace state_min = 6.75 if year == 2007 & state== 4
replace state_min = 6.25 if year == 2007 & state== 5
replace state_min = 7.50 if year == 2007 & state== 6

replace state_min = 6.85 if year == 2007 & state== 8 
replace state_min = 7.65 if year == 2007 & state== 9
replace state_min = 6.65 if year == 2007 & state== 10
replace state_min = 6.67 if year == 2007 & state== 12
replace state_min = 5.15 if year == 2007 & state== 13

replace state_min = 7.25 if year == 2007 & state== 15 
replace state_min = 5.15 if year == 2007 & state== 16 
replace state_min = 7.50 if year == 2007 & state== 17 
replace state_min = 5.15 if year == 2007 & state== 18

replace state_min = 5.15 if year == 2007 & state== 19 
replace state_min = 2.65 if year == 2007 & state== 20 
replace state_min = 5.15 if year == 2007 & state== 21
replace state_min = 6.75 if year == 2007 & state== 23

replace state_min = 6.15 if year == 2007 & state== 24 
replace state_min = 7.50 if year == 2007 & state== 25 
replace state_min = 6.95 if year == 2007 & state== 26
replace state_min = 6.15 if year == 2007 & state== 27

replace state_min = 6.50 if year == 2007 & state== 29 
replace state_min = 6.15 if year == 2007 & state== 30
replace state_min = 5.15 if year == 2007 & state== 31
replace state_min = 6.15 if year == 2007 & state==32

replace state_min = 5.15 if year == 2007 & state== 33
replace state_min = 7.15 if year == 2007 & state== 34 
replace state_min = 5.15 if year == 2007 & state== 35 
replace state_min = 7.15 if year == 2007 & state== 36
 
replace state_min = 6.15 if year == 2007 & state== 37 
replace state_min = 5.15 if year == 2007 & state== 38 
replace state_min = 6.85 if year == 2007 & state== 39 
replace state_min = 5.15 if year == 2007 & state== 40 

replace state_min = 7.80 if year == 2007 & state== 41
replace state_min = 6.25 if year == 2007 & state== 42
replace state_min = 7.40 if year == 2007 & state== 44 
replace state_min = 5.15 if year == 2007 & state== 46
replace state_min = 5.25 if year == 2007 & state== 48 
replace state_min = 5.15 if year == 2007 & state== 49

replace state_min = 7.53 if year == 2007 & state== 50
replace state_min = 5.15 if year == 2007 & state== 51 
replace state_min = 7.93 if year == 2007 & state== 53 
replace state_min = 5.85 if year == 2007 & state== 54 

replace state_min = 6.50 if year == 2007 & state== 55 
replace state_min = 5.15 if year == 2007  & state== 56 

replace federal_min = 5.85 if year == 2008

replace state_min = 7.15 if year == 2008 & state== 2
replace state_min = 6.90 if year == 2008 & state== 4
replace state_min = 6.25 if year == 2008 & state== 5
replace state_min = 8.00 if year == 2008 & state== 6

replace state_min = 7.02 if year == 2008 & state== 8 
replace state_min = 7.65 if year == 2008 & state== 9
replace state_min = 7.15 if year == 2008 & state== 10
replace state_min = 6.79 if year == 2008 & state== 12
replace state_min = 5.15 if year == 2008 & state== 13

replace state_min = 7.25 if year == 2008 & state== 15 
replace state_min = 5.85 if year == 2008 & state== 16 
replace state_min = 7.75 if year == 2008 & state== 17 
replace state_min = 5.85 if year == 2008 & state== 18

replace state_min = 7.25 if year == 2008 & state== 19 
replace state_min = 2.65 if year == 2008 & state== 20 
replace state_min = 5.85 if year == 2008 & state== 21
replace state_min = 7.00 if year == 2008 & state== 23

replace state_min = 6.15 if year == 2008 & state== 24 
replace state_min = 8.00 if year == 2008 & state== 25 
replace state_min = 7.15 if year == 2008 & state== 26
replace state_min = 6.15 if year == 2008 & state== 27

replace state_min = 6.65 if year == 2008 & state== 29 
replace state_min = 6.25 if year == 2008 & state== 30
replace state_min = 5.85 if year == 2008 & state== 31
replace state_min = 6.33 if year == 2008 & state==32

replace state_min = 6.50 if year == 2008 & state== 33
replace state_min = 7.15 if year == 2008 & state== 34 
replace state_min = 6.50 if year == 2008 & state== 35 
replace state_min = 7.15 if year == 2008 & state== 36
 
replace state_min = 6.15 if year == 2008 & state== 37 
replace state_min = 5.85 if year == 2008 & state== 38 
replace state_min = 7.00 if year == 2008 & state== 39 
replace state_min = 5.85 if year == 2008 & state== 40 

replace state_min = 7.95 if year == 2008 & state== 41
replace state_min = 7.15 if year == 2008 & state== 42
replace state_min = 7.40 if year == 2008 & state== 44 
replace state_min = 5.85 if year == 2008 & state== 46
replace state_min = 5.85 if year == 2008 & state== 48 
replace state_min = 5.85 if year == 2008 & state== 49

replace state_min = 7.68 if year == 2008 & state== 50
replace state_min = 5.85 if year == 2008 & state== 51 
replace state_min = 8.07 if year == 2008 & state== 53 
replace state_min = 6.55 if year == 2008 & state== 54 

replace state_min = 6.50 if year == 2008 & state== 55 
replace state_min = 5.15 if year == 2008  & state== 56 

replace federal_min = 6.55 if year == 2009

replace state_min = 7.15 if year == 2009 & state== 2
replace state_min = 7.25 if year == 2009 & state== 4
replace state_min = 6.25 if year == 2009 & state== 5
replace state_min = 8.00 if year == 2009 & state== 6

replace state_min = 7.28 if year == 2009 & state== 8 
replace state_min = 8.00 if year == 2009 & state== 9
replace state_min = 7.15 if year == 2009 & state== 10
replace state_min = 7.21 if year == 2009 & state== 12
replace state_min = 5.15 if year == 2009 & state== 13

replace state_min = 7.25 if year == 2009 & state== 15 
replace state_min = 6.55 if year == 2009 & state== 16 
replace state_min = 8.00 if year == 2009 & state== 17 
replace state_min = 6.55 if year == 2009 & state== 18

replace state_min = 7.25 if year == 2009 & state== 19 
replace state_min = 2.65 if year == 2009 & state== 20 
replace state_min = 6.55 if year == 2009 & state== 21
replace state_min = 7.25 if year == 2009 & state== 23

replace state_min = 6.55 if year == 2009 & state== 24 
replace state_min = 8.00 if year == 2009 & state== 25 
replace state_min = 7.40 if year == 2009 & state== 26
replace state_min = 6.15 if year == 2009 & state== 27

replace state_min = 7.05 if year == 2009 & state== 29 
replace state_min = 6.90 if year == 2009 & state== 30
replace state_min = 6.55 if year == 2009 & state== 31
replace state_min = 6.85 if year == 2009 & state==32

replace state_min = 7.25 if year == 2009 & state== 33
replace state_min = 7.15 if year == 2009 & state== 34 
replace state_min = 7.50 if year == 2009 & state== 35 
replace state_min = 7.15 if year == 2009 & state== 36
 
replace state_min = 6.55 if year == 2009 & state== 37 
replace state_min = 6.55 if year == 2009 & state== 38 
replace state_min = 7.30 if year == 2009 & state== 39 
replace state_min = 6.55 if year == 2009 & state== 40 

replace state_min = 8.40 if year == 2009 & state== 41
replace state_min = 7.15 if year == 2009 & state== 42
replace state_min = 7.40 if year == 2009 & state== 44 
replace state_min = 6.55 if year == 2009 & state== 46
replace state_min = 6.55 if year == 2009 & state== 48 
replace state_min = 6.55 if year == 2009 & state== 49

replace state_min = 8.06 if year == 2009 & state== 50
replace state_min = 6.55 if year == 2009 & state== 51 
replace state_min = 8.55 if year == 2009 & state== 53 
replace state_min = 7.25 if year == 2009 & state== 54 

replace state_min = 6.50 if year == 2009 & state== 55 
replace state_min = 5.15 if year == 2009  & state== 56 

replace federal_min = 7.25 if year == 2010

replace state_min = 7.75 if year == 2010 & state== 2
replace state_min = 7.25 if year == 2010 & state== 4
replace state_min = 6.25 if year == 2010 & state== 5
replace state_min = 8.00 if year == 2010 & state== 6

replace state_min = 7.24 if year == 2010 & state== 8 
replace state_min = 8.25 if year == 2010 & state== 9
replace state_min = 7.25 if year == 2010 & state== 10
replace state_min = 7.25 if year == 2010 & state== 12
replace state_min = 5.15 if year == 2010 & state== 13

replace state_min = 7.25 if year == 2010 & state== 15 
replace state_min = 7.25 if year == 2010 & state== 16 
replace state_min = 8.25 if year == 2010 & state== 17 
replace state_min =  7.25 if year == 2010 & state== 18

replace state_min = 7.25 if year == 2010 & state== 19 
replace state_min = 7.25 if year == 2010 & state== 20 
replace state_min = 7.25 if year == 2010 & state== 21
replace state_min = 7.50 if year == 2010 & state== 23

replace state_min = 7.25 if year == 2010 & state== 24 
replace state_min = 8.00 if year == 2010 & state== 25 
replace state_min = 7.40 if year == 2010 & state== 26
replace state_min = 6.15 if year == 2010 & state== 27

replace state_min = 7.25 if year == 2010 & state== 29 
replace state_min = 7.25 if year == 2010 & state== 30
replace state_min = 7.25 if year == 2010 & state== 31
replace state_min = 7.55 if year == 2010 & state==32

replace state_min = 7.25 if year == 2010 & state== 33
replace state_min = 7.25 if year == 2010 & state== 34 
replace state_min = 7.50 if year == 2010 & state== 35 
replace state_min = 7.25 if year == 2010 & state== 36
 
replace state_min = 7.25 if year == 2010 & state== 37 
replace state_min = 7.25 if year == 2010 & state== 38 
replace state_min = 7.30 if year == 2010 & state== 39 
replace state_min = 7.25 if year == 2010 & state== 40 

replace state_min = 8.40 if year == 2010 & state== 41
replace state_min = 7.25 if year == 2010 & state== 42
replace state_min = 7.40 if year == 2010 & state== 44 
replace state_min = 7.25 if year == 2010 & state== 46
replace state_min = 7.25 if year == 2010 & state== 48 
replace state_min = 7.25 if year == 2010 & state== 49

replace state_min = 8.06 if year == 2010 & state== 50
replace state_min = 7.25 if year == 2010 & state== 51 
replace state_min = 8.55 if year == 2010 & state== 53 
replace state_min = 7.25 if year == 2010 & state== 54 

replace state_min = 7.25 if year == 2010 & state== 55 
replace state_min = 5.15 if year == 2010  & state== 56 

replace federal_min = 7.25 if year == 2011

replace state_min = 7.75 if year == 2011 & state== 2
replace state_min = 7.35 if year == 2011 & state== 4
replace state_min = 6.25 if year == 2011 & state== 5
replace state_min = 8.00 if year == 2011 & state== 6

replace state_min = 7.36 if year == 2011 & state== 8 
replace state_min = 8.25 if year == 2011 & state== 9
replace state_min = 7.25 if year == 2011 & state== 10
replace state_min = 7.25 if year == 2011 & state== 12
replace state_min = 5.15 if year == 2011 & state== 13

replace state_min = 7.25 if year == 2011 & state== 15 
replace state_min = 7.25 if year == 2011 & state== 16 
replace state_min = 8.25 if year == 2011 & state== 17 
replace state_min =  7.25 if year == 2011 & state== 18

replace state_min = 7.25 if year == 2011 & state== 19 
replace state_min = 7.25 if year == 2011 & state== 20 
replace state_min = 7.25 if year == 2011 & state== 21
replace state_min = 7.50 if year == 2011 & state== 23

replace state_min = 7.25 if year == 2011 & state== 24 
replace state_min = 8.00 if year == 2011 & state== 25 
replace state_min = 7.40 if year == 2011 & state== 26
replace state_min = 6.15 if year == 2011 & state== 27

replace state_min = 7.25 if year == 2011 & state== 29 
replace state_min = 7.35 if year == 2011 & state== 30
replace state_min = 7.25 if year == 2011 & state== 31
replace state_min = 8.25 if year == 2011 & state==32

replace state_min = 7.25 if year == 2011 & state== 33
replace state_min = 7.25 if year == 2011 & state== 34 
replace state_min = 7.50 if year == 2011 & state== 35 
replace state_min = 7.25 if year == 2011 & state== 36
 
replace state_min = 7.25 if year == 2011 & state== 37 
replace state_min = 7.25 if year == 2011 & state== 38 
replace state_min = 7.40 if year == 2011 & state== 39 
replace state_min = 7.25 if year == 2011 & state== 40 

replace state_min = 8.50 if year == 2011 & state== 41
replace state_min = 7.25 if year == 2011 & state== 42
replace state_min = 7.40 if year == 2011 & state== 44 
replace state_min = 7.25 if year == 2011 & state== 46
replace state_min = 7.25 if year == 2011 & state== 48 
replace state_min = 7.25 if year == 2011 & state== 49

replace state_min = 8.15 if year == 2011 & state== 50
replace state_min = 7.25 if year == 2011 & state== 51 
replace state_min = 8.67 if year == 2011 & state== 53 
replace state_min = 7.25 if year == 2011 & state== 54 

replace state_min = 7.25 if year == 2011 & state== 55 
replace state_min = 5.15 if year == 2011  & state== 56 

replace federal_min = 7.25 if year == 2012

replace state_min = 7.75 if year == 2012 & state== 2
replace state_min = 7.65 if year == 2012 & state== 4
replace state_min = 6.25 if year == 2012 & state== 5
replace state_min = 8.00 if year == 2012 & state== 6

replace state_min = 7.64 if year == 2012 & state== 8 
replace state_min = 8.25 if year == 2012 & state== 9
replace state_min = 7.25 if year == 2012 & state== 10
replace state_min = 7.67 if year == 2012 & state== 12
replace state_min = 5.15 if year == 2012 & state== 13

replace state_min = 7.25 if year == 2012 & state== 15 
replace state_min = 7.25 if year == 2012 & state== 16 
replace state_min = 8.25 if year == 2012 & state== 17 
replace state_min = 7.25 if year == 2012 & state== 18

replace state_min = 7.25 if year == 2012 & state== 19 
replace state_min = 7.25 if year == 2012 & state== 20 
replace state_min = 7.25 if year == 2012 & state== 21
replace state_min = 7.50 if year == 2012 & state== 23

replace state_min = 7.25 if year == 2012 & state== 24 
replace state_min = 8.00 if year == 2012 & state== 25 
replace state_min = 7.40 if year == 2012 & state== 26
replace state_min = 6.15 if year == 2012 & state== 27

replace state_min = 7.25 if year == 2012 & state== 29 
replace state_min = 7.65 if year == 2012 & state== 30
replace state_min = 7.25 if year == 2012 & state== 31
replace state_min = 8.25 if year == 2012 & state==32

replace state_min = 7.25 if year == 2012 & state== 33
replace state_min = 7.25 if year == 2012 & state== 34 
replace state_min = 7.50 if year == 2012 & state== 35 
replace state_min = 7.25 if year == 2012 & state== 36
 
replace state_min = 7.25 if year == 2012 & state== 37 
replace state_min = 7.25 if year == 2012 & state== 38 
replace state_min = 7.70 if year == 2012 & state== 39 
replace state_min = 7.25 if year == 2012 & state== 40 

replace state_min = 8.80 if year == 2012 & state== 41
replace state_min = 7.25 if year == 2012 & state== 42
replace state_min = 7.40 if year == 2012 & state== 44 
replace state_min = 7.25 if year == 2012 & state== 46
replace state_min = 7.25 if year == 2012 & state== 48 
replace state_min = 7.25 if year == 2012 & state== 49

replace state_min = 8.46 if year == 2012 & state== 50
replace state_min = 7.25 if year == 2012 & state== 51 
replace state_min = 9.04 if year == 2012 & state== 53 
replace state_min = 7.25 if year == 2012 & state== 54 

replace state_min = 7.25 if year == 2012 & state== 55 
replace state_min = 5.15 if year == 2012  & state== 56 

replace federal_min = 7.25 if year == 2013

replace state_min = 7.75 if year == 2013 & state== 2
replace state_min = 7.80 if year == 2013 & state== 4
replace state_min = 6.25 if year == 2013 & state== 5
replace state_min = 8.00 if year == 2013 & state== 6

replace state_min = 7.78 if year == 2013 & state== 8 
replace state_min = 8.25 if year == 2013 & state== 9
replace state_min = 7.25 if year == 2013 & state== 10
replace state_min = 7.79 if year == 2013 & state== 12
replace state_min = 5.15 if year == 2013 & state== 13

replace state_min = 7.25 if year == 2013 & state== 15 
replace state_min = 7.25 if year == 2013 & state== 16 
replace state_min = 8.25 if year == 2013 & state== 17 
replace state_min =  7.25 if year == 2013 & state== 18

replace state_min = 7.25 if year == 2013 & state== 19 
replace state_min = 7.25 if year == 2013 & state== 20 
replace state_min = 7.25 if year == 2013 & state== 21
replace state_min = 7.50 if year == 2013 & state== 23

replace state_min = 7.25 if year == 2013 & state== 24 
replace state_min = 8.00 if year == 2013 & state== 25 
replace state_min = 7.40 if year == 2013 & state== 26
replace state_min = 6.15 if year == 2013 & state== 27

replace state_min = 7.25 if year == 2013 & state== 29 
replace state_min = 7.80 if year == 2013 & state== 30
replace state_min = 7.25 if year == 2013 & state== 31
replace state_min = 8.25 if year == 2013 & state==32

replace state_min = 7.25 if year == 2013 & state== 33
replace state_min = 7.25 if year == 2013 & state== 34 
replace state_min = 7.50 if year == 2013 & state== 35 
replace state_min = 7.25 if year == 2013 & state== 36
 
replace state_min = 7.25 if year == 2013 & state== 37 
replace state_min = 7.25 if year == 2013 & state== 38 
replace state_min = 7.85 if year == 2013 & state== 39 
replace state_min = 7.25 if year == 2013 & state== 40 

replace state_min = 8.95 if year == 2013 & state== 41
replace state_min = 7.25 if year == 2013 & state== 42
replace state_min = 7.75 if year == 2013 & state== 44 
replace state_min = 7.25 if year == 2013 & state== 46
replace state_min = 7.25 if year == 2013 & state== 48 
replace state_min = 7.25 if year == 2013 & state== 49

replace state_min = 8.60 if year == 2013 & state== 50
replace state_min = 7.25 if year == 2013 & state== 51 
replace state_min = 9.19 if year == 2013 & state== 53 
replace state_min = 7.25 if year == 2013 & state== 54 

replace state_min = 7.25 if year == 2013 & state== 55 
replace state_min = 5.15 if year == 2013  & state== 56 

replace federal_min = 7.25 if year == 2014

replace state_min = 7.75 if year == 2014 & state== 2
replace state_min = 7.90 if year == 2014 & state== 4
replace state_min = 6.25 if year == 2014 & state== 5
replace state_min = 9.00 if year == 2014 & state== 6

replace state_min = 8.00 if year == 2014 & state== 8 
replace state_min = 8.70 if year == 2014 & state== 9
replace state_min = 7.75 if year == 2014 & state== 10
replace state_min = 7.93 if year == 2014 & state== 12
replace state_min = 5.15 if year == 2014 & state== 13

replace state_min = 7.25 if year == 2014 & state== 15 
replace state_min = 7.25 if year == 2014 & state== 16 
replace state_min = 8.25 if year == 2014 & state== 17 
replace state_min = 7.25 if year == 2014 & state== 18

replace state_min = 7.25 if year == 2014 & state== 19 
replace state_min = 7.25 if year == 2014 & state== 20 
replace state_min = 7.25 if year == 2014 & state== 21
replace state_min = 7.50 if year == 2014 & state== 23

replace state_min = 7.25 if year == 2014 & state== 24 
replace state_min = 8.00 if year == 2014 & state== 25 
replace state_min = 8.15 if year == 2014 & state== 26
replace state_min = 8.00 if year == 2014 & state== 27

replace state_min = 7.50 if year == 2014 & state== 29 
replace state_min = 7.90 if year == 2014 & state== 30
replace state_min = 7.25 if year == 2014 & state== 31
replace state_min = 8.25 if year == 2014 & state==32

replace state_min = 7.25 if year == 2014 & state== 33
replace state_min = 8.25 if year == 2014 & state== 34 
replace state_min = 7.50 if year == 2014 & state== 35 
replace state_min = 8.00 if year == 2014 & state== 36
 
replace state_min = 7.25 if year == 2014 & state== 37 
replace state_min = 7.25 if year == 2014 & state== 38 
replace state_min = 7.95 if year == 2014 & state== 39 
replace state_min = 7.25 if year == 2014 & state== 40 

replace state_min = 9.10 if year == 2014 & state== 41
replace state_min = 7.25 if year == 2014 & state== 42
replace state_min = 8.00 if year == 2014 & state== 44 
replace state_min = 7.25 if year == 2014 & state== 46
replace state_min = 7.25 if year == 2014 & state== 48 
replace state_min = 7.25 if year == 2014 & state== 49

replace state_min = 8.73 if year == 2014 & state== 50
replace state_min = 7.25 if year == 2014 & state== 51 
replace state_min = 9.32 if year == 2014 & state== 53 
replace state_min = 7.25 if year == 2014 & state== 54 

replace state_min = 7.25 if year == 2014 & state== 55 
replace state_min = 5.15 if year == 2014  & state== 56 

replace federal_min = 7.25 if year == 2015

replace state_min = 8.75 if year == 2015 & state== 2
replace state_min = 8.05 if year == 2015 & state== 4
replace state_min = 7.50 if year == 2015 & state== 5
replace state_min = 9.00 if year == 2015 & state== 6

replace state_min = 8.23 if year == 2015 & state== 8 
replace state_min = 9.15 if year == 2015 & state== 9
replace state_min = 8.25 if year == 2015 & state== 10
replace state_min = 8.05 if year == 2015 & state== 12
replace state_min = 5.15 if year == 2015 & state== 13

replace state_min = 7.75 if year == 2015 & state== 15 
replace state_min = 7.25 if year == 2015 & state== 16 
replace state_min = 8.25 if year == 2015 & state== 17 
replace state_min = 7.25 if year == 2015 & state== 18

replace state_min = 7.25 if year == 2015 & state== 19 
replace state_min = 7.25 if year == 2015 & state== 20 
replace state_min = 7.25 if year == 2015 & state== 21
replace state_min = 7.50 if year == 2015 & state== 23

replace state_min = 8.25 if year == 2015 & state== 24 
replace state_min = 9.00 if year == 2015 & state== 25 
replace state_min = 8.15 if year == 2015 & state== 26
replace state_min = 9.00 if year == 2015 & state== 27

replace state_min = 7.65 if year == 2015 & state== 29 
replace state_min = 8.05 if year == 2015 & state== 30
replace state_min = 8.00 if year == 2015 & state== 31
replace state_min = 8.25 if year == 2015 & state==32

replace state_min = 7.25 if year == 2015 & state== 33
replace state_min = 8.38 if year == 2015 & state== 34 
replace state_min = 7.50 if year == 2015 & state== 35 
replace state_min = 8.75 if year == 2015 & state== 36
 
replace state_min = 7.25 if year == 2015 & state== 37 
replace state_min = 7.25 if year == 2015 & state== 38 
replace state_min = 8.10 if year == 2015 & state== 39 
replace state_min = 7.25 if year == 2015 & state== 40 

replace state_min = 9.25 if year == 2015 & state== 41
replace state_min = 7.25 if year == 2015 & state== 42
replace state_min = 9.00 if year == 2015 & state== 44 
replace state_min = 8.50 if year == 2015 & state== 46
replace state_min = 7.25 if year == 2015 & state== 48 
replace state_min = 7.25 if year == 2015 & state== 49

replace state_min = 9.15 if year == 2015 & state== 50
replace state_min = 7.25 if year == 2015 & state== 51 
replace state_min = 9.47 if year == 2015 & state== 53 
replace state_min = 8.00 if year == 2015 & state== 54 

replace state_min = 7.25 if year == 2015 & state== 55 
replace state_min = 5.15 if year == 2015  & state== 56 

replace federal_min = 7.25 if year == 2016

replace state_min = 9.75 if year == 2016 & state== 2
replace state_min = 8.05 if year == 2016 & state== 4
replace state_min = 8.00 if year == 2016 & state== 5
replace state_min = 10.00 if year == 2016 & state== 6

replace state_min = 8.31 if year == 2016 & state== 8 
replace state_min = 9.60 if year == 2016 & state== 9
replace state_min = 8.25 if year == 2016 & state== 10
replace state_min = 8.05 if year == 2016 & state== 12
replace state_min = 5.15 if year == 2016 & state== 13

replace state_min = 8.50 if year == 2016 & state== 15 
replace state_min = 7.25 if year == 2016 & state== 16 
replace state_min = 8.25 if year == 2016 & state== 17 
replace state_min = 7.25 if year == 2016 & state== 18

replace state_min = 7.25 if year == 2016 & state== 19 
replace state_min = 7.25 if year == 2016 & state== 20 
replace state_min = 7.25 if year == 2016 & state== 21
replace state_min = 7.50 if year == 2016 & state== 23

replace state_min = 8.75 if year == 2016 & state== 24 
replace state_min = 10.00 if year == 2016 & state== 25 
replace state_min = 8.50 if year == 2016 & state== 26
replace state_min = 9.50 if year == 2016 & state== 27

replace state_min = 7.65 if year == 2016 & state== 29 
replace state_min = 8.05 if year == 2016 & state== 30
replace state_min = 9.00 if year == 2016 & state== 31
replace state_min = 8.25 if year == 2016 & state==32

replace state_min = 7.25 if year == 2016 & state== 33
replace state_min = 8.38 if year == 2016 & state== 34 
replace state_min = 7.50 if year == 2016 & state== 35 
replace state_min = 9.00 if year == 2016 & state== 36
 
replace state_min = 7.25 if year == 2016 & state== 37 
replace state_min = 7.25 if year == 2016 & state== 38 
replace state_min = 8.10 if year == 2016 & state== 39 
replace state_min = 7.25 if year == 2016 & state== 40 

replace state_min = 9.75 if year == 2016 & state== 41
replace state_min = 7.25 if year == 2016 & state== 42
replace state_min = 9.60 if year == 2016 & state== 44 
replace state_min = 8.55 if year == 2016 & state== 46
replace state_min = 7.25 if year == 2016 & state== 48 
replace state_min = 7.25 if year == 2016 & state== 49

replace state_min = 9.60 if year == 2016 & state== 50
replace state_min = 7.25 if year == 2016 & state== 51 
replace state_min = 9.47 if year == 2016 & state== 53 
replace state_min = 8.75 if year == 2016 & state== 54 

replace state_min = 7.25 if year == 2016 & state== 55 
replace state_min = 5.15 if year == 2016  & state== 56 

replace federal_min = 7.25 if year == 2017

replace state_min = 9.80 if year == 2017 & state== 2
replace state_min = 10.00 if year == 2017 & state== 4
replace state_min = 8.50 if year == 2017 & state== 5
replace state_min = 10.00 if year == 2017 & state== 6

replace state_min = 9.30 if year == 2017 & state== 8 
replace state_min = 10.10 if year == 2017 & state== 9
replace state_min = 8.25 if year == 2017 & state== 10
replace state_min = 8.10 if year == 2017 & state== 12
replace state_min = 5.15 if year == 2017 & state== 13

replace state_min = 9.25 if year == 2017 & state== 15 
replace state_min = 7.25 if year == 2017 & state== 16 
replace state_min = 8.25 if year == 2017 & state== 17 
replace state_min =  7.25 if year == 2017 & state== 18

replace state_min = 7.25 if year == 2017 & state== 19 
replace state_min = 7.25 if year == 2017 & state== 20 
replace state_min = 7.25 if year == 2017 & state== 21
replace state_min = 9.00 if year == 2017 & state== 23

replace state_min = 8.75 if year == 2017 & state== 24 
replace state_min = 11.00 if year == 2017 & state== 25 
replace state_min = 8.90 if year == 2017 & state== 26
replace state_min = 9.50 if year == 2017 & state== 27

replace state_min = 7.70 if year == 2017 & state== 29 
replace state_min = 8.15 if year == 2017 & state== 30
replace state_min = 9.00 if year == 2017 & state== 31
replace state_min = 8.25 if year == 2017 & state==32

replace state_min = 7.25 if year == 2017 & state== 33
replace state_min = 8.44 if year == 2017 & state== 34 
replace state_min = 7.50 if year == 2017 & state== 35 
replace state_min = 9.70 if year == 2017 & state== 36
 
replace state_min = 7.25 if year == 2017 & state== 37 
replace state_min = 7.25 if year == 2017 & state== 38 
replace state_min = 8.15 if year == 2017 & state== 39 
replace state_min = 7.25 if year == 2017 & state== 40 

replace state_min = 9.75 if year == 2017 & state== 41
replace state_min = 7.25 if year == 2017 & state== 42
replace state_min = 9.60 if year == 2017 & state== 44 
replace state_min = 8.65 if year == 2017 & state== 46
replace state_min = 7.25 if year == 2017 & state== 48 
replace state_min = 7.25 if year == 2017 & state== 49

replace state_min = 10.00 if year == 2017 & state== 50
replace state_min = 7.25 if year == 2017 & state== 51 
replace state_min = 11.00 if year == 2017 & state== 53 
replace state_min = 8.75 if year == 2017 & state== 54 

replace state_min = 7.25 if year == 2017 & state== 55 
replace state_min = 5.15 if year == 2017  & state== 56 

replace federal_min = 7.25 if year == 2018

replace state_min = 9.84 if year == 2018 & state== 2
replace state_min = 10.50 if year == 2018 & state== 4
replace state_min = 8.50 if year == 2018 & state== 5
replace state_min = 11.00 if year == 2018 & state== 6

replace state_min = 10.20 if year == 2018 & state== 8 
replace state_min = 10.10 if year == 2018 & state== 9
replace state_min = 8.25 if year == 2018 & state== 10
replace state_min = 8.25 if year == 2018 & state== 12
replace state_min = 5.15 if year == 2018 & state== 13

replace state_min = 10.10 if year == 2018 & state== 15 
replace state_min = 7.25 if year == 2018 & state== 16 
replace state_min = 8.25 if year == 2018 & state== 17 
replace state_min =  7.25 if year == 2018 & state== 18

replace state_min = 7.25 if year == 2018 & state== 19 
replace state_min = 7.25 if year == 2018 & state== 20 
replace state_min = 7.25 if year == 2018 & state== 21
replace state_min = 10.00 if year == 2018 & state== 23

replace state_min = 10.10 if year == 2018 & state== 24 
replace state_min = 11.00 if year == 2018 & state== 25 
replace state_min = 9.25 if year == 2018 & state== 26
replace state_min = 9.86 if year == 2018 & state== 27

replace state_min = 7.85 if year == 2018 & state== 29 
replace state_min = 8.30 if year == 2018 & state== 30
replace state_min = 9.00 if year == 2018 & state== 31
replace state_min = 8.25 if year == 2018 & state==32

replace state_min = 7.25 if year == 2018 & state== 33
replace state_min = 8.60 if year == 2018 & state== 34 
replace state_min = 7.50 if year == 2018 & state== 35 
replace state_min = 10.40 if year == 2018 & state== 36
 
replace state_min = 7.25 if year == 2018 & state== 37 
replace state_min = 7.25 if year == 2018 & state== 38 
replace state_min = 8.30 if year == 2018 & state== 39 
replace state_min = 7.25 if year == 2018 & state== 40 

replace state_min = 10.75 if year == 2018 & state== 41
replace state_min = 7.25 if year == 2018 & state== 42
replace state_min = 10.10 if year == 2018 & state== 44 
replace state_min = 8.85 if year == 2018 & state== 46
replace state_min = 7.25 if year == 2018 & state== 48 
replace state_min = 7.25 if year == 2018 & state== 49

replace state_min = 10.50 if year == 2018 & state== 50
replace state_min = 7.25 if year == 2018 & state== 51 
replace state_min = 11.50 if year == 2018 & state== 53 
replace state_min = 8.75 if year == 2018 & state== 54 

replace state_min = 7.25 if year == 2018 & state== 55 
replace state_min = 5.15 if year == 2018  & state== 56 

replace federal_min = 7.25 if year == 2019

replace state_min = 10.19 if year == 2019 & state== 2
replace state_min = 12.00 if year == 2019 & state== 4
replace state_min = 9.25 if year == 2019 & state== 5
replace state_min = 12.00 if year == 2019 & state== 6

replace state_min = 12.00 if year == 2019 & state== 8 
replace state_min = 11.00 if year == 2019 & state== 9
replace state_min = 9.25 if year == 2019 & state== 10
replace state_min = 8.56 if year == 2019 & state== 12
replace state_min = 5.15 if year == 2019 & state== 13

replace state_min = 10.10 if year == 2019 & state== 15 
replace state_min = 7.25 if year == 2019 & state== 16 
replace state_min = 9.25 if year == 2019 & state== 17 
replace state_min =  7.25 if year == 2019 & state== 18

replace state_min = 7.25 if year == 2019 & state== 19 
replace state_min = 7.25 if year == 2019 & state== 20 
replace state_min = 7.25 if year == 2019 & state== 21
replace state_min = 12.00 if year == 2019 & state== 23

replace state_min = 11.00 if year == 2019 & state== 24 
replace state_min = 12.75 if year == 2019 & state== 25 
replace state_min = 9.65 if year == 2019 & state== 26
replace state_min = 10.00 if year == 2019 & state== 27

replace state_min = 9.45 if year == 2019 & state== 29 
replace state_min = 8.65 if year == 2019 & state== 30
replace state_min = 9.00 if year == 2019 & state== 31
replace state_min = 8.25 if year == 2019 & state==32

replace state_min = 7.25 if year == 2019 & state== 33
replace state_min = 11.00 if year == 2019 & state== 34 
replace state_min = 9.00 if year == 2019 & state== 35 
replace state_min = 11.80 if year == 2019 & state== 36
 
replace state_min = 7.25 if year == 2019 & state== 37 
replace state_min = 7.25 if year == 2019 & state== 38 
replace state_min = 8.70 if year == 2019 & state== 39 
replace state_min = 7.25 if year == 2019 & state== 40 

replace state_min = 11.25 if year == 2019 & state== 41
replace state_min = 7.25 if year == 2019 & state== 42
replace state_min = 10.50 if year == 2019 & state== 44 
replace state_min = 9.30 if year == 2019 & state== 46
replace state_min = 7.25 if year == 2019 & state== 48 
replace state_min = 7.25 if year == 2019 & state== 49

replace state_min = 10.96 if year == 2019 & state== 50
replace state_min = 7.25 if year == 2019 & state== 51 
replace state_min = 13.50 if year == 2019 & state== 53 
replace state_min = 8.75 if year == 2019 & state== 54 

replace state_min = 7.25 if year == 2019 & state== 55 
replace state_min = 5.15 if year == 2019  & state== 56 

replace federal_min = 7.25 if year == 2020

replace state_min = 10.19 if year == 2020 & state== 2
replace state_min = 12.00 if year == 2020 & state== 4
replace state_min = 10.00 if year == 2020 & state== 5
replace state_min = 12.00 if year == 2020 & state== 6

replace state_min = 12.02 if year == 2020 & state== 8 
replace state_min = 12.00 if year == 2020 & state== 9
replace state_min = 9.25 if year == 2020 & state== 10
replace state_min = 8.56 if year == 2020 & state== 12
replace state_min = 5.15 if year == 2020 & state== 13

replace state_min = 10.10 if year == 2020 & state== 15 
replace state_min = 7.25 if year == 2020 & state== 16 
replace state_min = 10.00 if year == 2020 & state== 17 
replace state_min =  7.25 if year == 2020 & state== 18

replace state_min = 7.25 if year == 2020 & state== 19 
replace state_min = 7.25 if year == 2020 & state== 20 
replace state_min = 7.25 if year == 2020 & state== 21
replace state_min = 12.00 if year == 2020 & state== 23

replace state_min = 11.00 if year == 2020 & state== 24 
replace state_min = 12.75 if year == 2020 & state== 25 
replace state_min = 9.65 if year == 2020 & state== 26
replace state_min = 10.00 if year == 2020 & state== 27

replace state_min = 9.45 if year == 2020 & state== 29 
replace state_min = 8.65 if year == 2020 & state== 30
replace state_min = 9.00 if year == 2020 & state== 31
replace state_min = 9.00 if year == 2020 & state==32

replace state_min = 7.25 if year == 2020 & state== 33
replace state_min = 11.00 if year == 2020 & state== 34 
replace state_min = 9.00 if year == 2020 & state== 35 
replace state_min = 11.80 if year == 2020 & state== 36
 
replace state_min = 7.25 if year == 2020 & state== 37 
replace state_min = 7.25 if year == 2020 & state== 38 
replace state_min = 8.70 if year == 2020 & state== 39 
replace state_min = 7.25 if year == 2020 & state== 40 

replace state_min = 12.00 if year == 2020 & state== 41
replace state_min = 7.25 if year == 2020 & state== 42
replace state_min = 11.50 if year == 2020 & state== 44 
replace state_min = 9.30 if year == 2020 & state== 46
replace state_min = 7.25 if year == 2020 & state== 48 
replace state_min = 7.25 if year == 2020 & state== 49

replace state_min = 10.96 if year == 2020 & state== 50
replace state_min = 7.25 if year == 2020 & state== 51 
replace state_min = 13.50 if year == 2020  & state== 53 
replace state_min = 8.75 if year == 2020  & state== 54 

replace state_min = 7.25 if year == 2019 & state== 55 
replace state_min = 5.15 if year == 2019  & state== 56 

replace federal_min = 7.25 if year == 2021

replace state_min = 10.34 if year == 2021 & state== 2
replace state_min = 12.15 if year == 2021  & state== 4
replace state_min = 10.00 if year == 2021  & state== 5
replace state_min = 13.00 if year == 2021 & state== 6

replace state_min = 12.02 if year == 2021 & state== 8 
replace state_min = 12.00 if year == 2021 & state== 9
replace state_min = 9.25 if year == 2021 & state== 10
replace state_min = 11.00 if year == 2021 & state== 12
replace state_min = 5.15 if year == 2021 & state== 13

replace state_min = 10.10 if year == 2021 & state== 15 
replace state_min = 7.25 if year == 2021 & state== 16 
replace state_min = 10.00 if year == 2021 & state== 17 
replace state_min = 7.25 if year == 2021 & state== 18

replace state_min = 7.25 if year == 2021 & state== 19 
replace state_min = 7.25 if year == 2021 & state== 20 
replace state_min = 7.25 if year == 2021 & state== 21
replace state_min = 12.15 if year == 2021 & state== 23

replace state_min = 11.75 if year == 2021 & state== 24 
replace state_min = 13.50 if year == 2021 & state== 25 
replace state_min = 9.65 if year == 2021 & state== 26
replace state_min = 10.08 if year == 2021 & state== 27

replace state_min = 10.30 if year == 2021 & state== 29 
replace state_min = 8.75 if year == 2021 & state== 30
replace state_min = 9.00 if year == 2021 & state== 31
replace state_min = 9.75 if year == 2021 & state==32

replace state_min = 7.25 if year == 2021 & state== 33
replace state_min = 12.00 if year == 2021 & state== 34 
replace state_min = 10.50 if year == 2021 & state== 35 
replace state_min = 12.50 if year == 2021 & state== 36
 
replace state_min = 7.25 if year == 2021 & state== 37 
replace state_min = 7.25 if year == 2021 & state== 38 
replace state_min = 8.80 if year == 2021 & state== 39 
replace state_min = 7.25 if year == 2021 & state== 40 

replace state_min = 12.75 if year == 2021 & state== 41
replace state_min = 7.25 if year == 2021 & state== 42
replace state_min = 11.50 if year == 2021 & state== 44 
replace state_min = 9.45 if year == 2021 & state== 46
replace state_min = 7.25 if year == 2021 & state== 48 
replace state_min = 7.25 if year == 2021 & state== 49

replace state_min = 11.75 if year == 2021 & state== 50
replace state_min = 9.50 if year == 2021 & state== 51 
replace state_min = 13.69 if year == 2021 & state== 53 
replace state_min = 8.75 if year == 2021 & state== 54 

replace state_min = 7.25 if year == 2021 & state== 55 
replace state_min = 5.15 if year == 2021  & state== 56 




gen min_wage = federal_min 
replace min_wage = state_min if state_min > federal_min

gen cpi=0  
replace cpi=184.0 if year==2003  
replace cpi=188.9 if year==2004
replace cpi=195.3 if year==2005

replace cpi=201.6 if year==2006
replace cpi=207.34 if year==2007
replace cpi=215.30 if year==2008
replace cpi=214.53 if year==2009

replace cpi=218.05 if year==2010
replace cpi=224.93 if year==2011
replace cpi=229.59 if year==2012
replace cpi=232.95 if year==2013

replace cpi=236.73 if year==2014
replace cpi=237.01 if year==2015
replace cpi=240.00 if year==2016
replace cpi=245.12 if year==2017

replace cpi=251.10 if year==2018
replace cpi=255.65 if year==2019
replace cpi= 258.811 if year==2020
replace cpi= 270.970 if year==2021

gen mwage=(min_wage)*(270.970/cpi)  

gen unemployed=(pemlr==3 | pemlr==4)

gen mwage_black=mwage*black
gen mwage_hispanic=mwage*hispanic
gen mwage_other=mwage*other

compress

label variable mwage "Minimum wage"
label variable mwage_black "Minimum wage for blacks"
label variable mwage_hispanic "Minimum wage for hispanics"
label variable mwage_other "Minimum wage for other"



label variable age 		"Age"
label variable agesq 	"Age squared"
label variable less_hi	"Less than high school"
label variable hi_sch	"High school"
label variable some_col	"Some college"
label variable more_col "College or higher"
label variable white	"Non-Hispanic white"
label variable black	"Non-Hispani black"
label variable hispanic	"Hispanic"
label variable other	"Other race/ethnicity"
label variable married	"Married"
label variable msa		"Metropolitan Statistical Area"

su unemployed mwage white black hispanic other age married female less_hi hi_sch some_col more_col msa 
outreg2 using table1.doc, dec(3) replace label title("Table 1 Descriptive Statistics") sum(log) eqkeep(mean sd) ///
        keep(unemployed mwage white black hispanic other age married female less_hi hi_sch some_col more_col msa )

svy: regress unemployed mwage black hispanic other age agesq married female hi_sch some_col more_col msa i.hrmonth i.year i.state
outreg2 using table2.doc, bdec(3) replace label title("Table 2 Regression Results") ctitle("All") ///
        keep(mwage black hispanic other age agesq married female hi_sch some_col more_col msa)

svy: regress unemployed mwage black hispanic other age agesq married female hi_sch some_col more_col msa i.hrmonth i.year i.state if white==1
outreg2 using table2.doc, bdec(3) append label title("Table 2 Regression Results") ctitle("White") ///
        keep(mwage black hispanic other age agesq married female hi_sch some_col more_col msa)

svy: regress unemployed mwage black hispanic other age agesq married female hi_sch some_col more_col msa i.hrmonth i.year i.state if black==1
outreg2 using table2.doc, bdec(3) append label title("Table 2 Regression Results") ctitle("Black") ///
        keep(mwage black hispanic other age agesq married female hi_sch some_col more_col msa)

svy: regress unemployed mwage black hispanic other age agesq married female hi_sch some_col more_col msa i.hrmonth i.year i.state if hispanic==1
outreg2 using table2.doc, bdec(3) append label title("Table 2 Regression Results") ctitle("Hispanic") ///
        keep(mwage black hispanic other age agesq married female hi_sch some_col more_col msa)

log close