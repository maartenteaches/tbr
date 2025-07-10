cscript

cd "c:\active\pre-course\tbr"
use bench/nlsw88

sum wage, detail
tempname p90 m10 m90
scalar `p90' = r(p90)
sum collgrad  if wage <= r(p10)
scalar `m10' = r(mean)
sum collgrad  if wage >= `p90' & !missing(wage)
scalar `m90' = r(mean)

tbr collgrad, income(wage)
assert reldif(r(tbr), `m90'/`m10') < 1e-8

tempname true
matrix `true' = J(3,1,.)
forvalues i = 1/3 {
	sum wage if race == `i', detail
	scalar `p90' = r(p90)
	sum collgrad  if wage <= r(p10) & race == `i'
	scalar `m10' = r(mean)
	sum collgrad  if wage >= `p90' & !missing(wage) & race == `i'
	scalar `m90' = r(mean)	
	matrix `true'[`i',1] = `m90'/`m10'
}
matlist `true'
tbr collgrad, income(wage) over(race)
assert mreldif(`true', r(tbr)) < 1e-8

label define racelbl 2 "	", modify
tbr collgrad, income(wage) over(race)
local rown : rownames r(tbr)
assert "`rown'" == "White r2 Other"

label define racelbl 2 "  ", modify
tbr collgrad, income(wage) over(race)
local rown : rownames r(tbr)
assert "`rown'" == "White r2 Other"

label define racelbl 2 " ", modify
tbr collgrad, income(wage) over(race)
local rown : rownames r(tbr)
assert "`rown'" == "White r2 Other"

label define racelbl 2 "bla: blup", modify
tbr collgrad, income(wage) over(race)
local rown : rownames r(tbr), quoted
assert `"`rown'"' == `"`"White"' `"bla; blup"' `"Other"'"'

label define racelbl 2 "this is a realy long label: it is probably way too long to fit in a matrix", modify
tbr collgrad, income(wage) over(race)
local rown : rownames r(tbr), quoted
assert `"`rown'"' == `"`"White"' `"this is a realy long label; it i"' `"Other"'"'

