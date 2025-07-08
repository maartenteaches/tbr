*! version 0.1.0 MLB 01Jul2025
program define tbr, rclass
	version 18
	syntax varname(numeric) [if] [in] [pw], INCome(varname numeric) ///
	     [over(varname numeric)]
	
	marksample touse
	markout `touse' `income'
	if "`weight'" != ""	local wght = "[`weight' `exp']"
	
	if "`over'" == "" {
		Comp `varlist' if `touse' `wght', income(`income')
		display as txt "The top-bottom ratio is " as result %9.3f r(tbr)
	}
	else {
		markout `touse' `over'
		capture assert mod(`over',1) == 0 if `touse'
		if _rc {
			di as err "{p}the variable specified in over() can only contain positive integers{p_end}"
			exit 198
		}
		capture assert `over' >= 0 if `touse'
		if _rc {
			di as err "{p}the variable specified in over() can only contain positive integers{p_end}"
			exit 198
		}
		
		tempname res
		qui levelsof `over' if `touse'
		local levs = r(levels)
		matrix `res' = J(r(r),1,.)
		local i = 1
		foreach lev of local levs {
			Comp `varlist' if `touse' & `over' == `lev' `wght', income(`income')
			matrix `res'[`i++',1] = r(tbr)
			local rownames = "`rownames' `: label (`over') `lev''"
		}
		matrix rownames `res' = `rownames'
		matrix colnames `res' = "tbr"
		matlist `res'
		return matrix tbr = `res'
	}
end

program define Comp, rclass 
	syntax varname(numeric) [if] [pw], INCome(varname numeric) 
	marksample touse
	if "`weight'" != ""	{
		local wght = "[`weight' `exp']"
		local awght = "[aw `exp']"
	}
	
	tempname l h
	_pctile `income' `wght' if `touse', percentiles(10 90)
	local low = r(r1)
	local high = r(r2)
	
	sum `varlist' `awght' if `touse' & `income' <= `low', meanonly
	scalar `l' = r(mean)
	sum `varlist' `awght' if `touse' & `income' >= `high', meanonly
	scalar `h' = r(mean)
	return scalar tbr = `h'/`l'
end
